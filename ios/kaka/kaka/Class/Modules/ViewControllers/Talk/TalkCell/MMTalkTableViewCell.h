//
//  MMTalkTableViewCell.h
//  moumou
//
//  Created by towne on 10/30/14.
//  Copyright (c) 2014 com.feiniu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMTalkData.h"
#import "UIImageView+Cache.h"
#import "HBCoreLabel.h"
#import "MMTalkTransfersCenter.h"
@class MMTalkTableViewCell;
@class MMTalkData;
@protocol MMTalkTableViewCellDelegate <NSObject>

@optional
-(void)talkTableViewCell:(MMTalkTableViewCell*)cell lookImage:(UIImageView*)imageView;
-(void)talkTableCell:(MMTalkTableViewCell *)cell palySoundAction:(MMTalkData *)data readyCallback:(void(^)(BOOL ready))callback;

-(void)talkTableCell:(MMTalkTableViewCell *)cell stopPalySoundAction:(MMTalkData *)data;

-(void)talkTableCell:(MMTalkTableViewCell*)cell  deleteAction:(MMTalkData*)data;

@end


@interface MMTalkTableViewCell : UITableViewCell<UIActionSheetDelegate>
@property(nonatomic,weak)IBOutlet UIImageView * mlogo;
@property(nonatomic,weak)IBOutlet UILabel * time;
@property(nonatomic,weak)IBOutlet UIView * backView;

@property(nonatomic,weak)IBOutlet UIActivityIndicatorView * indicator;
@property(nonatomic,weak)IBOutlet UIButton * btnFailed;

@property(nonatomic,weak)IBOutlet UILabel * receipts;
@property(nonatomic,weak)IBOutlet UIView * receiptsView;

@property(nonatomic,weak)UITableView * tableView;
@property(nonatomic,weak)id<MMTalkTableViewCellDelegate,HBCoreLabelDelegate>delegate;

@property(nonatomic,strong)MMTalkData * talk;
+(instancetype)tableViewCellFor:(MMTalkData*)data tableView:(UITableView*)tableView controller:(UIViewController*)controller;
+(float)heightForData:(MMTalkData*)data;
-(void)loadContent:(MMTalkData*)data;

-(void)upLoad;


@end
