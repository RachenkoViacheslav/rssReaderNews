//
//  VRShowNewsFromLink.h
//  rssReaderNews
//
//  Created by Admin on 08.05.15.
//  Copyright (c) 2015 Rachenko Viacheslav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VRShowNewsFromLink : UIViewController


@property (weak, nonatomic) IBOutlet UIWebView *webViewOutlet;
@property (strong, nonatomic) NSURL* linkToSite;
@end
