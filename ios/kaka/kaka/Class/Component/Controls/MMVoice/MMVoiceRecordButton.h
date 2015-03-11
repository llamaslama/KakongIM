//
//  MMVoiceRecordButton.h
//  moumou
//
//  Created by towne on 10/30/14.
//  Copyright (c) 2014 com.feiniu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@class MMVoiceRecordButton;
@protocol MMVoiceRecordButtonDelegate <NSObject>

-(void)voiceRecordBeginRecord:(MMVoiceRecordButton*)button;

-(void)voiceRecordEndRecord:(MMVoiceRecordButton *)button timeDuration:(float)duration;

-(void)voiceRecordCancelRecord:(MMVoiceRecordButton *)button;

-(void)voiceRecordContinueRecord:(MMVoiceRecordButton *)button;

-(void)voiceRecordWillCancelRecord:(MMVoiceRecordButton *)button;

-(void)voiceRecordRecordTimeSmall:(MMVoiceRecordButton *)button;

-(void)voiceRecordRecordTimeBig:(MMVoiceRecordButton *)button;


@end

@interface MMVoiceRecordButton : UIView
{
    UILabel * _label;
    UIImageView * _backView;
    UIImageView * _voice;
    
    BOOL _isRecord;
    
    BOOL _cancel;
    
    NSTimer * _time;
    
    int _second;
    
    MBProgressHUD * _hud;
}
@property(nonatomic,strong)IBOutlet id<MMVoiceRecordButtonDelegate> delegate;
+(MMVoiceRecordButton*)newButton;
@end
