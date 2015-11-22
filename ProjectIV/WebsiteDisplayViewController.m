//
//  DisplayViewController.m
//  
//
//  Created by Irwin Gonzales on 10/24/15.
//
//

#import "WebsiteDisplayViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface WebsiteDisplayViewController () <UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) UIActivityIndicatorView *spinner;

@end

@implementation WebsiteDisplayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.webView.delegate = self;
    
    [self loadWebsite];

}

- (void)loadWebsite
{
    NSString *webPageURLString = self.school.websitelink;
    NSURL *webPageURL = [NSURL URLWithString:webPageURLString];
    NSURLRequest *webPageURLRequest = [NSURLRequest requestWithURL:webPageURL];
    [self.webView loadRequest:webPageURLRequest];
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self.spinner startAnimating];
    self.spinner.hidden = false;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self.spinner stopAnimating];
    self.spinner.hidden = true;
}

#pragma
#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

}

//------------------------- ERROR HANDLES & WARNINGS -------------------

#pragma
#pragma mark - Memory Warning
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
