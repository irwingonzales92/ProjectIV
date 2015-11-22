//
//  BackendFunctions.m
//  
//
//  Created by Irwin Gonzales on 10/27/15.
//
//

#import "BackendFunctions.h"
#import <Parse/Parse.h>

@implementation BackendFunctions

#pragma 
#pragma mark - User Methods

//------------------------------------------------------
+ (void)signupUser:(NSString *)username
          password:(NSString *)password
         firstName:(NSString *)firstName
          lastName:(NSString *)lastName
      onCompletion:(CompletionWithErrorBlock)onCompletion
{
    if ([PFUser user]) ([PFUser logOut]);

    PFUser *user = [PFUser user];
    user.username = [username lowercaseString];
    user.password = password;
    user.email = [username lowercaseString];

//    user[kParseUserFirstNameKey] = firstName;
//    user[kParseUserLastNameKey] = lastName;

    // Change out with an Error Handle block later on
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        onCompletion(succeeded, error);
    }];
}
//-----------------------------------------------------

+ (void)loginUser:(NSString *)userName
         password: (NSString *)password
     onCompletion:(CompletionWithErrorBlock)onCompletion
{
    [PFUser logInWithUsernameInBackground:[userName lowercaseString] password:[password lowercaseString]];

}

//------------------------------------------------------

+ (void)logoutUser
{
    [PFUser logOut];
}

//------------------------------------------------------

+ (BOOL)userIsLoggedIn
{
    PFUser *currentUser = [PFUser currentUser];
    return (currentUser) ? YES : NO;
}

//------------------------------------------------------

@end
