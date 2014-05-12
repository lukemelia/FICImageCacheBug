//
//  YappModel.h
//  yapp-ios
//
//  Created by Stefan Penner on 3/11/14.
//  Copyright (c) 2014 Luke Melia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FICEntity.h>

@interface YappModel : NSObject<FICEntity>

@property (nonatomic) NSString *guid;
@property (nonatomic) NSString *thumbImageUrl;
@property (nonatomic) NSString *splashImageUrl;
@property (nonatomic) UIImage *thumbImage;
@property (nonatomic) UIImage *splashImage;

@end