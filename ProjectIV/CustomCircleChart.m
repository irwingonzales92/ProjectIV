//
//  GPACircleChart.m
//  
//
//  Created by Irwin Gonzales on 11/21/15.
//
//

#import "CustomCircleChart.h"

@implementation CustomCircleChart

+ (CustomCircleChart *)createGPACircleChartTableView: (UITableView *)tableView
                                          Student: (Student *)student
                                           School: (School *)school
{
    CGFloat schoolMultiplier  = [school.gpa floatValue];
    CGFloat studentMultiplier = [student.gpa doubleValue];
    CGFloat resultMultiplier = (studentMultiplier / schoolMultiplier);
    NSNumber *result = [NSNumber numberWithFloat:resultMultiplier];

    CustomCircleChart *gpaChart = [[CustomCircleChart alloc]initWithFrame:CGRectMake(-20, 25, tableView.frame.size.width * 0.5, 100.0) total:[NSNumber numberWithFloat:1.0f] current:result clockwise:NO];
    gpaChart.backgroundColor = [UIColor clearColor];
    [gpaChart setStrokeColor:([student.gpa floatValue] >= [school.gpa floatValue]) ? PNGreen : [UIColor redColor]];
    [gpaChart strokeChart];

    return gpaChart;
}

+ (CustomCircleChart *)createClinicalHourCircleChartTableView: (UITableView *)tableView
                                                      Student: (Student *)student
                                                       School: (School *)school
{
    
    CustomCircleChart *circleChart = [[CustomCircleChart alloc]initWithFrame:CGRectMake(-20, 25, tableView.frame.size.width * 0.5, 100.0) total:school.clinical_hours current: student.clinical_hours clockwise:NO];
    circleChart.backgroundColor = [UIColor clearColor];
    [circleChart setStrokeColor:([student.clinical_hours floatValue] >= [school.clinical_hours floatValue]) ? PNGreen : [UIColor redColor]];
    [circleChart strokeChart];

    return circleChart;
}


@end
