//
//  AppDelegate.h
//  ProjectIV
//
//  Created by Irwin Gonzales on 10/23/15.
//  Copyright (c) 2015 Irwin Gonzales. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIStoryboard * initialStoryboard;

- (void)resetWindowToInitialView;
//+ (void)registerForPushNotifications;



@end

