//
//  newPersonViewController.m
//  contacts
//
//  Created by student on 10/04/15.
//  Copyright (c) 2015 WiMC. All rights reserved.
//

#import "newPersonViewController.h"
#import "Person.h"
@import CoreData;
#import "AppDelegate.h"


@interface newPersonViewController ()

@end

@implementation newPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(NSManagedObjectContext *)moc {
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    return delegate.managedObjectContext;
}

- (IBAction)addButtonClicked:(UIButton *)sender {
    if ([self.fistname.text isEqualToString:@""] || [self.lastName.text isEqualToString:@""] || [self.age.text isEqualToString:@""]) {
        //alert
    }
    else{
        Person *newPerson = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:[self moc]];
        
        if (newPerson != nil) {
            newPerson.firstName = self.fistname.text;
            newPerson.lastName = self.lastName.text;
            newPerson.age = @([self.age.text integerValue]);
        }
        [[self moc] save:nil];
        
        [self cancelClicked:sender];
    }
}

- (IBAction)cancelClicked:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
