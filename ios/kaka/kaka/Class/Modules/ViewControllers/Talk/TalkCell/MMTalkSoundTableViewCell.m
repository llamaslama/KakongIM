//
//  MMTalkSoundTableViewCell.m
//  moumou
//
//  Created by towne on 10/30/14.
//  Copyright (c) 2014 com.feiniu. All rights reserved.
//

#import "MMTalkSoundTableViewCell.h"

@implementation MMTalkSoundTableViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)awakeFromNib
{
    if (self.mlogo.frame.origin.x<100) {
        UIImage * image1=[UIImage imageNamed:@"ReceiverVoiceNodePlaying001"];
        UIImage * image2=[UIImage imageNamed:@"ReceiverVoiceNodePlaying002"];
        UIImage * image3=[UIImage imageNamed:@"ReceiverVoiceNodePlaying003"];
        self.voiceAnimation.animationImages=[NSArray arrayWithObjects:image1,image2,image3, nil];
        self.voiceAnimation.animationDuration=1;
    }else{
        UIImage * image1=[UIImage imageNamed:@"SenderVoiceNodePlaying001"];
        UIImage * image2=[UIImage imageNamed:@"SenderVoiceNodePlaying002"];
        UIImage * image3=[UIImage imageNamed:@"SenderVoiceNodePlaying003"];
        self.voiceAnimation.animationImages=[NSArray arrayWithObjects:image1,image2,image3, nil];
        self.voiceAnimation.animationDuration=1;
    }
    UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self.backView addGestureRecognizer:tap];
}

-(void)loadContent:(MMTalkData*)data
{
    [super loadContent:data];
    if (data.soundStatu==MMTalkSoundStatusIsplaying) {
        self.voiceAnimation.hidden=NO;
        [self.voiceAnimation startAnimating];
        self.voice.hidden=YES;
    }else{
        [self.voiceAnimation stopAnimating];
        self.voiceAnimation.hidden=YES;
        self.voice.hidden=NO;
    }
    self.playTime.text=[NSString stringWithFormat:@"%ldS",(long)self.talk.soundTime];
}

-(void)tapAction:(UIGestureRecognizer*)gesture
{
    if (self.talk.soundStatu==MMTalkSoundStatusIsplaying) {
        [self.talk setSoundStatu:MMTalkSoundStatusNormal];
        if (self.delegate&&[self.delegate respondsToSelector:@selector(talkTableCell:stopPalySoundAction:)]) {
            [self.delegate talkTableCell:self stopPalySoundAction:self.talk];
            [self.voiceAnimation stopAnimating];
            [self.tableView reloadData];
        }
        [self.tableView reloadData];
    }else if (self.talk.soundStatu==MMTalkSoundStatusNormal){
        if (self.delegate&&[self.delegate respondsToSelector:@selector(talkTableCell:palySoundAction:readyCallback:)]) {
            [self.delegate talkTableCell:self palySoundAction:self.talk readyCallback:^(BOOL ready) {
                if (ready) {
                    self.talk.soundStatu=MMTalkSoundStatusIsplaying;
                    [self.tableView reloadData];
                }
            }];
        }
    }
}


@end
