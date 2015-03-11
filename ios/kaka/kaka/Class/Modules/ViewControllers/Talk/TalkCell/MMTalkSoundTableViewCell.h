//
//  MMTalkSoundTableViewCell.h
//  moumou
//
//  Created by towne on 10/30/14.
//  Copyright (c) 2014 com.feiniu. All rights reserved.
//

#import "MMTalkTableViewCell.h"

@interface MMTalkSoundTableViewCell : MMTalkTableViewCell
@property(nonatomic,weak)IBOutlet UIImageView * voice;
@property(nonatomic,weak)IBOutlet UIImageView * voiceAnimation;
@property(nonatomic,weak)IBOutlet UILabel * playTime;
@end
