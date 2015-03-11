//
//  MMTalkToolBar.h
//  moumou
//
//  Created by towne on 10/30/14.
//  Copyright (c) 2014 com.feiniu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMVoiceRecordButton.h"
#import "UIExpandingTextView.h"
#import "HBEmojiPageView.h"
#import "MMTalkToolContainerView.h"

@class MMTalkToolBar;

@protocol MMTalkToolBarDelegate <NSObject>

-(void)talkToolBar:(MMTalkToolBar*)toolBar sendText:(NSString*)text;

-(void)talkToolBar:(MMTalkToolBar*)toolBar changeHeight:(float)height;

-(void)talkToolBarSelectImage:(MMTalkToolBar*)toolBar;

-(void)talkToolBarTakeImage:(MMTalkToolBar*)toolBar;

@end

@interface MMTalkToolBar : UIView<HBEmojiPageViewDelegate,UIExpandingTextViewDelegate>
@property(nonatomic,weak)IBOutlet UIButton * btnFace;
@property(nonatomic,weak)IBOutlet UIButton * btnAdd;

@property(nonatomic,weak)IBOutlet UIButton * btnKeyboard;
@property(nonatomic,weak)IBOutlet UIButton * btnSend;
@property(nonatomic,weak)IBOutlet UIButton * btnVoice;


@property(nonatomic,weak)IBOutlet MMVoiceRecordButton * recordVoice;
@property(nonatomic,weak)IBOutlet UIExpandingTextView * textView;
@property(nonatomic,strong,readonly)HBEmojiPageView * emojiPageView;
@property(nonatomic,strong,readonly)UIView * picView;
@property(nonatomic,weak)id<MMTalkToolBarDelegate>delegate;

+(instancetype)newTalkToolBar:(id)owner;

-(void)dismissKeyBoard;

@end
