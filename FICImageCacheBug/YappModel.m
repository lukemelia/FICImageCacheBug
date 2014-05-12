//
//  YappModel.m
//  yapp-ios
//
//  Created by Stefan Penner on 3/11/14.
//  Copyright (c) 2014 Luke Melia. All rights reserved.
//

#import "YappModel.h"
#import "ImageFormats.h"
#import "FICUtilities.h"

@implementation YappModel

#pragma mark FICEntity

-(NSString *)UUID
{
    NSAssert(self.guid && [self.guid length] == 36, @"YappModel guid missing");
    return FICStringWithUUIDBytes(FICUUIDBytesWithString(self.guid));
}

- (NSString *)sourceImageUUID {
    NSAssert([NSURL URLWithString:self.thumbImageUrl], @"YappModel thumbImageUrl missing or malformed");
    return FICStringWithUUIDBytes(FICUUIDBytesFromMD5HashOfString(self.thumbImageUrl));
}

-(NSURL *)sourceImageURLWithFormatName:(NSString *)formatName
{
    if (formatName == ImageFormatNameYappThumbnail) {
        return [NSURL URLWithString:self.thumbImageUrl];
    } else if (formatName == ImageFormatNameYappSplash) {
        return [NSURL URLWithString:self.splashImageUrl];
    }
    return nil;
}

-(FICEntityImageDrawingBlock)drawingBlockForImage:(UIImage *)image withFormatName:(NSString *)formatName
{
    return ^(CGContextRef context, CGSize contextSize) {
        CGRect contextBounds = CGRectZero;
        contextBounds.size = contextSize;
        CGContextClearRect(context, contextBounds);
        UIGraphicsPushContext(context);
        [image drawInRect:contextBounds];
        UIGraphicsPopContext();
    };
}
@end
