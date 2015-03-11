//
//  UIColor+setting.m
//  moumou
//
//  Created by towne on 10/30/14.
//  Copyright (c) 2014 com.feiniu. All rights reserved.
//

#import "UIColor+setting.h"

@implementation UIColor (setting)


+ (UIColor *)colorWithIntegerValue:(NSUInteger)value alpha:(CGFloat)alpha {
    NSUInteger mask = 255;
    NSUInteger blueValue = value & mask;
    value >>= 8;
    NSUInteger greenValue = value & mask;
    value >>= 8;
    NSUInteger redValue = value & mask;
    return [UIColor colorWithRed:(CGFloat)(redValue / 255.0) green:(CGFloat)(greenValue / 255.0) blue:(CGFloat)(blueValue / 255.0) alpha:alpha];
}
@end

