//
//  MMTalkViewController.m
//  moumou
//
//  Created by towne on 10/30/14.
//  Copyright (c) 2014 com.feiniu. All rights reserved.
//

#import "MMTalkViewController.h"
#import "MMVoiceRecordProgressView.h"
#import "UITableView+Scroll.h"
#import "NSTimeUtil.h"
#import "BrowseViewController.h"
#import "NetworkUtil.h"
#import "HBFileCache.h"
#import "SelectImageTool.h"
#import "LookBigImageTool.h"
#import "Config.h"
#import "MMMessageData.h"

@interface MMTalkViewController ()
{
    NSString * phoneNumber;
    UIWebView * webView;
}
@end


@implementation MMTalkViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self makeNaviLeftButtonVisible:YES];
    
//    [[MMDBHelper shareDBHelper] createTableWithModelClass:[MMTalkData class]];
    
    [[MMDBHelper shareDBHelper] createTableWithModelClass:[MMMessageData class]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newMessageReceive:) name:MMTalkNewMenssageNotification object:nil];
    // Do any additional setup after loading the view.
    _chatView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-108)];
    [_chatView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _chatView.delegate=self;
    _chatView.dataSource=self;
    [self.view addSubview:_chatView];

    CGRect frame =  mmmtalktoolbar.frame;
    frame.origin.y=self.view.frame.size.height-44;
    mmmtalktoolbar.frame=frame;
    mmmtalktoolbar.delegate = self;
    mmmtalktoolbar.recordVoice.delegate=self;
    [self.view addSubview:mmmtalktoolbar];
    
    [self.view addTapAction:self action:@selector(tapAction)];
    _chatArray=[NSMutableArray array];
    
    _record=[[RecordAudio alloc]init];
    _record.delegate=self;
    
    _palyaudio=[[PlayAudio alloc]init];
    _palyaudio.delegate=self;
    
    [self loadTalkDatas];
    
    _headView=[[PageHeadView alloc]initWithFrame:CGRectMake(0, -60, 320, 60)];
    [self.chatView addSubview:_headView];
    [_headView setTarget:self];
    [_headView addBeginLoadAction:@selector(headViewBeginLoad)];
    
    [[MMDBHelper shareDBHelper] updateToDB:[MMTalkData class] set:[NSString stringWithFormat:@"readed=1"] where:[NSString stringWithFormat:@"friendId='%@' and loginId='%@'",self.friendJid,self.loginJid]];
    
    self.navigationItem.title=self.friendName;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(connectNotification:) name:MMTalkConnectNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netChange) name:NetWorkStatusChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiptNotification:) name:MMTalkReceiptNotification object:nil];
    
    /*
    if ([[[MMTalkTransfersCenter shareCenter] xmppStream]isConnected]&&[NetworkUtil getNetworkStatue]) {
        self.disconnectView.hidden=YES;
    }else{
        self.disconnectView.hidden=NO;
    }
     */
    
    [self.view bringSubviewToFront:self.disconnectView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(void)tapAction
{
    [mmmtalktoolbar dismissKeyBoard];
}
-(void)headViewBeginLoad
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self loadTalkDatas];
    });
}

/**
-(void)loadTalkDatas
{
    [NSGCDThread dispatchAsync:^{
        NSUInteger count=_chatArray.count;
        NSArray * array=[[MMDBHelper shareDBHelper] search:[MMTalkData class] where:[NSString stringWithFormat:@"friendId='%@' and loginId='%@'",self.friendJid,self.loginJid] orderBy:@"time desc" offset:count count:10];
        NSMutableArray * datas=[NSMutableArray array];
        if (array.count>0) {
            for (int i=array.count-1;i>=0;i--) {
                MMTalkData * data=[array objectAtIndex:i];
                MMTalkData * talk=[[MMTalkTransfersCenter shareCenter].uploadMsgs objectForKey:[NSNumber numberWithInteger:data.talkId]];
                if (talk) {
                    [datas addObject:talk];
                }else{
                    if (data.type==MMTalkContentTypeText) {
                        [data setMatch];
                    }
                    [datas addObject:data];
                }
            }
        }
        if (self.chatArray) {
            [datas addObjectsFromArray:self.chatArray];
        }
        [self initShowTime:datas];
        [NSGCDThread dispatchAsyncInMailThread:^{
            [_headView loadFinish];
            self.chatArray=datas;
            [self.chatView reloadData];
            if (count==0) {
                [_chatView scrollToBottom:NO];
            }
        }];
    }];
}
 **/

-(void)loadTalkDatas {
    [NSGCDThread dispatchAsync:^{
        NSUInteger count=_chatArray.count;
        NSArray * array=[[MMDBHelper shareDBHelper] search:[MMMessageData class] where:[NSString stringWithFormat:@"toid='%@' and uid='%@'",self.friendJid,self.loginJid] orderBy:@"time desc" offset:count count:10];
        NSMutableArray * datas=[NSMutableArray array];
        if (array.count>0) {
            for (NSInteger i=array.count-1;i>=0;i--) {
//                MMTalkData * data=[array objectAtIndex:i];
//                MMTalkData * talk=[[MMTalkTransfersCenter shareCenter].uploadMsgs objectForKey:[NSNumber numberWithInteger:data.talkId]];
//                if (talk) {
//                    [datas addObject:talk];
//                }else{
//                    if (data.type==MMTalkContentTypeText) {
//                        [data setMatch];
//                    }
//                    [datas addObject:data];
//                }
            }
        }
        if (self.chatArray) {
            [datas addObjectsFromArray:self.chatArray];
        }
        [self initShowTime:datas];
        [NSGCDThread dispatchAsyncInMailThread:^{
            [_headView loadFinish];
            self.chatArray=datas;
            [self.chatView reloadData];
            if (count==0) {
                [_chatView scrollToBottom:NO];
            }
        }];
    }];
}

-(void)initShowTime:(NSArray*)array
{
    MMTalkData * preData=nil;
    for (int i=0; i<array.count; i++) {
        MMTalkData * data=[array objectAtIndex:i];
        if (data.time.intValue-preData.time.intValue>5*60*60) {
            data.showTime=YES;
        }
        preData=data;
    }
}

-(void)newMessageReceive:(NSNotification*)notification
{
    MMMessageData * data=[notification object];
    if ([data.toid isEqual:self.friendJid]) {
        for (MMMessageData * talk in self.chatArray) {
            if (talk.uid==data.uid) {
                return;
            }
        }
//        if (data.type==MMTalkContentTypeText) {
//            [data setMatch];
//        }
        
        MMMessageData * preData=[self.chatArray lastObject];
        
        if (data.time.intValue-preData.time.intValue>5*60*60) {
            data.showTime=YES;
        }
        data.readed=YES;
        [data  formatUpdateToDb];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [_chatArray addObject:data];
           [self.chatView reloadData];
            [_chatView scrollToBottom];
        });
    }
}
-(void)connectNotification:(NSNotification*)notification
{
    NSNumber * number=[notification object];
    if (number.boolValue) {
        self.disconnectView.hidden=YES;
    }else{
        self.disconnectView.hidden=NO;
        if ([NetworkUtil getNetworkStatue]) {
            
//           [[MMTalkTransfersCenter shareCenter]  connectToServer:[NSString stringWithFormat:@"%@@%@",self.loginJid,self.host] password:@"123" host:self.host];
        }
    }
}
-(void)receiptNotification:(NSNotification*)notification
{
    NSNumber * number=[notification object];
    if (number) {
        NSUInteger talkId=number.integerValue;
        for (MMTalkData  * data in self.chatArray) {
            if (data.talkId==talkId) {
                data.receipts=MMTalkReachStatuReach;
                break;
            }
        }
    }
    [self.chatView reloadData];
}
-(void)netChange
{
    if ([NetworkUtil getNetworkStatue] ) {
        /*
        if ([[[MMTalkTransfersCenter shareCenter] xmppStream] isConnected]) {
            self.disconnectView.hidden=YES;
        }else{
            self.disconnectView.hidden=NO;
            [[MMTalkTransfersCenter shareCenter]  connectToServer:[NSString stringWithFormat:@"%@@%@",self.loginJid,self.host] password:@"123" host:self.host];
        }
         */
    }else{
        self.disconnectView.hidden=NO;
    }
}

#pragma -mark UITableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.chatArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MMTalkData * talk=[self.chatArray objectAtIndex:indexPath.row];
    return [MMTalkTableViewCell heightForData:talk];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MMTalkData * talk=[self.chatArray objectAtIndex:indexPath.row];
    MMTalkTableViewCell* cell= [MMTalkTableViewCell tableViewCellFor:talk tableView:self.chatView controller:self];
    cell.delegate=self;
    cell.tableView=self.chatView;
    [cell loadContent:talk];
    return  cell;
}
#pragma mark scrollview delegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate //手指弹开时调用的委托方法
{
    [_headView scrollViewDidEndDecelerating:scrollView];
}

-(void)talkTableCell:(MMTalkTableViewCell *)cell palySoundAction:(MMTalkData *)data readyCallback:(void(^)(BOOL ready))callback
{
    if (_playData!=data) {
        _playData.soundStatu=MMTalkSoundStatusNormal;
    }
    [_palyaudio play:data.content readyCallback:callback];
    _playData=(MMTalkData*)data;
}

-(void)talkTableCell:(MMTalkTableViewCell*)cell  deleteAction:(MMTalkData*)data
{
    NSInteger index=-1;
    for (NSUInteger i =0; i<_chatArray.count; i++) {
        MMTalkData * talk=[_chatArray objectAtIndex:i];
        if (talk.talkId==data.talkId) {
            index=i;
            break;
        }
    }
    if (index>=0) {
        [_chatArray removeObjectAtIndex:index];
    }
    [[MMDBHelper shareDBHelper] deleteToDB:data];
    [_chatView reloadData];
    
}

-(void)talkTableCell:(MMTalkTableViewCell *)cell stopPalySoundAction:(MMTalkData *)data
{
    [_palyaudio stopPlay];
    _playData=nil;
}


#pragma  -mark MMVoiceRecordButtonDelegate
-(void)voiceRecordBeginRecord:(MMVoiceRecordButton*)button
{
    [[MMVoiceRecordProgressView shareButton] show];
    [self startRecord];
}

-(void)voiceRecordEndRecord:(MMVoiceRecordButton *)button timeDuration:(float)duration
{
    [[MMVoiceRecordProgressView shareButton] hide];
    [self stopRecord:duration];
}

-(void)voiceRecordCancelRecord:(MMVoiceRecordButton *)button
{
    [[MMVoiceRecordProgressView shareButton] hide];
    [self cancelRecord];
}

-(void)voiceRecordContinueRecord:(MMVoiceRecordButton *)button
{
    [[MMVoiceRecordProgressView shareButton] reShow];
}

-(void)voiceRecordWillCancelRecord:(MMVoiceRecordButton *)button
{
    [[MMVoiceRecordProgressView shareButton] willHide];
}
-(void)voiceRecordRecordTimeSmall:(MMVoiceRecordButton *)button
{
    [[MMVoiceRecordProgressView shareButton] recordTimeSmall];
    [self cancelRecord];
}
-(void)voiceRecordRecordTimeBig:(MMVoiceRecordButton *)button
{

    [self stopRecord:60];
    [[MMVoiceRecordProgressView shareButton]  recordTimeBig];
}

#pragma  -makr MMTalkToolBarDelegate
-(void)talkToolBar:(MMTalkToolBar*)toolBar sendText:(NSString*)text
{
    [self.chatView scrollToBottom];
    [self sendTextMessage:text];
}
-(void)talkToolBar:(MMTalkToolBar*)toolBar changeHeight:(float)height
{
    [self.chatView scrollToBottom];
    if (self.chatView.contentSize.height<self.chatView.frame.size.height) {
        float y=44-height+(self.chatView.frame.size.height-self.chatView.contentSize.height);
        if (y>0) {
            y=0;
        }
        [UIView animateWithDuration:0.25 animations:^{
            self.chatView.frame=CGRectMake(0, y, 320, self.chatView.frame.size.height);
        }];
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            self.chatView.frame=CGRectMake(0, 44-height, 320, self.chatView.frame.size.height);
        }];
    }
}
-(void)talkToolBarSelectImage:(MMTalkToolBar*)toolBar
{
    if (self.selectImage&&[self.selectImage respondsToSelector:@selector(selectImage:viewController:sourceType:)]) {
        [self.selectImage selectImage:^(UIImage *image) {
            if (image) {
                [self sendImageMessage:image];
            }
        } viewController:self sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
}

-(void)talkToolBarTakeImage:(MMTalkToolBar*)toolBar
{
    if (self.selectImage&&[self.selectImage respondsToSelector:@selector(selectImage:viewController:sourceType:)]) {
        [self.selectImage selectImage:^(UIImage *image) {
            if (image) {
                [self sendImageMessage:image];
            }
        } viewController:self sourceType:UIImagePickerControllerSourceTypeCamera];
    }
}

#pragma -mark RecordAudioDelegate
- (void)updateMeters:(RecordAudio*)record level:(int)level
{
    [[MMVoiceRecordProgressView shareButton] setStrength:level];
}

#pragma -mark PlayAudioDelegate
-(void)PlayStatus:(int)status
{
    if (status==1) {
        _playData.soundStatu=MMTalkSoundStatusNormal;
        [self.chatView reloadData];
    }
}

#pragma -mark  MMTalkTableViewCellDelegate
-(void)talkTableViewCell:(MMTalkTableViewCell*)cell lookImage:(UIImageView*)imageView
{
    if (self.lookBigImage&&[self.lookBigImage respondsToSelector:@selector(lookBigImage:smallImageViews:bigImageUrls:viewController:)]) {
        if (cell.talk.content) {
            NSArray * smalls=[NSArray arrayWithObject:imageView];
            NSMutableString * url=[NSMutableString stringWithString:cell.talk.content];
            NSRange range=[url rangeOfString:@"_small"];
            if (range.location!=NSNotFound) {
                [url replaceCharactersInRange:range withString:@"_large"];
                NSArray * bigs=[NSArray arrayWithObject:url];
                 [self.lookBigImage lookBigImage:imageView smallImageViews:smalls bigImageUrls:bigs viewController:self];
            }else{
                NSArray * bigs=[NSArray arrayWithObject:cell.talk.content];
                [self.lookBigImage lookBigImage:imageView smallImageViews:smalls bigImageUrls:bigs viewController:self];
            }
        }
    }
}


#pragma -mark  HBCoreLabelDelegate
-(void)coreLabel:(HBCoreLabel*)coreLabel linkClick:(NSString*)linkStr
{
    BrowseViewController * controller=(BrowseViewController*)[self viewControllerForName:@"BrowseViewController" Class:[BrowseViewController class]];
    controller.url=linkStr;
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)coreLabel:(HBCoreLabel *)coreLabel phoneClick:(NSString *)linkStr
{
    UIActionSheet * action=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"打电话",nil, nil];
    action.tag=102;
    phoneNumber=linkStr;
    [action showInView:self.view.window];
}
-(void)coreLabel:(HBCoreLabel *)coreLabel mobieClick:(NSString *)linkStr
{
    UIActionSheet * action=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"打电话",nil, nil];
    action.tag=102;
    phoneNumber=linkStr;
    [action showInView:self.view.window];
}
#pragma mark -ActionSheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag==102){
        if(0==buttonIndex){
            NSString * string=[NSString stringWithFormat:@"tel:%@",phoneNumber];
            if(webView==nil)
                webView=[[UIWebView alloc]initWithFrame:self.view.bounds];
            [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:string]]];
            webView.hidden=YES;
            [self.view addSubview:webView];
        }
    }else if (actionSheet.tag==103){
        if(0==buttonIndex){
            NSString * string=[NSString stringWithFormat:@"tel:%@",phoneNumber];
            if(webView==nil)
                webView=[[UIWebView alloc]initWithFrame:self.view.bounds];
            [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:string]]];
            webView.hidden=YES;
            [self.view addSubview:webView];
        }else if(1==buttonIndex){
            MFMessageComposeViewController* contrller=[[MFMessageComposeViewController alloc]init];
            contrller.recipients=[NSArray arrayWithObject:phoneNumber];
            [self presentViewController:contrller animated:YES completion:nil];
        }
    }
}

#pragma -mark 私有
-(void) startRecord {
     [_record startRecord];
}
// 发送语音消息
-(void)stopRecord:(NSUInteger)duration {
    NSData *data = [_record stopRecord];
    [self sendSoundMessage:data durtion:duration];
}
-(void)cancelRecord{
    [_record cancelRecord];
}

-(void)sendTextMessage:(NSString*)text
{
    if ([NSStrUtil isEmptyOrNull:text]) {
        [[DialogUtil sharedInstance] showDlg:self.view textOnly:@"内容不能为空"];
        return;
    }
    
//    MMTalkData * data=[[MMTalkData alloc]init];
//    data.type=MMTalkContentTypeText;
//    data.content=text;
//    data.width=200;
//    [data setMatch];
//    [self sendMessage:data];
    
    MMMessageData * data = [[MMMessageData alloc] init];
    [data setCid:@"1234567890"];
    [data setUid:A];
    [data setToid:B];
    [data setChart:@"hello !"];
    [data setMode:@"1"];
    [self sendMessage:data];
    
}

-(void)sendImageMessage:(UIImage*)image
{
    MMTalkData * data=[[MMTalkData alloc]init];
    data.type=MMTalkContentTypeImage;
    data.content=[[HBFileCache shareCache] storeFile:UIImagePNGRepresentation(image)];
    [self sendMessage:data];
}

-(void)sendSoundMessage:(NSData*)sound durtion:(NSUInteger)durtion
{
    MMTalkData * data=[[MMTalkData alloc]init];
    data.type=MMTalkContentTypeSound;
    data.soundTime=durtion;
    data.content=[[HBFileCache shareCache] storeFile:sound];
    [self sendMessage:data];
}

-(NSString*)getRandom
{
    int y = (arc4random() % 1000) + 8999;
    NSDate *date=[NSDate date];
    NSTimeInterval  time=[date timeIntervalSince1970];
    NSString * string=[NSString stringWithFormat:@"%.0f_%d",time*100000,y];
    return string;
}

- (void)sendMessage:(MMMessageData *) data {
    
    [[MMTalkTransfersCenter shareCenter] sendMessage:data complete:^(NSMutableData *data) {
        NSLog(@">> %@", data);
    }];
//        [[MMTalkTransfersCenter shareCenter] sendMessage:data complete:^(BOOL success) {
//            [self.chatView reloadData];
//        }];
}

//-(void)sendMessage:(MMTalkData*)data
//{
//    data.receiptsId=[self getRandom];
//    data.readed=YES;
//    data.time=[NSTimeUtil getNowTime];
//    data.status=MMTalkStatusIsUploading;
//    data.fromSelf=YES;
//    data.width=200;
//    if (!self.loginHeadUrl) {
//        data.friendHeadUrl=@"http://ejt.s2.c2d.me/images/common/noavatar_large.png";
//    }else{
//        data.friendHeadUrl=self.loginHeadUrl;
//    }
//    if (!self.loginCname) {
//        data.friendName=@"1111";
//    }else{
//        data.friendName=self.loginCname;
//    }
//    
//    MMTalkData * preData=[self.chatArray lastObject];
//    if (data.time.intValue-preData.time.intValue>5*60*60) {
//        data.showTime=YES;
//    }
//    [_chatArray addObject:data];
//    [_chatView reloadData];
//    [_chatView scrollToBottom];
//    NSString * friend=[NSString stringWithFormat:@"%@@%@",self.friendJid,self.host];
//    data.friendJid=friend;
//    data.loginJid=[NSString stringWithFormat:@"%@@%@",self.loginJid,self.host];
//    data.friendId=self.friendJid;
//    data.loginId=self.loginJid;
//    [data formatInsertToDB];
////    [[MMTalkTransfersCenter shareCenter] sendMessage:data complete:^(BOOL success) {
////        [self.chatView reloadData];
////    }];
//}

+(void)getGrouptTalkData:(NSString*)loginJid offset:(NSUInteger)offset limit:(NSUInteger)limit callback:(void(^)(NSArray* groups))callback
{
   [[MMDBHelper shareDBHelper] search:[MMTalkData class] where:[NSString stringWithFormat:@"loginId='%@'",loginJid] orderBy:@"time desc" offset:(int)offset count:(int)limit groupby:@"friendJid" callback:^(NSMutableArray *array) {
       NSMutableArray * groups=[NSMutableArray array];
       for (MMTalkData * data in array) {
           MMTalkGroupData * group=[[MMTalkGroupData alloc]init];
           group.cname=data.friendName;
           group.friendJid=data.friendId;
           group.loginJid=data.loginId;
           group.cheadUrl=data.friendHeadUrl;
           if (data.type==MMTalkContentTypeText) {
               group.lastMsg=data.content;
           }else if (data.type==MMTalkContentTypeImage){
               group.lastMsg=@"[图片]";
           }else if(data.type==MMTalkContentTypeSound){
               group.lastMsg=@"[语音]";
           }
           group.lastTime=data.time;
           group.newCount=[[MMDBHelper shareDBHelper] rowCount:[MMTalkData class] where:[NSString stringWithFormat:@"friendId='%@' and loginId='%@' and readed=0",group.friendJid,group.loginJid]];
           [groups addObject:group];
       }
       if (callback) {
           callback(groups);
       }
    }];
}
@end
