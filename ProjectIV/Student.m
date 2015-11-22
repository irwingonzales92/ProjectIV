//
//  Student.m
//  
//
//  Created by Irwin Gonzales on 11/16/15.
//
//

#import "Student.h"
#import <PFObject+Subclass.h>

@implementation Student

@dynamic displayName;
@dynamic gpa;
@dynamic clinical_hours;
@dynamic science;
@dynamic degree_choice;
@dynamic gre;
@dynamic password;

+ (void)load
{
    [self registerSubclass];
}

+ (NSString *)parseClassName
{
    return @"_User";
}

@end
