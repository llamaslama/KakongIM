//
//  MMTalkTextTableViewCell.m
//  moumou
//
//  Created by towne on 10/30/14.
//  Copyright (c) 2014 com.feiniu. All rights reserved.
//

#import "MMTalkTextTableViewCell.h"

@implementation MMTalkTextTableViewCell

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
    self.content.userInteractionEnabled=YES;
    self.content.font=[UIFont systemFontOfSize:15];
    
}
-(void)setDelegate:(id<MMTalkTableViewCellDelegate,HBCoreLabelDelegate>)delegate
{
    _content.delegate=delegate;
    [super setDelegate:delegate];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)loadContent:(MMTalkData*)data
{
    [super loadContent:data];
    [self addText];
}

-(void)addText
{
    [self.talk getMatch:^(MatchParser *parser, id data) {
        _content.match=parser;
        float width=parser.miniWidth;
        if (width<30) {
            width=30;
        }
        CGRect frame=self.backView.frame;
        frame.size.width=width+30;
        self.backView.frame=frame;
        [self setNeedsLayout];
    } data:self];
}


@end
