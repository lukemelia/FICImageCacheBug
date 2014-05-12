//
//  ImageFormats.h
//  yapp-ios
//
//  Created by Kris Selden on 3/19/14.
//  Copyright (c) 2014 Luke Melia. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *ImageFormatNameYappThumbnail;
extern NSString *ImageFormatNameYappSplash;

@interface ImageFormats : NSObject
+(NSArray *)imageFormats;
@end
