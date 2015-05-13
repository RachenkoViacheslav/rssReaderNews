//
//  VRDetailViewController.h
//  rssReaderNews
//
//  Created by Admin on 06.05.15.
//  Copyright (c) 2015 Rachenko Viacheslav. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RSSItem;
@interface VRDetailViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIImageView *feedLargePhoto;
@property (weak, nonatomic) IBOutlet UITextView *feedText;
@property (strong, nonatomic) RSSItem* selectFeedItem;

- (IBAction)goFromLink:(id)sender;
@end
