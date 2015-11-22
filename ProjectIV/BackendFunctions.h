//
//  BackendFunctions.h
//  
//
//  Created by Irwin Gonzales on 10/27/15.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "kConstants.h"

/////////////////////////////
// block definitions
/////////////////////////////
typedef void (^SuccessCompletionBlock)(BOOL success);
typedef void (^CompletionWithErrorBlock)(BOOL success, NSError *error);
typedef void (^CompletionWithDictionaryBlock)(NSDictionary *dictionary, NSError *error);
typedef void (^CompletionWithArrayBlock)(NSArray *array, NSError *error);
typedef void (^FacebookCompletionWithErrorBlock)(BOOL isNewUser, BOOL success, NSError *error);
typedef void (^FacebookProfileCompletionBlock)(UIImage *image, NSError *error);
typedef void (^ArrayReturnBlock)(NSArray *array, NSError *error);

@interface BackendFunctions : NSObject

/////////////////////////////
// methods for handling user
/////////////////////////////
+ (void)signupUser:(NSString *)username
          password:(NSString *)password
         firstName:(NSString *)firstName
          lastName:(NSString *)lastName
      onCompletion:(CompletionWithErrorBlock)onCompletion;

+ (void)loginUser:(NSString *)username
         password:(NSString *)password
     onCompletion:(CompletionWithErrorBlock)onCompletion;

+ (void)logoutUser;
+ (BOOL)userIsLoggedIn;

@end
