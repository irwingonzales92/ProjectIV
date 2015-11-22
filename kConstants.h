//
//  kConstants.h
//  ProjectIV
//
//  Created by Irwin Gonzales on 10/26/15.
//  Copyright (c) 2015 Irwin Gonzales. All rights reserved.
//

#ifndef ProjectIV_kConstants_h
#define ProjectIV_kConstants_h

//////////////////////////////////////////////////
//////////////////////////////////////////////////
//
// test definitions
//
//////////////////////////////////////////////////
//////////////////////////////////////////////////
#define IS_TEST_MODE NO
#define TEST_FIRST_NAME @"firstName"
#define TEST_LAST_NAME @"lastName"
#define TEST_PROFILE_IMAGE @"default_profile_pic.jpg"

//////////////////////////////////////////////////
//////////////////////////////////////////////////
//
// segue definitions
//
//////////////////////////////////////////////////
//////////////////////////////////////////////////
static NSString* const kSegueToUserViewController =     @"segueToUserViewController";
static NSString* const kSegueToLoginViewController =    @"segueToLoginViewController";
static NSString* const kSegueToWelcomeViewController =  @"segueToWelcomeViewController";
static NSString* const kSegueToAddMentorViewController= @"segueToAddMentorViewController";

//////////////////////////////////////////////////
//////////////////////////////////////////////////
//
// User Data definitions
//
//////////////////////////////////////////////////
//////////////////////////////////////////////////
typedef enum UserType
{
    UserTypeNone,
    UserTypeMember,
    UserTypeDisciple,
    UserTypeMentor,
    UserTypeMaster
} UserType;


//////////////////////////////////////////////////
//////////////////////////////////////////////////
//
// Table Definitions
//
//////////////////////////////////////////////////
//////////////////////////////////////////////////
#define TABLE_HEADER_HEIGHT 44

//////////////////////////////////////////////////
//////////////////////////////////////////////////
//
// Backend Parse definitions
//
//////////////////////////////////////////////////
//////////////////////////////////////////////////
static NSString* const kParseClassUserTypeKey =     @"UserType";


static NSString* const kParseUserLocationKey =      @"location";
static NSString* const kParseUserFirstNameKey =     @"first_name";
static NSString* const kParseUserLastNameKey =      @"last_name";
static NSString* const kParseUserEmailKey =         @"email";
static NSString* const kParseUserFacebookIDKey =    @"facebookId";

static NSString* const kParseUserUserTypeKey =      @"user_type";

static NSString* const kParseIsMemberKey =          @"isMember";
static NSString* const kParseIsDiscipleKey =        @"isDisciple";
static NSString* const kParseIsMentorKey =          @"isMentor";
static NSString* const kParseIsMasterKey =          @"isMaster";

//////////////////////////////////////////////////
//////////////////////////////////////////////////
//
// View Definitions
//
//////////////////////////////////////////////////
//////////////////////////////////////////////////
#define DEFAULT_BACKGROUND_COLOR    [kColorConstants greyClouds:1.0f]
#define DEFAULT_SHINE_TIME_INTERVAL 1.0f
#define MARGIN_BUFFER               16
#define CHARACTER_RANGE_MAX         200

//////////////////////////////////////////////////
//////////////////////////////////////////////////
//
// Navigation Bar definitions
//
//////////////////////////////////////////////////
//////////////////////////////////////////////////
#define NAVIGATION_BAR_HEIGHT 64

//////////////////////////////////////////////////
//////////////////////////////////////////////////
//
// button definitions
//
//////////////////////////////////////////////////
//////////////////////////////////////////////////
#define BUTTON_BORDER_WIDTH     1.0f
#define BUTTON_CORNER_RADIUS    10.0f
#define BUTTON_HEIGHT           44

//////////////////////////////////////////////////
//////////////////////////////////////////////////
//
// TextField definitions
//
//////////////////////////////////////////////////
//////////////////////////////////////////////////
#define TEXTFIELD_CORNER_RADIUS     3.0f
#define TEXTFIELD_HEIGHT            40
#define TEXTFIELD_HEIGHT_SPACING    8
#define TEXTFIELD_WIDTH_SPACING     30
#define TEXTFIELD_LEFT_VIEW_FRAME   CGRectMake(0, 0, 10, 10)

//////////////////////////////////////////////////
//////////////////////////////////////////////////
//
// Font Definitions
//
//////////////////////////////////////////////////
//////////////////////////////////////////////////
static NSString* const kDefaultFontName = @"OpenSans-Light";
static CGFloat const kDefaultFontSize = 16.0f;
static CGFloat const kButtonFontSize = 20.0f;


#define BUTTON_FONT_SIZE                        20.0f
#define DEFAULT_FONT_SIZE                       16.0f
#define ONBOARDING_CELL_FONT_SIZE               16.0f
#define DEFAULT_ONBOARDING_CELL_FONT(SIZE)      [UIFont fontWithName:@"OpenSans-Light" size:SIZE]
#define DEFAULT_FONT(SIZE)                      [UIFont fontWithName:@"OpenSans-Light" size:SIZE]
#define ONEBOARDING_TEXT_VIEW_FONT_SIZE         26.0f

#define DEFAULT_TEXT_COLOR_WELCOME_VIEW         [UIColor whiteColor]
#define DEFAULT_TEXT_TINT_COLOR_WELCOME_VIEW    [UIColor whiteColor]
#define PLACEHOLDER_TEXT_COLOR_WELCOME_VIEW     [UIColor colorWithWhite:0.9 alpha:1.0f]
#define DEFAULT_TEXT_COLOR(ALPHA)               [UIColor whiteColor]
#define DEFAULT_ONBOARDING_BACKGROUND_COLOR     [kColorConstants blueMidnightBlue:1.0f]


//////////////////////////////////////////////////
//////////////////////////////////////////////////
//
// Login/Signup/Splash Definitions
//
//////////////////////////////////////////////////
//////////////////////////////////////////////////
#define TEXTBACKGROUND_WIDTH_MULTIPLIER 0.80
#define TEXTBACKGROUND_HEIGHT_MULTIPLIER 0.35

#define LOGIN_SUBVIEW_HEIGHT (TEXTFIELD_HEIGHT_SPACING * 6) + (TEXTFIELD_HEIGHT * 5)
#define SIGNUP_SUBVIEW_HEIGHT (TEXTFIELD_HEIGHT_SPACING * 6) + (TEXTFIELD_HEIGHT * 5)

#define WELCOME_PAGE_CONTROL_COUNT 3

//////////////////////////////////////////////////
//////////////////////////////////////////////////
//
// AlertView Error Definitions
//
//////////////////////////////////////////////////
//////////////////////////////////////////////////
#define ALERTVIEW_ERROR_TITLE   @"Oh no!"
#define ALERTVIEW_ERROR_CANCEL_BUTTON @"Ok"

#define ALERTVIEW_ERROR_MESSAGE_ACCOUNT_NEEDS_LINK @"It looks like you already have an account with SocialCypher. Sign in and then go to Settings to link your Facebook."
#define ERROR_CODE_ACCOUNT_NEEDS_LINK 1650

#define ALERTVIEW_ERROR_MESSAGE_CONNECTION_FAILED @"The Internet connection appears to be offline."
#define ALERTVIEW_ERROR_MESSAGE_SERVER_CONNECTION @"Could not connect to the server."
#define ALERTVIEW_ERROR_MESSAGE_EMAIL_EXIST @"Email is already taken."
#define ALERTVIEW_ERROR_MESSAGE_EMAIL_NOT_FOUND @"This email does not exist."
#define ALERTVIEW_ERROR_MESSAGE_EMAIL_PASSWORD_INCORRECT @"Email address could not be found/the password is incorrect."


#endif
