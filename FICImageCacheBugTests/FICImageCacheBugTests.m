//
//  FICImageCacheBugTests.m
//  FICImageCacheBugTests
//
//  Created by Luke Melia on 5/12/14.
//  Copyright (c) 2014 Yapp. All rights reserved.
//


#import <Specta/Specta.h>
#define EXP_SHORTHAND

#import <FICImageCache.h>
#import "YappModel.h"
#import "ImageFormats.h"
#import "ImageCacheDelegate.h"

SpecBegin(FICImageCacheBug)
describe(@"FICImageCacheBug", ^{
    it(@"doesn't crash", ^AsyncBlock{
        FICImageCache *imageCache = [FICImageCache sharedImageCache];
        [imageCache setFormats:[ImageFormats imageFormats]];
        ImageCacheDelegate __block *imageCacheDelegate = [ImageCacheDelegate new];
        imageCache.delegate = imageCacheDelegate;
        [imageCache reset];
        
        YappModel *yapp = [YappModel new];
        yapp.guid = @"AC585451-1F18-4353-B1A9-86857677F00C";
        yapp.thumbImageUrl = @"http://du45pr7qbd8vo.cloudfront.net/feda6e96-b406-4395-9997-c89cd7497450/large.jpg";
        yapp.splashImageUrl = @"http://du45pr7qbd8vo.cloudfront.net/feda6e96-b406-4395-9997-c89cd7497450/splash.jpg";
        
        NSUInteger __block waiting = 2;
        FICImageCacheCompletionBlock thumbCompletionBlock = ^(id <FICEntity> entity, NSString *formatName, UIImage *image) {
            YappModel *yapp = (YappModel *)entity;
            yapp.thumbImage = image;
            NSLog(@"Done with thumb!");
            waiting--;
            if (waiting == 0) {
                done();
            }
        };
        [imageCache asynchronouslyRetrieveImageForEntity:yapp withFormatName:ImageFormatNameYappThumbnail completionBlock:thumbCompletionBlock];
        
        FICImageCacheCompletionBlock splashCompletionBlock = ^(id <FICEntity> entity, NSString *formatName, UIImage *image) {
            YappModel *yapp = (YappModel *)entity;
            yapp.splashImage = image;
            NSLog(@"Done with splash!");
            waiting--;
            if (waiting == 0) {
                done();
            }
        };
        [imageCache asynchronouslyRetrieveImageForEntity:yapp withFormatName:ImageFormatNameYappSplash completionBlock:splashCompletionBlock];
    });
});

SpecEnd