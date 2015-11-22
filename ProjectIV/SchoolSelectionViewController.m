//
//  SchoolSelectionViewController.m
//  
//
//  Created by Irwin Gonzales on 11/17/15.
//
//

#import "SchoolSelectionViewController.h"
#import "ProgressionResultViewController.h"
#import <Parse/Parse.h>
#import "School.h"
#import "FlatUIKit.h"
#import "FUIButton.h"
#import "FUITextField.h"
#import "kColorConstants.h"
#import <MBProgressHUD/MBProgressHUD.h>


@interface SchoolSelectionViewController () <UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *schoolArray;


@end

@implementation SchoolSelectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];


    self.schoolArray = [NSMutableArray new];

     self.navigationController.navigationBar.topItem.title = @"Edit Info";

    [self schoolQery];
    [self.tableView reloadData];
}

#pragma
#pragma mark - School Query

- (void)schoolQery
{
    PFQuery *query = [PFQuery queryWithClassName:NSStringFromClass(School.class)];
    [query selectKeys:@[@"name",@"gpa", @"clinical_hours",@"degree_choice",@"gre",@"websitelink", @"locationCoordinate"]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         NSLog(@"its working: %@", objects);
         if (!error)
         {
             self.schoolArray = [NSMutableArray arrayWithArray:objects];
             [self.tableView reloadData];
         }
         else
         {
            NSLog(@"%@",error.localizedDescription);
             
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
     }];
}


#pragma
#pragma mark - TableView Methods

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.textColor = [kColorConstants blueMidnightBlue:1];
    cell.textLabel.font = [UIFont flatFontOfSize:16];
    School* school = _schoolArray[indexPath.row];
    cell.textLabel.text = school.name;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    School* school = _schoolArray[indexPath.row];
    [self performSegueWithIdentifier:@"toRootSegue" sender:school];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.schoolArray.count;
}

#pragma
#pragma mark - Memory Warning

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma
#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier  isEqual: @"toRootSegue"] )
    {
        School *school = (School *)sender;
        ProgressionResultViewController *vc = [segue destinationViewController];
        vc.school = school;
    }
}


@end
