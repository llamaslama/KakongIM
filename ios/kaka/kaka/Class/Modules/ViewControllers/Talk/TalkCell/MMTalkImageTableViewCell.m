//
//  MMTalkImageTableViewCell.m
//  moumou
//
//  Created by towne on 10/30/14.
//  Copyright (c) 2014 com.feiniu. All rights reserved.
//

#import "MMTalkImageTableViewCell.h"
@implementation MMTalkImageTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    [self.image addTapAction:self action:@selector(lookImageAction)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)loadContent:(MMTalkData*)data
{
    [super loadContent:data];
    [self addImage];
}

-(void)addImage
{
    self.imageView.alpha=0;
    [self.image setImageWithURL:[NSURL URLWithString:self.talk.content] completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished, HBImageGetFrom imageFrom) {
        [NSGCDThread dispatchAsyncInMailThread:^{
            float width,height;
            width=image.size.width;
            height=image.size.height;
            if (width>IMAGE_MAX_WIDTH) {
                height=height*IMAGE_MAX_WIDTH/width;
                width=IMAGE_MAX_WIDTH;
            }
            if (height>IMAGE_MAX_HEIGHT) {
                width=width*IMAGE_MAX_HEIGHT/height;
                height=IMAGE_MAX_HEIGHT;
            }
            [UIView animateWithDuration:0.2 animations:^{
                self.imageView.alpha=1;
                CGRect frame=self.backView.frame;
                frame.size=CGSizeMake(width+30, height+20);
                if (self.talk.fromSelf) {
                    frame.origin.x=270-frame.size.width;
                }
                self.backView.frame=frame;
            } completion:^(BOOL finished) {
                [self setNeedsLayout];
            }];
        }];
    }];
}

-(void)lookImageAction
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(talkTableViewCell:lookImage:)]) {
        [self.delegate talkTableViewCell:self lookImage:self.image];
    }
}


@end
