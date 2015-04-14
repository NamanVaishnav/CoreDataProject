//
//  personTableViewController.m
//  contacts
//
//  Created by student on 10/04/15.
//  Copyright (c) 2015 WiMC. All rights reserved.
//

#import "personTableViewController.h"
#import "AppDelegate.h"
@import CoreData;
#import "Person.h"

@interface personTableViewController ()<NSFetchedResultsControllerDelegate>
    @property(strong, nonatomic)NSFetchedResultsController *frc;
@end

@implementation personTableViewController

-(NSManagedObjectContext *)moc {
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    return delegate.managedObjectContext;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Person"];
    NSSortDescriptor *sortFirstName = [[NSSortDescriptor alloc]initWithKey:@"age" ascending:YES];
    request.sortDescriptors = @[sortFirstName];
    
    self.frc = [[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:[self moc] sectionNameKeyPath:nil cacheName:nil];
    
    self.frc.delegate  = self;
    [self.frc performFetch:nil];
    
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath{
    if (type == NSFetchedResultsChangeDelete) {
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else if (type == NSFetchedResultsChangeInsert){
        [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    id<NSFetchedResultsSectionInfo> sectionInfo = self.frc.sections[section];
    return sectionInfo.numberOfObjects;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"personCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    Person *person = [self.frc objectAtIndexPath:indexPath];
    
    cell.textLabel.text = [person.firstName stringByAppendingFormat:@"  %@",person.lastName];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Age %@",person.age];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        Person *personToDelete = [self.frc objectAtIndexPath:indexPath];
        
        [[self moc] deleteObject:personToDelete];
        
        if ([personToDelete isDeleted]) {
            [[self moc] save:nil];
        }
            } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
