//
//  VRShowNewsFromLink.m
//  rssReaderNews
//
//  Created by Admin on 08.05.15.
//  Copyright (c) 2015 Rachenko Viacheslav. All rights reserved.
//

#import "VRShowNewsFromLink.h"
#import <MBProgressHUD.h>

@interface VRShowNewsFromLink () <UIWebViewDelegate>
@property (strong,nonatomic) MBProgressHUD *hud;
@end

@implementation VRShowNewsFromLink

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.webViewOutlet.delegate = self;
    [self createRequest];
    [self fixedBugWithScaleInWebView];
    
	
}

-(void)createRequest {
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:self.linkToSite];
    [self.webViewOutlet loadRequest:request];
    
}

-(void)fixedBugWithScaleInWebView {
    
    
    self.webViewOutlet.scalesPageToFit = YES;
    self.webViewOutlet.contentMode = UIViewContentModeScaleToFill;
    self.webViewOutlet.multipleTouchEnabled = YES;
    self.webViewOutlet.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview: self.webViewOutlet];
    
    
}

-(void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"webViewDidStartLoad");
    self.hud =[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.mode = MBProgressHUDModeIndeterminate;
    self.hud.labelText = @"Loading";
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.hud hide:YES];
    self.hud = nil;
    
}

@end
