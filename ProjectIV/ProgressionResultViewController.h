//
//  ViewController.h
//  ProjectIV
//
//  Created by Irwin Gonzales on 10/23/15.
//  Copyright (c) 2015 Irwin Gonzales. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Student.h"
#import "School.h"

@interface ProgressionResultViewController : UIViewController

@property (strong, nonatomic) School *school;
@property (strong, nonatomic) Student *student;

@end

