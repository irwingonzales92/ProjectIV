//
//  ChartTableViewCell.h
//  
//
//  Created by Irwin Gonzales on 11/15/15.
//
//

#import <UIKit/UIKit.h>
#import "PNChart.h"
#import "PNPieChart.h"
#import "PNLineChart.h"
#import "PNBarChart.h"
#import "PNCircleChart.h"
#import "School.h"
#import "Student.h"

@interface ChartTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *gpaLabel;
@property (strong, nonatomic) IBOutlet UILabel *subLabel1;
@property (strong, nonatomic) IBOutlet UILabel *subLabel2;
@property (strong, nonatomic) IBOutlet UILabel *schoolLabel;
@property (strong, nonatomic) IBOutlet UILabel *studentLabel;


@end
