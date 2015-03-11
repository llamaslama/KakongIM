//
//  MMTalkToolContainerView.h
//  moumou
//
//  Created by towne on 10/30/14.
//  Copyright (c) 2014 com.feiniu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MMTalkToolContainerView;

@protocol MMTalkToolContainerViewDelegate <NSObject>

-(void)talkToolTackPic:(MMTalkToolContainerView*)containerView;
-(void)talkToolTackFile:(MMTalkToolContainerView*)containerView;
-(void)talkToolTackPlace:(MMTalkToolContainerView*)containerView;
-(void)talkToolTackVedio:(MMTalkToolContainerView*)containerView;
@end


@interface MMTalkToolContainerView : UIView
@property(nonatomic,weak)IBOutlet UIButton * btnPic;
@property(nonatomic,weak)IBOutlet UIButton * btnFile;
@property(nonatomic,weak)IBOutlet UIButton * btnPlace;
@property(nonatomic,weak)IBOutlet UIButton * btnVedio;
@property(nonatomic,weak)id<MMTalkToolContainerViewDelegate>delegate;
+(instancetype)newContainerView:(id)owner;

@end
