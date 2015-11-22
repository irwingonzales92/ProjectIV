//
//  School.m
//  
//
//  Created by Irwin Gonzales on 11/16/15.
//
//

#import "School.h"
#import "Student.h"
#import <PFObject+Subclass.h>

@implementation School

@dynamic name;
@dynamic gpa;
@dynamic clinical_hours;
@dynamic science;
@dynamic degree_choice;
@dynamic gre;
@dynamic websitelink;
@dynamic locationCoordinate;

+ (void)load
{
    [self registerSubclass];
}

+ (NSString *)parseClassName
{
    return @"School";
}

+ (NSNumber *)compareForPieChart:(NSNumber *)studentNumber withSchoolNumber:(NSNumber *)schoolNumber
{
    {
        Student *user = [Student currentUser];
        School *school = [[School alloc]init];
        int schoolMultiplier  = [school.gpa intValue];
        int studentMultiplier = [user.gpa intValue];

        int resultMultiplier = (studentMultiplier % schoolMultiplier);

        NSNumber *result = [NSNumber numberWithInt:resultMultiplier];

        return result;
    }
}



@end
