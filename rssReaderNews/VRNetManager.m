//
//  VRNetManager.m
//  rssReaderNews
//
//  Created by Admin on 06.05.15.
//  Copyright (c) 2015 Rachenko Viacheslav. All rights reserved.
//

#import "VRNetManager.h"
#import <AFNetworkReachabilityManager.h>
#import <RSSParser.h>
#import <RSSItem.h>
#import <MBProgressHUD.h>
#import "Reachability.h"
#import "VRMainViewController.h"




@interface VRNetManager ()
//@property (strong, nonatomic)AFNetworkReachabilityManager* networkReachabilityManager;
@property (strong, nonatomic) Reachability *networkReachability;
@property (strong,nonatomic) MBProgressHUD *hud;
@property (strong, nonatomic) UIView *myView;

@end

@implementation VRNetManager



+(VRNetManager *)sharedManager {
    static VRNetManager* manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once (&onceToken, ^{
        manager = [[VRNetManager alloc]init];
    });
    
    return manager;
}


-(void)getNewFeedsFromSiteURL:(NSString *)siteURLString
onSucces:(void (^)(NSArray *))success
onFailure:(void (^)(NSError *, NSInteger, NSString *))failure {
    
    

    
   
   // if ([self changeIsNetworkConnection]!=AFNetworkReachabilityStatusNotReachable) {
        
        
              
        
        NSURL *url = [NSURL URLWithString:siteURLString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        
        
        [RSSParser parseRSSFeedForRequest:request
                                  success:^(NSArray *feedItems) {
                                      [self.hud hide:YES];
                                      self.hud = nil;
                                      for (RSSItem*item in feedItems) {
                                          
                                      }
                                      success (feedItems);
                                      
                                  }                          failure:^(NSError *error) {
                                      
                                      
                                  }];
//    }
//    
//    else {
//        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Error"
//                                                           message:@"Not found Network Connetion"
//                                                          delegate:nil
//                                                 cancelButtonTitle:@"OK"
//                                                 otherButtonTitles:nil, nil];
//        
//        [alertView show];    }
    
    
    
    

    
}

-(AFNetworkReachabilityStatus)changeIsNetworkConnection {
    __block AFNetworkReachabilityStatus reachable;
    
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"No Internet Connection");
                reachable = status;
                //return reachable;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WIFI");
                
                reachable = status;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"3G");
                reachable = status;
                break;
            default:
                NSLog(@"Unkown network status");
                reachable = status;
                break;
                
        }
    }];
    
    return reachable;
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    NSLog(@"reachable = %i", reachable );
    
    
   
}

-(NetworkStatus)checkInternetConnection {
    
    
    self.networkReachability = [Reachability reachabilityForInternetConnection];
    
    return [self.networkReachability currentReachabilityStatus];
}


















@end
