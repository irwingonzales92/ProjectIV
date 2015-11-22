//
//  School.h
//  
//
//  Created by Irwin Gonzales on 11/16/15.
//
//

#import <Parse/Parse.h>

@protocol SchoolClassDelegate <NSObject>

+ (NSNumber *)compareForPieChart:(NSNumber *)studentNumber withSchoolNumber:(NSNumber *)schoolNumber;
//+ (BOOL *)compare

@end

@interface School : PFObject <PFSubclassing>

+ (NSString *)parseClassName;

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSNumber *gpa;
@property (strong, nonatomic) NSNumber *clinical_hours;
@property (strong, nonatomic) NSString *science;
@property (strong, nonatomic) NSString *degree_choice;
@property (strong, nonatomic) NSString *gre;
@property (strong, nonatomic) NSString *websitelink;
@property (strong, nonatomic) PFGeoPoint *locationCoordinate;

@end
