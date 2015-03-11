//
//  MMTalkToolContainerView.m
//  moumou
//
//  Created by towne on 10/30/14.
//  Copyright (c) 2014 com.feiniu. All rights reserved.
//

#import "MMTalkToolContainerView.h"

@implementation MMTalkToolContainerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
+(instancetype)newContainerView:(id)owner
{
    MMTalkToolContainerView * view=[[[NSBundle mainBundle] loadNibNamed:@"MMTalkToolContainerView" owner:owner options:nil] lastObject];
    return view;
}
#pragma -mark 事件响应 
-(IBAction)btnPicAction:(id)sender
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(talkToolTackPic:)]) {
        [self.delegate talkToolTackPic:self];
    }
}
-(IBAction)btnFileAction:(id)sender
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(talkToolTackFile:)]) {
        [self.delegate talkToolTackFile:self];
    }
}
-(IBAction)btnPlaceAction:(id)sender
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(talkToolTackPlace:)]) {
        [self.delegate talkToolTackPlace:self];
    }
}
-(IBAction)btnVedioAction:(id)sender
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(talkToolTackVedio:)]) {
        [self.delegate talkToolTackVedio:self];
    }
}


@end
