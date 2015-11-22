//
//  SignupViewController.m
//  
//
//  Created by Irwin Gonzales on 11/2/15.
//
//

#import "SignupViewController.h"
#import <Parse/Parse.h>
#import "FlatUIKit.h"
#import "FUIButton.h"
#import "FUITextField.h"
#import "kColorConstants.h"
#import "Student.h"
#import <CoreLocation/CoreLocation.h>
#import <MBProgressHUD/MBProgressHUD.h>

#define CORNER_RADIUS_3 3.0f
#define BORDER_WIDTH_2 2.0f

@interface SignupViewController () <UITextFieldDelegate, CLLocationManagerDelegate>
@property (strong, nonatomic) IBOutlet FUITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet FUITextField *emailTextField;
@property (strong, nonatomic) IBOutlet FUITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet FUITextField *confirmPasswordTextField;
@property (strong, nonatomic) IBOutlet FUIButton *loginButton;
@property (strong, nonatomic) Student *student;

@property CLLocationManager *locationManager;
@property CLLocation *currentLocation;
@property CLLocationCoordinate2D locationCoordiante;

@end

@implementation SignupViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self hideKeyboard];
    [self emailTextFieldLook];
    [self usernameTextFieldLook];
    [self passwordTextFieldLook];
    [self confirmPasswordTextFieldLook];
    [self setupLocationManager];
    [self loginButtonStyle];

    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
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
#pragma mark - Hide Keyboard
- (void)hideKeyboard
{
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.confirmPasswordTextField resignFirstResponder];
    [self.emailTextField resignFirstResponder];
    self.passwordTextField.secureTextEntry = YES;
    self.confirmPasswordTextField.secureTextEntry = YES;
}

#pragma
#pragma mark - Name TextField Style
- (void)usernameTextFieldLook
{
    self.usernameTextField.delegate = self;
    self.usernameTextField.font = [UIFont flatFontOfSize:16];
    self.usernameTextField.backgroundColor = [UIColor whiteColor];
    self.usernameTextField.edgeInsets = UIEdgeInsetsMake(4.0f, 15.0f, 4.0f, 15.0f);
    self.usernameTextField.textFieldColor = [UIColor whiteColor];
    self.usernameTextField.borderColor = [UIColor turquoiseColor];
    self.usernameTextField.borderWidth = BORDER_WIDTH_2;
    self.usernameTextField.cornerRadius = CORNER_RADIUS_3;
    self.usernameTextField.borderStyle = UITextBorderStyleNone;
}

#pragma
#pragma mark - Email TextField Style
- (void)emailTextFieldLook
{
    self.emailTextField.delegate = self;
    self.emailTextField.font = [UIFont flatFontOfSize:16];
    self.emailTextField.backgroundColor = [UIColor whiteColor];
    self.emailTextField.edgeInsets = UIEdgeInsetsMake(4.0f, 15.0f, 4.0f, 15.0f);
    self.emailTextField.textFieldColor = [UIColor whiteColor];
    self.emailTextField.borderColor = [UIColor turquoiseColor];
    self.emailTextField.borderWidth = BORDER_WIDTH_2;
    self.emailTextField.cornerRadius = CORNER_RADIUS_3;
    self.emailTextField.borderStyle = UITextBorderStyleNone;
}

#pragma
#pragma mark - Password TextField Style
- (void)passwordTextFieldLook
{
    self.passwordTextField.delegate = self;
    self.passwordTextField.font = [UIFont flatFontOfSize:16];
    self.passwordTextField.backgroundColor = [UIColor whiteColor];
    self.passwordTextField.edgeInsets = UIEdgeInsetsMake(4.0f, 15.0f, 4.0f, 15.0f);
    self.passwordTextField.textFieldColor = [UIColor whiteColor];
    self.passwordTextField.borderColor = [UIColor turquoiseColor];
    self.passwordTextField.borderWidth = BORDER_WIDTH_2;
    self.passwordTextField.cornerRadius = CORNER_RADIUS_3;
    self.passwordTextField.borderStyle = UITextBorderStyleNone;
}

#pragma
#pragma mark - Password TextField Style
- (void)confirmPasswordTextFieldLook
{
    self.confirmPasswordTextField.delegate = self;
    self.confirmPasswordTextField.font = [UIFont flatFontOfSize:16];
    self.confirmPasswordTextField.backgroundColor = [UIColor whiteColor];
    self.confirmPasswordTextField.edgeInsets = UIEdgeInsetsMake(4.0f, 15.0f, 4.0f, 15.0f);
    self.confirmPasswordTextField.textFieldColor = [UIColor whiteColor];
    self.confirmPasswordTextField.borderColor = [UIColor turquoiseColor];
    self.confirmPasswordTextField.borderWidth = BORDER_WIDTH_2;
    self.confirmPasswordTextField.cornerRadius = CORNER_RADIUS_3;
    self.confirmPasswordTextField.borderStyle = UITextBorderStyleNone;
}

#pragma
#pragma mark - Login Button Style
- (void)loginButtonStyle
{
    self.loginButton.buttonColor = [UIColor turquoiseColor];
    self.loginButton.shadowColor = [UIColor greenSeaColor];
    self.loginButton.shadowHeight = 3.0f;
    self.loginButton.cornerRadius = 1.0f;
    self.loginButton.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [self.loginButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
}

//#pragma
//#pragma mark - Login Button Style
//- (void)signupButtonStyle
//{
//    self.signupButton.buttonColor = [UIColor turquoiseColor];
//    self.signupButton.shadowColor = [UIColor greenSeaColor];
//    self.signupButton.shadowHeight = 3.0f;
//    self.signupButton.cornerRadius = 6.0f;
//    self.signupButton.titleLabel.font = [UIFont boldFlatFontOfSize:16];
//    [self.signupButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
//    [self.signupButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
//}

#pragma
#pragma mark - Pressed Return Button

-(BOOL)textFieldShouldReturn:(FUITextField *)textField
{

    if ([self.emailTextField.text isEqualToString:@""])
    {
        [self showSignUpErrorAlertController:@"Error: Email missing" withMessage:@"Please enter an email."];
    }
    else if ([self.usernameTextField.text isEqualToString:@""])
    {
        [self showSignUpErrorAlertController:@"Error: Username Required" withMessage:@"Please enter a username."];
    }
    else if([self.passwordTextField.text isEqualToString:@""])
    {
        [self showSignUpErrorAlertController:@"Error: Password missing" withMessage:@"Please enter a password."];
    }
    else if ([self.confirmPasswordTextField.text isEqualToString:self.passwordTextField.text] == [self.confirmPasswordTextField.text isEqualToString:@""])
    {
        [self showSignUpErrorAlertController:@"Error: Invalid Password" withMessage:@"Please make sure your passwords match."];
    }
    else
    {
        self.student = [[Student alloc]init];
        self.student.username = self.usernameTextField.text;
        self.student.password = self.passwordTextField.text;
        self.student.email = self.emailTextField.text;
        [self.student signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
         {
             if (!error)
             {
                 // Hooray! Let them use the app now.
                 NSLog(@"Signed up as %@", [PFUser currentUser].username);
                 [self performSegueWithIdentifier:@"toHomeSegue" sender:self];
                 //self.successSignUpBlock();
             }
             else
             {
                 NSString *errorString = [error userInfo][@"error"];
                 [self showSignUpErrorAlertController:@"Error" withMessage:errorString];
             }
         }];
    }

    [self hideKeyboard];
    return YES;
}

//---------------------------------- NAVIGATION ----------------------------------
#pragma
#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

}

- (void)showSignUpErrorAlertController: (NSString *)errorTitle withMessage: (NSString*)errorMessage
{
    UIAlertController * alert= [UIAlertController
                                alertControllerWithTitle:errorTitle
                                message:errorMessage
                                preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action) {
                                                   [alert dismissViewControllerAnimated:YES completion:nil];
                                               }];
    [alert addAction:ok];

    [self presentViewController:alert animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    NSError *error = [[NSError alloc]init];
    NSLog(@"%@", error.localizedDescription);

}

@end
