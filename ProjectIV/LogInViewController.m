//
//  LoginViewController.m
//  
//
//  Created by Irwin Gonzales on 11/2/15.
//
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import "FlatUIKit.h"
#import "FUIButton.h"
#import "FUITextField.h"
#import "kColorConstants.h"
#import "FUIAlertview.h"
#import "CBZSplashView.h"
#import "Student.h"
#import <MBProgressHUD/MBProgressHUD.h>

#define CORNER_RADIUS_3 3.0f
#define BORDER_WIDTH_2 2.0f

@interface LoginViewController () <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet FUITextField *nameTextField;
@property (strong, nonatomic) IBOutlet FUITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet FUIButton *backButton;
@property (strong, nonatomic) Student *student;
@property (strong, nonatomic) IBOutlet UIImageView *logoImageView;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self spashViewAnimation];

    //if ([PFUser currentUser])
    if ([Student currentUser])
    {
        NSLog(@"User is already signed in %@", [PFUser currentUser].username);
    }

    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:gestureRecognizer];
    gestureRecognizer.cancelsTouchesInView = NO;
}

-(void)viewWillAppear:(BOOL)animated
{

    UIImage *logoImage = [UIImage imageNamed:@"logo.png"];
    self.logoImageView.image = logoImage;

    self.view.backgroundColor = [UIColor whiteColor];
    [self hideKeyboard];
    [self nameTextFieldLook];
    [self passwordTextFieldLook];
    [self backButtonStyle];
}


//---------------------- KEYBOARD METHODS & STYLING ---------------------------------
#pragma
#pragma mark - Keyboard Behavior

- (void)hideKeyboard
{
    [self.nameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    self.passwordTextField.secureTextEntry = YES;
}

-(BOOL)textFieldShouldReturn:(FUITextField *)textField
{

    if ([self.nameTextField.text isEqualToString:@""])
    {
        [self showLoginErrorAlertController:@"Error: Name is missing" withMessage:@"Please put your name in!"];
    }
    else if ([self.passwordTextField.text isEqualToString:@""])
    {
        [self showLoginErrorAlertController:@"Error: Password is missing" withMessage:@"Please put password in"];
    }
    else
    {
        [PFUser logInWithUsernameInBackground:self.nameTextField.text password:self.passwordTextField.text block:^(PFUser *user, NSError *error)
         {
             if (!error)
             {
                 NSLog(@"Signed In As %@", [PFUser currentUser].username);
                 [self performSegueWithIdentifier:@"toMainSegue" sender:self];

             }
             else
             {
                 NSString *errorString = [error userInfo][@"error"];
                 NSLog(@"%@", errorString);
                 [self showLoginErrorAlertController:@"Error" withMessage:@"errorString"];
             }
         }];
    }

    [self hideKeyboard];
    return YES;
}

#pragma
#pragma mark - Splash View Animation
- (void)spashViewAnimation
{
    UIImage *icon = [UIImage imageNamed:@"IVIcon.png"];
    UIColor *color = [kColorConstants greenGreenSeaColor:1];
    CBZSplashView *splashView = [CBZSplashView splashViewWithIcon:icon backgroundColor:color];

    [self.view addSubview:splashView];
    [splashView startAnimation];
}

#pragma 
#pragma mark - Name TextField Style
- (void)nameTextFieldLook
{
    [self.nameTextField setDelegate:self];
    self.nameTextField.font = [UIFont flatFontOfSize:16];
    self.nameTextField.backgroundColor = [UIColor whiteColor];
    self.nameTextField.edgeInsets = UIEdgeInsetsMake(4.0f, 15.0f, 4.0f, 15.0f);
    self.nameTextField.textFieldColor = [kColorConstants greySilver:1];
    self.nameTextField.borderColor = [UIColor turquoiseColor];
    self.nameTextField.layer.borderWidth = 3;
    self.nameTextField.layer.borderColor = [kColorConstants greySilver:1].CGColor;
    self.nameTextField.borderWidth = BORDER_WIDTH_2;
    self.nameTextField.cornerRadius = CORNER_RADIUS_3;
    self.nameTextField.borderStyle = UITextBorderStyleNone;
    self.nameTextField.textColor = [UIColor whiteColor];
}

#pragma
#pragma mark - Password TextField Style
- (void)passwordTextFieldLook
{
    [self.passwordTextField setDelegate:self];
    self.passwordTextField.font = [UIFont flatFontOfSize:16];
    self.passwordTextField.backgroundColor = [UIColor whiteColor];
    self.passwordTextField.edgeInsets = UIEdgeInsetsMake(4.0f, 15.0f, 4.0f, 15.0f);
    self.passwordTextField.textFieldColor = [kColorConstants greySilver:1];
    self.passwordTextField.borderColor = [UIColor turquoiseColor];
    self.passwordTextField.layer.borderWidth = 3;
    self.passwordTextField.layer.borderColor = [kColorConstants greySilver:1].CGColor;
    self.passwordTextField.borderWidth = BORDER_WIDTH_2;
    self.passwordTextField.cornerRadius = CORNER_RADIUS_3;
    self.passwordTextField.borderStyle = UITextBorderStyleNone;
    self.passwordTextField.textColor = [UIColor whiteColor];
}

#pragma
#pragma mark - Login Button Style
- (void)backButtonStyle
{
    self.backButton.buttonColor = [UIColor turquoiseColor];
    self.backButton.shadowColor = [UIColor greenSeaColor];
    self.backButton.shadowHeight = 3.0f;
    self.backButton.cornerRadius = 1.0f;
    self.backButton.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [self.backButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.backButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
}

//---------------------------------- NAVIGATION ----------------------------------

#pragma
#pragma mark - Navigation

 // In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{


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

    NSError *error = [[NSError alloc]init];
    NSLog(@"%@", error.localizedDescription);
}


@end
