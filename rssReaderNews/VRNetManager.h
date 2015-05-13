//
//  VRNetManager.h
//  rssReaderNews
//
//  Created by Admin on 06.05.15.
//  Copyright (c) 2015 Rachenko Viacheslav. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworkReachabilityManager.h>
#import "Reachability.h"
@interface VRNetManager : NSObject


+(VRNetManager*) sharedManager;


-(void) getNewFeedsFromSiteURL:(NSString*)siteURLString
                      onSucces:(void(^)(NSArray*feedsArray)) success
                     onFailure:(void(^)(NSError* error, NSInteger statusCode, NSString* errorDescription)) failure;


-(AFNetworkReachabilityStatus)changeIsNetworkConnection;
-(NetworkStatus)checkInternetConnection;

@end
