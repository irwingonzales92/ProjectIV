//
//  InitalViewController.m
//  
//
//
//
//  Created by Irwin Gonzales on 10/24/15.
//
//

#import "StudentInputViewController.h"
#import "ProgressionResultViewController.h"
#import <Parse/Parse.h>
#import "FlatUIKit.h"
#import "FUIButton.h"
#import "FUITextField.h"
#import "UIFont+FlatUI.h"
#import "kColorConstants.h"
#import "NYAlertViewController.h"
#import "UINavigationBar+FlatUI.h"
#import <QuartzCore/QuartzCore.h>
#import "UITextFieldUnderline.h"
#import "CBZSplashView.h"
#import <MBProgressHUD/MBProgressHUD.h>

#define CORNER_RADIUS_3 3.0f
#define BORDER_WIDTH_2 2.0f


@interface StudentInputViewController () <UITextFieldDelegate, CLLocationManagerDelegate, UIActionSheetDelegate>

@property NSMutableArray *degreeChoices;
@property (strong, nonatomic) IBOutlet FUITextField *gpaTextField;
@property (strong, nonatomic) IBOutlet FUITextField *scienceTextField;
@property (strong, nonatomic) IBOutlet FUITextField *clinicalHoursTextField;
@property (strong, nonatomic) UIViewController *vc;
@property (strong, nonatomic) IBOutlet UILabel *gpaLabel;
@property (strong, nonatomic) IBOutlet UILabel *scienceLabel;
@property (strong, nonatomic) IBOutlet UILabel *clinicalHoursLabel;
@property (strong, nonatomic) IBOutlet UILabel *studentProfileLabel;
@property (strong, nonatomic) IBOutlet FUIButton *submitButton;
@property (strong, nonatomic) IBOutlet FUIButton *degreeButton;
@property (strong, nonatomic) IBOutlet FUIButton *grePrefrenceButton;
@property (strong, nonatomic) NSArray *gpaArray;


@property CLLocationManager *locationManager;
@property CLLocation *currentLocation;
@property CLLocationCoordinate2D locationCoordiante;

@end

@implementation StudentInputViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.gpaTextField.delegate = self;
    self.scienceTextField.delegate = self;
    self.clinicalHoursTextField.delegate = self;

    self.degreeChoices = [[NSMutableArray alloc]initWithObjects:@"Masters",@"Bachelors",@"No Degree", nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.topItem.title = @"Project IV";

    [self setupLocationManager];
    [self hideAndClearKeyboard];
    [self navbarStyling];
    [self textFieldLook];
    [self gpaLabelStyle];
    [self submitButtonStyle];

    if ([CLLocationManager locationServicesEnabled])
    {
        [self.locationManager startUpdatingLocation];
    }
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideAndClearKeyboard)];
    [self.view addGestureRecognizer:gestureRecognizer];
    gestureRecognizer.cancelsTouchesInView = NO;
}

//------------------------- LOCATION MANAGEMENT ----------------------

#pragma
#pragma mark - Setup Location Manager
- (void)setupLocationManager
{
    // Pre-check for authorizations
    if (![CLLocationManager locationServicesEnabled])
    {
        NSLog(@"location services are disabled");
        return;
    }
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)
    {
        NSLog(@"location services are blocked by the user");
        return;
    }
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)
    {
        NSLog(@"about to show a dialog requesting permission");
    }

    // Create LocationManager
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;

    // Request user authorization
    [self.locationManager requestAlwaysAuthorization];

    /* Pinpoint our location with the following accuracy:
     *
     *     kCLLocationAccuracyBestForNavigation  highest + sensor data
     *     kCLLocationAccuracyBest               highest
     *     kCLLocationAccuracyNearestTenMeters   10 meters
     *     kCLLocationAccuracyHundredMeters      100 meters
     *     kCLLocationAccuracyKilometer          1000 meters
     *     kCLLocationAccuracyThreeKilometers    3000 meters
     */
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;

    /* Notify changes when device has moved x meters.
     * Default value is kCLDistanceFilterNone: all movements are reported.
     */
    self.locationManager.distanceFilter = 10.0f;

    /* Notify heading changes when heading is > 5.
     * Default value is kCLHeadingFilterNone: all movements are reported.
     */
    self.locationManager.headingFilter = 5;
}

#pragma
#pragma mark - Location Manager
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocationCoordinate2D myLocation = [locations.firstObject coordinate];
    self.locationCoordiante = myLocation;

    // Set phones current location
    self.currentLocation = locations.lastObject;

    if (self.currentLocation != nil)
    {
        // Stop updating location
        [self.locationManager stopUpdatingLocation];

        PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:self.locationCoordiante.latitude longitude:self.locationCoordiante.longitude];
        [[PFUser currentUser] setObject:geoPoint forKey:@"location"];
        [[PFUser currentUser] saveInBackground];
    }
}


//---------------------- KEYBOARD METHODS & STYLING ---------------------------------

#pragma
#pragma mark - Textfield Methods
- (void)hideAndClearKeyboard
{
    [self.gpaTextField resignFirstResponder];
    [self.scienceTextField resignFirstResponder];
    [self.clinicalHoursTextField resignFirstResponder];

    [self.gpaTextField clearsOnBeginEditing];
    [self.scienceTextField clearsOnBeginEditing];
    [self.clinicalHoursTextField clearsOnBeginEditing];
}

#pragma
#pragma mark - Navbar Setup
- (void)navbarStyling
{
    [self.navigationController.navigationBar configureFlatNavigationBarWithColor:[kColorConstants greySilver:1]];

    UIImage *titleImage = [UIImage imageNamed:@"Project IV Logo.pdf"];

    UIImageView *navbarImageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 1, 10)];
    navbarImageview.image = [UIImage imageNamed:@"Project IV Logo.pdf"];

    self.navigationItem.titleView = navbarImageview;
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:[[UIImageView alloc]initWithImage:titleImage]];
    self.navigationController.navigationItem.rightBarButtonItem = item;

}

#pragma
#pragma mark - TextField Styling
- (void)textFieldLook
{
    self.gpaTextField.font = [UIFont flatFontOfSize:16];
    self.gpaTextField.backgroundColor = [UIColor whiteColor];
    self.gpaTextField.edgeInsets = UIEdgeInsetsMake(4.0f, 15.0f, 4.0f, 15.0f);
    self.gpaTextField.textFieldColor = [kColorConstants greySilver:1];
    self.gpaTextField.borderColor = [UIColor turquoiseColor];
    self.gpaTextField.layer.borderWidth = 3;
    self.gpaTextField.layer.borderColor = [kColorConstants greySilver:1].CGColor;
    self.gpaTextField.borderWidth = BORDER_WIDTH_2;
    self.gpaTextField.cornerRadius = CORNER_RADIUS_3;
    self.gpaTextField.borderStyle = UITextBorderStyleLine;
    self.gpaTextField.textColor = [UIColor whiteColor];

    self.scienceTextField.font = [UIFont flatFontOfSize:16];
    self.scienceTextField.backgroundColor = [UIColor whiteColor];
    self.scienceTextField.edgeInsets = UIEdgeInsetsMake(4.0f, 15.0f, 4.0f, 15.0f);
    self.scienceTextField.textFieldColor = [kColorConstants greySilver:1];
    self.scienceTextField.borderColor = [UIColor turquoiseColor];
    self.scienceTextField.layer.borderWidth = 3;
    self.scienceTextField.layer.borderColor = [kColorConstants greySilver:1].CGColor;
    self.scienceTextField.borderWidth = BORDER_WIDTH_2;
    self.scienceTextField.cornerRadius = CORNER_RADIUS_3;
    self.scienceTextField.borderStyle = UITextBorderStyleLine;
    self.scienceTextField.textColor = [UIColor whiteColor];

    self.clinicalHoursTextField.font = [UIFont flatFontOfSize:16];
    self.clinicalHoursTextField.backgroundColor = [UIColor whiteColor];
    self.clinicalHoursTextField.textFieldColor = [kColorConstants greySilver:1];
    self.clinicalHoursTextField.borderColor = [UIColor turquoiseColor];
    self.clinicalHoursTextField.layer.borderWidth = 3;
    self.clinicalHoursTextField.layer.borderColor = [kColorConstants greySilver:1].CGColor;
    self.clinicalHoursTextField.borderWidth = BORDER_WIDTH_2;
    self.clinicalHoursTextField.cornerRadius = CORNER_RADIUS_3;
    self.clinicalHoursTextField.borderStyle = UITextBorderStyleLine;
    self.clinicalHoursTextField.textColor = [UIColor whiteColor];
}

#pragma
#pragma mark - Button Styling
- (void)submitButtonStyle
{
    self.submitButton.buttonColor = [UIColor turquoiseColor];
    self.submitButton.shadowColor = [UIColor greenSeaColor];
    self.submitButton.shadowHeight = 3.0f;
    self.submitButton.cornerRadius = 1.0f;
    self.submitButton.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [self.submitButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.submitButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];

    self.degreeButton.buttonColor = [UIColor turquoiseColor];
    self.degreeButton.shadowColor = [UIColor greenSeaColor];
    self.degreeButton.shadowHeight = 3.0f;
    self.degreeButton.cornerRadius = 1.0f;
    self.degreeButton.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [self.degreeButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.degreeButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];

    self.grePrefrenceButton.buttonColor = [UIColor turquoiseColor];
    self.grePrefrenceButton.shadowColor = [UIColor greenSeaColor];
    self.grePrefrenceButton.shadowHeight = 3.0f;
    self.grePrefrenceButton.cornerRadius = 1.0f;
    self.grePrefrenceButton.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [self.grePrefrenceButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.grePrefrenceButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
}

#pragma 
#pragma mark - Label Styling
- (void)gpaLabelStyle
{
    self.gpaLabel.font = [UIFont flatFontOfSize:16];
    self.gpaLabel.textColor = [kColorConstants blueMidnightBlue:1];

    self.scienceLabel.font = [UIFont flatFontOfSize:16];
    self.scienceLabel.textColor = [kColorConstants blueMidnightBlue:1];

    self.clinicalHoursLabel.font = [UIFont flatFontOfSize:16];
    self.clinicalHoursLabel.textColor = [kColorConstants blueMidnightBlue:1];

    self.studentProfileLabel.font = [UIFont flatFontOfSize:23];
    self.studentProfileLabel.textColor = [kColorConstants greenGreenSeaColor:1];
}

#pragma
#pragma mark - UI Logic
//------------------------- UI COMPONENT LOGIC -------------------------

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 0)
    {
        NSString *gpa = [textField.text stringByReplacingCharactersInRange:range withString:string];
        NSCharacterSet *characterSet = [NSCharacterSet decimalDigitCharacterSet];
        if ([gpa rangeOfCharacterFromSet:characterSet].length == NSNotFound)
        {
            return NO;
        }
        return [gpa floatValue] < 5;
    }
    if (textField.tag == 2)
    {
        NSString *clinical_hours = [textField.text stringByReplacingCharactersInRange:range withString:string];
        NSCharacterSet *characterSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
        if ([clinical_hours rangeOfCharacterFromSet:characterSet].length == NSNotFound)
        {
            return NO;
        }
        return ([clinical_hours intValue] <= 1000);
    }
    else
    {
        return YES;
    }
    return YES;
}

- (IBAction)degreePresentedOnButtonPressed:(id)sender
{
    UIAlertController *degreeSelection = [UIAlertController alertControllerWithTitle:@"Select Your Degree"
                                                            message:@"Select Your Degree Prefrence"
                                                            preferredStyle:UIAlertControllerStyleActionSheet];

    UIAlertAction *mastersDegree = [UIAlertAction actionWithTitle:@"Masters" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
    {
        PFUser *user = [PFUser currentUser];
        user[@"degree_choice"] = @"Masters";
        [user saveInBackground];
        [degreeSelection dismissViewControllerAnimated:YES completion:nil];
    }];

    UIAlertAction *bachelorsDegree = [UIAlertAction actionWithTitle:@"Bachelors" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
    {
        PFUser *user = [PFUser currentUser];
        user[@"degree_choice"] = @"Bachelors";
        [user saveInBackground];
        [degreeSelection dismissViewControllerAnimated:YES completion:nil];
    }];

    UIAlertAction *noDegree = [UIAlertAction actionWithTitle:@"None" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
    {
        PFUser *user = [PFUser currentUser];
        user[@"degree_choice"] = @"None";
        [user saveInBackground];
        [degreeSelection dismissViewControllerAnimated:YES completion:nil];
    }];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action)
    {
        NSLog(@"User Cancelled Action");
    }];

    [degreeSelection addAction:mastersDegree];
    [degreeSelection addAction:bachelorsDegree];
    [degreeSelection addAction:noDegree];
    [degreeSelection addAction:cancelAction];

    [self presentViewController:degreeSelection animated:YES completion:nil];
}

- (IBAction)grePresentedOnButtonPressed:(id)sender
{
    UIAlertController *greSelection = [UIAlertController alertControllerWithTitle:@"Select Your Degree"
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];

    UIAlertAction *required = [UIAlertAction actionWithTitle:@"Required" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
    {
        PFUser *user = [PFUser currentUser];
        user[@"gre"] = @"Required";
        [user saveInBackground];
        [greSelection dismissViewControllerAnimated:YES completion:nil];
    }];

    UIAlertAction *notRequired = [UIAlertAction actionWithTitle:@"Not Required" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
    {
        PFUser *user = [PFUser currentUser];
        user[@"gre"] = @"Not Required";
        [user saveInBackground];
        [greSelection dismissViewControllerAnimated:YES completion:nil];
    }];

    UIAlertAction *none = [UIAlertAction actionWithTitle:@"None" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
    {
        PFUser *user = [PFUser currentUser];
        user[@"gre"] = @"None";
        [user saveInBackground];
        [greSelection dismissViewControllerAnimated:YES completion:nil];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"User Cancelled Action");
                                   }];
    
    [greSelection addAction:required];
    [greSelection addAction:notRequired];
    [greSelection addAction:none];
    [greSelection addAction:cancelAction];
    
    [self presentViewController:greSelection animated:YES completion:nil];

}


#pragma 
#pragma mark - Submit Button
- (IBAction)submitOnButtonPressed:(id)sender
{
//    [self enumarateThroughGpaArray];
    NSNumberFormatter *b = [NSNumberFormatter new];
    NSNumberFormatter *a = [NSNumberFormatter new];
    [b setNumberStyle:NSNumberFormatterDecimalStyle];
    [b setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *clinical_hours = [b numberFromString:self.clinicalHoursTextField.text];
    NSNumber *gpa = [a numberFromString:self.gpaTextField.text];

    NSString *science = self.scienceTextField.text;

    if ([self.gpaTextField.text isEqualToString:@""])
    {
        [self showDataEntryError:@"Error putting GPA information" withMessage:@"Did you put a number in? Is the text still empty?"];
    }
    else if ([self.clinicalHoursTextField.text isEqualToString:@""])
    {
        [self showDataEntryError:@"Error putting clinical information" withMessage:@"Did you put a number in? Is the text still empty?"];
    }
    else if ([self.scienceTextField.text isEqualToString:@""])
    {
        [self showDataEntryError:@"Error Putting" withMessage:@"Please check information"];
    }
    else
    {
        PFUser *user = [PFUser currentUser];
        user[@"gpa"] = gpa;
        user[@"clinical_hours"] = clinical_hours;
        user[@"science"] = science;
        [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
         {
             if (!error)
             {
                 [self performSegueWithIdentifier:@"toRootSegue" sender:self];
             }
             else
             {

                 [self showDataEntryError:@"Cannot Save" withMessage:@"Did You Try Putting Info In"];
             }
         }];
    }
}

//------------------------------ NAVAGATION ----------------------------

#pragma
#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

}

//------------------------- ERROR HANDLES & WARNINGS -------------------

#pragma
#pragma mark - Error Handle

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)
    {
        NSLog(@"User Has Denied Authorization");
    }
    else
    {
        NSLog(@"LocaionManager did fail with error: %@", error.localizedFailureReason);
    }
}


- (void)showDataEntryError:(NSString *)errorTitle withMessage:(NSString *)errorMessage
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    NSError *error = [[NSError alloc]init];
    NSLog(@"%@", error.localizedDescription);
}

@end
