//
//  VRViewController.h
//  rssReaderNews
//
//  Created by Admin on 06.05.15.
//  Copyright (c) 2015 Rachenko Viacheslav. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MBProgressHUD;

@interface VRMainViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UIView* mainView;
@property (strong,nonatomic) MBProgressHUD *hud;

-(void)clearTableViewAndDataSource;
-(void)makeRequest;
@end
