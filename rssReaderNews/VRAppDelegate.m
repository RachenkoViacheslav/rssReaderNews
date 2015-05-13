//
//  VRAppDelegate.m
//  rssReaderNews
//
//  Created by Admin on 06.05.15.
//  Copyright (c) 2015 Rachenko Viacheslav. All rights reserved.
//

#import "VRAppDelegate.h"
#import "VRMainViewController.h"

@implementation VRAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    return YES;
    
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [self.mainViewController clearTableViewAndDataSource];
   
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [self.mainViewController clearTableViewAndDataSource];
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [self.mainViewController makeRequest];
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
