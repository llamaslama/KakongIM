//
//  OTSTabView.m
//  OneStore
//
//  Created by huang jiming on 13-3-11.
//  Copyright (c) 2013年 OneStore. All rights reserved.
//

#import "OTSTabView.h"
#import "UIView+Extension.h"
@interface OTSTabView()

@end

@implementation OTSTabView
@synthesize currentIndex = _currentIndex;

- (id)initWithFrame:(CGRect)frame
              texts:(NSArray *)aArray
              color:(UIColor *)aColor
               font:(UIFont *)aFont
       normalImages:(NSArray *)bArray
          selImages:(NSArray *)cArray
         iconImages:(NSArray *)dArray
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.normalImages = bArray;
        self.selImages = cArray;
        self.iconImages = dArray;
        
        int count = aArray.count;
        CGFloat width = frame.size.width/count;
        CGFloat height = frame.size.height;
        CGFloat xValue = 0.0;
        self.labels = [NSMutableArray arrayWithCapacity:count];
        self.imageViews = [NSMutableArray arrayWithCapacity:count];
        _imageSize = CGSizeMake(width, height);
        for (int i=0; i<count; i++) {
            NSString *normalImageName = [bArray objectAtIndex:i];
            NSString *selImageName = [cArray objectAtIndex:i];
            NSString *text= [aArray objectAtIndex:i];
            UIImageView *theIv = [[UIImageView alloc] initWithFrame:CGRectMake(xValue, 0, width, height)];
            theIv.tag = i;
            
            if (i == 0) {
                theIv.image = [UIImage imageNamed:selImageName];
                
            } else {
                theIv.image = [UIImage imageNamed:normalImageName];
            }
            
            [self layoutImageView:theIv];
            
           
            [self addSubview:theIv];
            [self.imageViews addObject:theIv];
            
            CGRect lblRect = CGRectIntegral(CGRectMake(xValue, 0, width, height));
            UILabel *theLbl = [[UILabel alloc] initWithFrame:lblRect];
            theLbl.backgroundColor = [UIColor clearColor];
            theLbl.numberOfLines = 2;
            theLbl.text = text;
            theLbl.textColor = aColor;
            theLbl.font = aFont;
            theLbl.textAlignment = NSTextAlignmentCenter;
 
            
            UIImageView *tempView = [[UIImageView alloc] initWithFrame:CGRectMake(18.0, 7.0, 15.0, 15.0)];
            NSString *tempicon;
            if (i == 1) {
                tempicon = [NSString stringWithFormat:@"%@_sel",[dArray objectAtIndex:i]];
            }
            else {
                tempicon = [NSString stringWithFormat:@"%@_nor",[dArray objectAtIndex:i]];
            }
            
            tempView.image = [UIImage imageNamed:tempicon];
            [theLbl addSubview:tempView];
            
            [self addSubview:theLbl];
            [self.icons addObject:tempView];
            [self.labels addObject:theLbl];
            
            
            
            xValue += width;
                //手势处理
            UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
            [theIv addGestureRecognizer:tapGes];
            theIv.userInteractionEnabled = YES;
            
            [self setCurrentIndex:0];
           
        }
    }
    return self;
}

- (void)setImageSizeToFit:(BOOL)imageSizeToFit
{
    if(_imageSizeToFit != imageSizeToFit){
        _imageSizeToFit = imageSizeToFit;
    }
	UIImageView * firstImageView = [_imageViews safeObjectAtIndex:0];
	[self layoutImageView:firstImageView];
}


- (void)setBackgroundView:(UIView *)backgroundView
{
    if(_backgroundView != backgroundView){
        [_backgroundView removeFromSuperview];
        _backgroundView = backgroundView;
        backgroundView.frame = self.bounds;
        [self insertSubview:backgroundView atIndex:0];
    }
}
- (void)updateWithTextAry:(NSArray *)aTextAry
{
    if(!aTextAry.count) {
        return;
    }
    
    int index = 0;
    for (NSString *text in aTextAry) {
        UILabel *label = [self.labels safeObjectAtIndex:index];
        label.text = text;
        index ++;
    }
}

-(NSArray *) icons {
    
    if (!_icons) {
        _icons = [[NSMutableArray alloc] init];
    }
    
    return _icons;
}

-(NSArray *) labels {
    
    if (!_labels) {
        _labels = [[NSMutableArray alloc] init];
    }
    
    return _labels;
}

- (void)layoutImageView:(UIImageView *)aImageView
{
    CGPoint center = aImageView.center;
    
    if(aImageView.image && _imageSizeToFit){
        [aImageView sizeToFit];
        aImageView.center = center;
    }
    else{
        aImageView.width = _imageSize.width;
        aImageView.height = _imageSize.height;
        aImageView.center = center;
    }
}

- (void)selectIndex:(NSInteger)index
{
    self.currentIndex = index;
    
    if ([self.delegate respondsToSelector:@selector(tabView:changeToIndex:)]) {
        [self.delegate tabView:self changeToIndex:self.currentIndex];
    }
}

- (void)setCurrentIndex:(NSInteger)index
{
    if (index >= self.imageViews.count) {
        return;
    }
    UIImageView *oldSelectImageView = [self.imageViews safeObjectAtIndex:self.currentIndex];
    UIImageView *currentSelectImageView = [self.imageViews safeObjectAtIndex:index];
    
    oldSelectImageView.image = [UIImage imageNamed:[self.normalImages objectAtIndex:self.currentIndex]];
    currentSelectImageView.image = [UIImage imageNamed:[self.selImages objectAtIndex:index]];
    
    [self layoutImageView:oldSelectImageView];
    [self layoutImageView:currentSelectImageView];
    
    _currentIndex = index;
    
    UIImageView * currenttempView;
    for (int i= 0; i<[self.icons count]; i++) {
        currenttempView = [self.icons objectAtIndex:i];
        if (i == _currentIndex) {
            currenttempView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_sel",[self.iconImages objectAtIndex:i]]];
        }
        else {
            currenttempView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_nor",[self.iconImages objectAtIndex:i]]];
        }
    }
}

- (void)handleTap:(UIPanGestureRecognizer*)gestureRecognizer
{   
    UIImageView *selIv = (UIImageView *)gestureRecognizer.view;
    NSInteger index = selIv.tag;
    [self selectIndex:index];
}


@end
