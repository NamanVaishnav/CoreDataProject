//
//  newPersonViewController.h
//  contacts
//
//  Created by student on 10/04/15.
//  Copyright (c) 2015 WiMC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface newPersonViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *fistname;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *age;
- (IBAction)addButtonClicked:(UIButton *)sender;
- (IBAction)cancelClicked:(UIButton *)sender;

@end
