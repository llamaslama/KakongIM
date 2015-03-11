//
//  MMTalkViewController.h
//  moumou
//
//  Created by towne on 10/30/14.
//  Copyright (c) 2014 com.feiniu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMTalkToolBar.h"
#import "MMBaseViewController.h"
#import "RecordAudio.h"
#import "PlayAudio.h"
#import "MMTalkTableViewCell.h"
#import <MessageUI/MessageUI.h>
#import "PageHeadView.h"
#import "MMTalkTransfersCenter.h"
#import "MMTalkGroupData.h"
@interface MMTalkViewController : MMBaseViewController<MMTalkToolBarDelegate,MMVoiceRecordButtonDelegate,RecordAudioDelegate,UITableViewDelegate,UITableViewDataSource,MMTalkTableViewCellDelegate,HBCoreLabelDelegate,PlayAudioDelegate,UIActionSheetDelegate>

@property(nonatomic,strong) UITableView    * chatView;
@property(nonatomic,strong) NSMutableArray * chatArray;
@property(nonatomic,strong) PageHeadView   * headView;
@property(nonatomic,strong) RecordAudio    * record;
@property(nonatomic,strong) PlayAudio      * palyaudio;
@property(nonatomic,strong) MMTalkData     * playData;

@property(nonatomic,strong) UIView         * disconnectView;


@property(nonatomic,weak) id<UIViewControllerOperationDelegate>selectImage;

@property(nonatomic,weak) id<UIViewControllerOperationDelegate>selectVedio;

@property(nonatomic,weak) id<UIViewControllerOperationDelegate>selectPlace;

@property(nonatomic,weak) id<UIViewControllerOperationDelegate>selectFile;

@property(nonatomic,weak) id<UIViewControllerOperationDelegate>lookBigImage;


///////////以下为调用聊天界面的接口

@property(nonatomic,strong)NSString * loginJid;
@property(nonatomic,strong)NSString * friendJid;
@property(nonatomic,strong)NSString * loginHeadUrl;
@property(nonatomic,strong)NSString * loginCname;
@property(nonatomic,strong)NSString * host;
@property(nonatomic,strong)NSString * friendName;
+(void)getGrouptTalkData:(NSString*)loginJid offset:(NSUInteger)offset limit:(NSUInteger)limit callback:(void(^)(NSArray* groups))callback; //获取聊天记录的分组信息。
@end
