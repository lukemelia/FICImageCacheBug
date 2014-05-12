//
//  ImageFormats.m
//  yapp-ios
//
//  Created by Kris Selden on 3/19/14.
//  Copyright (c) 2014 Luke Melia. All rights reserved.
//

#import "ImageFormats.h"
#import <FICImageFormat.h>

NSString *ImageFormatNameYappThumbnail = @"YappThumbnail";
NSString *ImageFormatNameYappSplash = @"YappSplash";

@implementation ImageFormats
+(NSArray *)imageFormats
{
    FICImageFormat *yappThumbnail = [[FICImageFormat alloc] init];
    yappThumbnail.name = ImageFormatNameYappThumbnail;
    yappThumbnail.style = FICImageFormatStyle32BitBGR;
    yappThumbnail.imageSize = CGSizeMake(153, 220);
    yappThumbnail.maximumCount = 250;
    yappThumbnail.devices = FICImageFormatDevicePhone | FICImageFormatDevicePad;
    
    FICImageFormat *yappSplash = [[FICImageFormat alloc] init];
    yappSplash.name = ImageFormatNameYappSplash;
    yappSplash.style = FICImageFormatStyle32BitBGR;
    yappSplash.imageSize = CGSizeMake(320, 460);
    yappSplash.maximumCount = 250;
    yappSplash.devices = FICImageFormatDevicePhone | FICImageFormatDevicePad;
    
    return @[yappThumbnail, yappSplash];
}
@end
