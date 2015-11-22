//
//  ViewController.m
//  ProjectIV
//
//  Created by Irwin Gonzales on 10/23/15.
//  Copyright (c) 2015 Irwin Gonzales. All rights reserved.
//

#import "ProgressionResultViewController.h"
#import "WebsiteDisplayViewController.h"
#import <Parse/Parse.h>
#import "FlatUIKit.h"
#import "FUITextField.h"
#import "UIFont+FlatUI.h"
#import "kColorConstants.h"
#import "UINavigationBar+FlatUI.h"
#import "PNChart.h"
#import "ChartTableViewCell.h"
#import "School.h"
#import <MapKit/MapKit.h>
#import "SchoolAnnotation.h"
#import "CustomCircleChart.h"

@interface ProgressionResultViewController () <UITableViewDataSource, UITableViewDelegate, MKMapViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) CustomCircleChart *clinicalHoursCircleChart;
@property (strong, nonatomic) MKMapView *map;
@property (strong, nonatomic) SchoolAnnotation *schoolAnnotation;
@property (strong, nonatomic) PFGeoPoint *schoolLocation;
@property (strong, nonatomic) CustomCircleChart *gpaCircleChart;

@end

@implementation ProgressionResultViewController

#pragma
#pragma mark - Loading Methods

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSLog(@"%@", self.school);

    self.map.delegate = self;
    self.student = [Student currentUser];

    self.schoolAnnotation = [SchoolAnnotation new];
    _schoolAnnotation.coordinate = CLLocationCoordinate2DMake(self.school.locationCoordinate.latitude, self.school.locationCoordinate.longitude);
    _schoolAnnotation.title = _school.name;

    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar configureFlatNavigationBarWithColor:[kColorConstants greySilver:1]];
    self.navigationController.navigationBar.topItem.title = @"PA Programs";

    self.tableView.estimatedRowHeight = 200.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerClass:[ChartTableViewCell class] forCellReuseIdentifier:@"cell"];

}

//------------------------- TABLEVIEW METHODS ----------------------

#pragma
#pragma mark - UITableView Delegate Methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
            return self.school.name;
            break;

        case 1:
            return @"Your GPA Progress";
            break;

        case 2:
            return @"Your Clinical Hour Progress";
            break;

        default:
            return @"Program Info";
            break;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 0:
        {
            UITableViewCell *mapcell = [tableView dequeueReusableCellWithIdentifier:@"MapCell"];
            mapcell.selectionStyle = UITableViewCellSelectionStyleNone;
            mapcell.selected = NO;
            mapcell.userInteractionEnabled = NO;
            [mapcell addSubview:[self MapView]];
            return mapcell;
            break;
        }
        case 1:
        {
            ChartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"ChartTableViewCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            NSLog(@"Student GPA: %f", [_student.gpa floatValue]);
            NSLog(@"School GPA: %f", [_school.gpa floatValue]);

            if (![self.student.gpa isEqualToNumber:self.school.gpa])
            //if (self.student.gpa != self.school.gpa)
            {

                cell.gpaLabel.text = @"Your GPA Is Not Qualified. 😕";
            }
            else if ([self.student.gpa floatValue] >= [self.school.gpa floatValue])
            {
                cell.gpaLabel.text = @"You Reached GPA Requirement! 😁";
            }
            else
            {
                cell.gpaLabel.text = @"Something Went Wrong";
            }
            cell.schoolLabel.text = [self.school.gpa stringValue];
            cell.studentLabel.text = [self.student.gpa stringValue];
            cell.gpaLabel.textColor = [kColorConstants blueMidnightBlue:1];
            cell.subLabel1.textColor = [kColorConstants blueMidnightBlue:1];
            cell.subLabel2.textColor = [kColorConstants blueMidnightBlue:1];
            cell.schoolLabel.textColor = [kColorConstants blueMidnightBlue:1];
            cell.studentLabel.textColor = [kColorConstants blueMidnightBlue:1];
            cell.gpaLabel.font = [UIFont flatFontOfSize:16];
            cell.subLabel1.font = [UIFont flatFontOfSize:14];
            cell.subLabel2.font = [UIFont flatFontOfSize:14];
            cell.schoolLabel.font = [UIFont flatFontOfSize:14];
            cell.studentLabel.font = [UIFont flatFontOfSize:14];
            [cell addSubview:[self gpaCircleChart:indexPath]];
            cell.userInteractionEnabled = NO;
            return cell;
            break;
        }
        case 2:
        {
            ChartTableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"ChartTableViewCell2"];
            cell2.selectionStyle = UITableViewCellSelectionStyleNone;

            if ([self.student.clinical_hours floatValue] < [self.school.clinical_hours floatValue])
            {
                cell2.gpaLabel.text = @"You're Not Qualified Just Yet. 😕";
            }
            else
            {
                cell2.gpaLabel.text = @"You Reached Requirement! 😁";
            }
            cell2.schoolLabel.text = [self.school.clinical_hours stringValue];
            cell2.studentLabel.text = [self.student.clinical_hours stringValue];
            cell2.gpaLabel.textColor = [kColorConstants blueMidnightBlue:1];
            cell2.subLabel1.textColor = [kColorConstants blueMidnightBlue:1];
            cell2.subLabel2.textColor = [kColorConstants blueMidnightBlue:1];
            cell2.schoolLabel.textColor = [kColorConstants blueMidnightBlue:1];
            cell2.studentLabel.textColor = [kColorConstants blueMidnightBlue:1];
            cell2.gpaLabel.font = [UIFont flatFontOfSize:16];
            cell2.subLabel1.font = [UIFont flatFontOfSize:14];
            cell2.subLabel2.font = [UIFont flatFontOfSize:14];
            cell2.schoolLabel.font = [UIFont flatFontOfSize:14];
            cell2.studentLabel.font = [UIFont flatFontOfSize:14];
            [cell2 addSubview:[self circleChartForIndexPath2:indexPath]];
            cell2.userInteractionEnabled = NO;
            
            return cell2;
            break;
        }
        default:
        {
            NSString *name = self.school.name;

            UITableViewCell *cell3 = [tableView dequeueReusableCellWithIdentifier:@"NormalCell"];
            cell3.textLabel.textColor = [kColorConstants blueMidnightBlue:1];
            cell3.textLabel.font = [UIFont flatFontOfSize:14];
            cell3.textLabel.text = name;

            return cell3;
            break;
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 0:
            return 150;
            break;
            
        case 1:
            return 150;
            break;

        case 2:
            return 150;
            break;

        default:
            return 50;
            break;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
            return 1;
            break;
            
        case 1:
            return 1;
            break;

        default:
            return 1;
            break;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"toWebViewSegue" sender:cell];
}

//------------------------------- MAP VIEW ---------------------------

#pragma
#pragma mark - Map View
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKAnnotationView *pin = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:nil];

    [[annotation title] isEqualToString:self.school.name];
    pin.canShowCallout = YES;
    pin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeSystem];

    return pin;
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocationCoordinate2D myLocation = [userLocation coordinate];
    //CLLocationCoordinate2D myLocation = CLLocationCoordinate2DMake(self.school.locationCoordinate.latitude, self.school.locationCoordinate.longitude);
    MKCoordinateRegion zoomRegion = MKCoordinateRegionMakeWithDistance(myLocation, 2500, 2500);
    [self.map setRegion:zoomRegion animated:YES];
}

//------------------------- SUBVIEWS & GRAPHICS ----------------------

#pragma
#pragma mark - Pie Charts


- (CustomCircleChart *)circleChartForIndexPath2:(NSIndexPath *)indexPath
{
    CustomCircleChart *circleChart = [CustomCircleChart createClinicalHourCircleChartTableView:_tableView Student:_student School:_school];
    return circleChart;
}

- (CustomCircleChart*)gpaCircleChart: (NSIndexPath *)indexPath
{
    CustomCircleChart *circleChart = [CustomCircleChart createGPACircleChartTableView:_tableView Student:_student School:_school];
    return circleChart;
}

- (MKMapView *)MapView
{
    _map = [[MKMapView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 150.0)];
    _map.translatesAutoresizingMaskIntoConstraints = NO;
    _map.delegate = self;
    _map.zoomEnabled = YES;
    _map.userInteractionEnabled = YES;
    [_map setShowsUserLocation:YES];
    //[_map addAnnotation:_schoolAnnotation];
    return self.map;
}

//------------------------- MEMORY WARNINGS ----------------------

#pragma
#pragma mark - Memory Warning Error

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    NSError *error = [[NSError alloc]init];
    NSLog(@"%@", error.localizedDescription);

    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@"Uh oh... Something went wrong!"
                               message:error.localizedDescription
                               preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action) {
                                                   [alert dismissViewControllerAnimated:YES completion:nil];
                                               }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

//------------------------- NAVIGATION ------------------------

#pragma
#pragma mark - Navagation Methods
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    WebsiteDisplayViewController *vc = [segue destinationViewController];
    vc.school = self.school;

}

@end
