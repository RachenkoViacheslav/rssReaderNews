//
//  VRViewController.m
//  rssReaderNews
//
//  Created by Admin on 06.05.15.
//  Copyright (c) 2015 Rachenko Viacheslav. All rights reserved.
//

#import "VRMainViewController.h"
#import "VRNetManager.h"
#import "VRCellForFeedViewCell.h"
#import "VRDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import <RSSItem.h>
#import <MBProgressHUD.h>

#import "Reachability.h"
#import "VRAppDelegate.h"


static NSString *siteURL = @"http://rss.cbc.ca/lineup/topstories.xml";

@interface VRMainViewController ()
{
    NSMutableArray *newsItemArray;

}
@property (weak, nonatomic)IBOutlet UITableView * tableViewDelegate;

@end

@implementation VRMainViewController 

- (void)viewDidLoad

{

 [super viewDidLoad];
    VRAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    appDelegate.mainViewController = self;
   
	
}

#pragma mark - Make network request
-(void)clearTableViewAndDataSource {
    
    
    [newsItemArray removeAllObjects];
    [self.tableViewDelegate reloadData];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

-(void)makeRequest {
    
    
  
    
    if ([[VRNetManager sharedManager]checkInternetConnection]!=NotReachable) {
        [self clearTableViewAndDataSource];
        
        
        self.hud =[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        self.hud.mode = MBProgressHUDModeIndeterminate;
        self.hud.labelText = @"Loading";
        
        
        
        [[VRNetManager sharedManager]getNewFeedsFromSiteURL:siteURL onSucces:^(NSArray *feedsArray) {
            [newsItemArray removeAllObjects];
            newsItemArray = [NSMutableArray arrayWithArray:feedsArray];
            NSLog(@"feedsArray = %@", feedsArray );
            [self.hud hide:YES];
            self.hud = nil;
            
            [self.tableViewDelegate reloadData];
        } onFailure:^(NSError *error, NSInteger statusCode, NSString *errorDescription) {
            [self.hud hide:YES];
            self.hud = nil;
            
            NSLog(@"failure = %@", error.description );
        }];
    }
    
    
    else  {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Error"
                                                           message:@"Not internet connection"
                                                          delegate:nil
                                                 cancelButtonTitle:@"OK"
                                                 otherButtonTitles:nil, nil];
        
        [alertView show];
    }

    
    
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [newsItemArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RSSItem* feedItem = [newsItemArray objectAtIndex:indexPath.row];
    NSArray* imgArray = [feedItem imagesFromItemDescription ];
    NSString* imgURLString = imgArray[0];
    NSURL *imgURL = [NSURL URLWithString:imgURLString];
    NSLog(@"imgArray = %@", imgArray );

    
    static NSString *CellIdentifier = @"FeedCell";
    VRCellForFeedViewCell *cell = [self.tableViewDelegate dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[VRCellForFeedViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSDate* dateTime = feedItem.pubDate;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateStyle:NSDateFormatterShortStyle];
    [dateFormat setTimeStyle:NSDateFormatterShortStyle];
    NSString *correctDate = [dateFormat stringFromDate:dateTime];
    
    cell.feedsTitleLabel.text = feedItem.title;
    cell.feedPubDataLabel.text = correctDate;
    NSLog(@"feedItem.author; = %@", feedItem.author );
    cell.authorNameLabel.text = feedItem.author;
    [cell.feedSmallPhoto setImageWithURL:imgURL placeholderImage:[UIImage imageNamed:@"Placeholder.png"]];
    
       return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"selected index = %i", indexPath.row );
    RSSItem* selectedItemsFeed = [newsItemArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"showDetailNews" sender:selectedItemsFeed];
    
    
}

#pragma mark - Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showDetailNews"]) {
       
        VRDetailViewController* detailView = segue.destinationViewController;
        detailView.selectFeedItem = sender;
        NSLog(@"detailView.selectFeedItem = %@", detailView.selectFeedItem );
        NSLog(@"sender = %@", sender );
        
    }
    
    
    
}

@end
