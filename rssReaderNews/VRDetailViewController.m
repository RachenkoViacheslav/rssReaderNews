//
//  VRDetailViewController.m
//  rssReaderNews
//
//  Created by Admin on 06.05.15.
//  Copyright (c) 2015 Rachenko Viacheslav. All rights reserved.
//

#import "VRDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import <RSSItem.h>
#import "VRShowNewsFromLink.h"
@interface VRDetailViewController ()

@end

@implementation VRDetailViewController

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
	NSLog(@"self.selectFeedItem = %@", self.selectFeedItem.title );
    
    [self viewAllData];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - ViewData
-(void)viewAllData {
    
    
    NSArray* imgArray = [self.selectFeedItem imagesFromItemDescription ];
    NSString* imgURLString = imgArray[0];
    NSURL *imgURL = [NSURL URLWithString:imgURLString];
    
    [self.feedLargePhoto setImageWithURL:imgURL placeholderImage:[UIImage imageNamed:@"Placeholder.png"]];
    self.feedText.text = [self getTextFromItemDescription];
    
    
}

-(NSString*)getTextFromItemDescription {
    
    NSString* itemDescriptionString = self.selectFeedItem.itemDescription;
    NSString*  result;
    
    

    NSRange startUrlRange = [itemDescriptionString rangeOfString:@"<p>" options:NSCaseInsensitiveSearch];
    if (startUrlRange.location != NSNotFound)
    {
        NSRange endUrlRange;
        
        endUrlRange.location = startUrlRange.length + startUrlRange.location;
        endUrlRange.length   = [itemDescriptionString length] - endUrlRange.location;
        endUrlRange = [itemDescriptionString rangeOfString:@"</p>" options:NSCaseInsensitiveSearch range:endUrlRange];
        
        if (endUrlRange.location != NSNotFound)
        {
            
            startUrlRange.location += startUrlRange.length;
            startUrlRange.length = endUrlRange.location - startUrlRange.location;
            
       result = [itemDescriptionString substringWithRange:startUrlRange];
            NSLog(@"result =  %@", result);
            
        }
    }

    return result;
    
}
#pragma mark - Action
- (IBAction)goFromLink:(id)sender {
    
    [self performSegueWithIdentifier:@"ShowInWebView" sender:nil];
    
}

#pragma mark - Segue


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"ShowInWebView"]) {
        
        VRShowNewsFromLink* webViewControll = segue.destinationViewController;
        webViewControll.linkToSite = self.selectFeedItem.link;
        
        NSLog(@"webViewControll.linkToSite = %@", webViewControll.linkToSite);
    }
    
    
    
}
@end
