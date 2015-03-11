//
//  OTSTabView.h
//  OneStore
//
//  Created by huang jiming on 13-3-11.
//  Copyright (c) 2013年 OneStore. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OTSTabView;

@protocol OTSTabViewDelegate <NSObject>

- (void)tabView:(OTSTabView *)aTabView changeToIndex:(int)aIndex;

@end

@interface OTSTabView : UIView

@property(nonatomic, assign) NSInteger currentIndex;
@property(nonatomic, strong) UIView* backgroundView;

@property(nonatomic, strong) NSMutableArray* imageViews;

@property(nonatomic, strong) NSArray *normalImages;
@property(nonatomic, strong) NSArray *selImages;
@property(nonatomic, strong) NSArray *iconImages;

@property(nonatomic, strong) NSMutableArray* labels;
@property(nonatomic, strong) NSMutableArray* icons;
@property(nonatomic, assign) CGSize imageSize;

@property(nonatomic, assign) BOOL imageSizeToFit; //

@property(nonatomic, weak) id<OTSTabViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame
              texts:(NSArray *)aArray
              color:(UIColor *)aColor
               font:(UIFont *)aFont
       normalImages:(NSArray *)bArray
          selImages:(NSArray *)cArray
         iconImages:(NSArray *)dArray;

/**
 *  功能:更新View的label的文字内容
 */
- (void)updateWithTextAry:(NSArray *)aTextAry;

/**
 *  功能:选中某个tab
 */
- (void)selectIndex:(NSInteger)index;



@end
