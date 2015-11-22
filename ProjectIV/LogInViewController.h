//
//  LoginViewController.h
//  
//
//  Created by Irwin Gonzales on 11/2/15.
//
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (nonatomic, copy) void (^successLoginBlock)();

@end
