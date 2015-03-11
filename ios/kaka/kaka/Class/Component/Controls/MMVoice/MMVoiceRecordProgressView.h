//
//  MMVoiceRecordProgressView.h
//  moumou
//
//  Created by towne on 10/30/14.
//  Copyright (c) 2014 com.feiniu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMVoiceRecordProgressView : UIImageView
{
    UILabel * _label;
    
    UIImageView * _voiceimage;
    
    UIImageView * _progressImage;
    
    UIImageView * _cancelImage;
    
    UIImageView * _labelBackView;
    
    UIImageView * _alertImage;
}
+(MMVoiceRecordProgressView*)shareButton;
-(void)setStrength:(int)level;
-(void)show;
-(void)hide;
-(void)willHide;
-(void)reShow;
-(void)recordTimeSmall;
-(void)recordTimeBig;

@end
