//
//  Person.h
//  contacts
//
//  Created by student on 10/04/15.
//  Copyright (c) 2015 WiMC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Person : NSManagedObject

@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSNumber * age;

@end
