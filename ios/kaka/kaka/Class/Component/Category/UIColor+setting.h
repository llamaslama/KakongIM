//
//  UIColor+setting.h
//  moumou
//
//  Created by towne on 10/30/14.
//  Copyright (c) 2014 com.feiniu. All rights reserved.
//

#import <UIKit/UIKit.h>
#define BACKGROUND_COLOR 0xF8F8F8
#define TEXTFILED_COLOR 0x8C8C8C
#define HEIGHT_TEXT_COLOR  0x336699
#define SETTING_BACK_COLOR 0xECECEC
#define LINE_BG 0xE1E1E1

@interface UIColor (setting)
+ (UIColor *)colorWithIntegerValue:(NSUInteger)value alpha:(CGFloat)alpha;
@end
