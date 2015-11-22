//
//  User.m
//  
//
//  Created by Irwin Gonzales on 11/16/15.
//
//

#import "User.h"
#import <Parse/PFObject+Subclass.h>

@implementation User

+ (void)load
{
    [self registerSubclass];
}

+ (NSString *)user
{
    return: @"user";
}

@end
