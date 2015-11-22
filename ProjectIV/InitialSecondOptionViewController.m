//
//  InitialSecondOptionViewController.m
//  
//
//  Created by Irwin Gonzales on 11/6/15.
//
//

#import "InitialSecondOptionViewController.h"

@interface InitialSecondOptionViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation InitialSecondOptionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}


//------------------------------- TABLE VIEW METHODS -----------------------------

#pragma
#pragma mark - UITableView Methods
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier;
    

    if (indexPath.row == 0)
    {
        identifier = @"cell";
    }
    else if (indexPath.row == 1)
    {
        identifier = @"cell2";
    }
    else if (indexPath.row == 2)
    {
        identifier = @"cell";
    }
    else if (indexPath.row == 3)
    {
        identifier = @"cell4";
    }
    else
    {
        identifier = @"cell";
    }

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}


//---------------------------------- NAVIGATION ----------------------------------

#pragma
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


//--------------------------- ERROR HANDLES & WARNINGS ----------------------------
#pragma
#pragma mark - Login Error Message
- (void)showLoginErrorAlertController: (NSString *)errorTitle withMessage: (NSString*)errorMessage
{
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:errorTitle
                               message:errorMessage
                               preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action) {
                                                   [alert dismissViewControllerAnimated:YES completion:nil];
                                               }];
    [alert addAction:ok];

    [self presentViewController:alert animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
