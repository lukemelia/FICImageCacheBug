//
//  AppDelegate.m
//  FICImageCacheBug
//
//  Created by Luke Melia on 5/12/14.
//  Copyright (c) 2014 Yapp. All rights reserved.
//

#import "AppDelegate.h"
#import "ImageFormats.h"
#import "YappModel.h"
#import <FICImageCache.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    FICImageCache *imageCache = [FICImageCache sharedImageCache];
    [imageCache setFormats:[ImageFormats imageFormats]];
    
    YappModel *yapp = [YappModel new];
    yapp.guid = @"AC585451-1F18-4353-B1A9-86857677F00C";
    yapp.thumbImageUrl = @"http://du45pr7qbd8vo.cloudfront.net/feda6e96-b406-4395-9997-c89cd7497450/large.jpg";
    yapp.splashImageUrl = @"http://du45pr7qbd8vo.cloudfront.net/feda6e96-b406-4395-9997-c89cd7497450/splash.jpg";

    
    FICImageCacheCompletionBlock thumbCompletionBlock = ^(id <FICEntity> entity, NSString *formatName, UIImage *image) {
        YappModel *yapp = (YappModel *)entity;
        yapp.thumbImage = image;
        NSLog(@"Done with thumb!");
    };
    [imageCache asynchronouslyRetrieveImageForEntity:yapp withFormatName:ImageFormatNameYappThumbnail completionBlock:thumbCompletionBlock];
    
    FICImageCacheCompletionBlock splashCompletionBlock = ^(id <FICEntity> entity, NSString *formatName, UIImage *image) {
        YappModel *yapp = (YappModel *)entity;
        yapp.splashImage = image;
        NSLog(@"Done with splash!");
    };
    [imageCache asynchronouslyRetrieveImageForEntity:yapp withFormatName:ImageFormatNameYappSplash completionBlock:splashCompletionBlock];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
