//
//  Student.h
//  
//
//  Created by Irwin Gonzales on 11/16/15.
//
//

#import <Parse/Parse.h>

@interface Student : PFUser<PFSubclassing>

+ (NSString *)parseClassName;

@property (strong, nonatomic) NSString *displayName;
@property (strong, nonatomic) NSNumber *gpa;
@property (strong, nonatomic) NSNumber *clinical_hours;
@property (strong, nonatomic) NSString *science;
@property (strong, nonatomic) NSString *degree_choice;
@property (strong, nonatomic) NSString *gre;
@property (strong, nonatomic) NSString *password;


@end
