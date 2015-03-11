//
//  HBImageScroller.h
//  moumou
//
//  Created by towne on 10/30/14.
//  Copyright (c) 2014 com.feiniu. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    RegionTopLeft=1,
    RegionBottomLeft,
    RegionTopRight,
    RegionBottomRight,
    RegionCenter
} LocationRegion;
@interface HBImageScroller : UIScrollView<UIActionSheetDelegate,UIScrollViewDelegate>
{
    UIImageView * _imageView;
    BOOL max;
    
    CGSize _beginSize;
    CGSize _beginImageSize;
    
    float _scale;
    float _imgScale;
    
    LocationRegion region;
   
}
@property(nonatomic,readonly) UIImageView * imageView;
@property(nonatomic,assign) UIViewController * controller;
@property(nonatomic,strong) id target;
@property(nonatomic) SEL tapOnceAction;

-(id)initWithImage:(UIImage*)image andFrame:(CGRect)frame; //  根据图片,frame初始化

-(void)setImage:(UIImage*)image;

-(void)setImageWithURL:(NSString*)url  andSmallImage:(UIImage*)image;

-(void)setImageWithURL:(NSString *)url ;

-(void)reset;  //还原

@end


