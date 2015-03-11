//
//  MMTalkData.h
//  moumou
//
//  Created by towne on 10/30/14.
//  Copyright (c) 2014 com.feiniu. All rights reserved.
//
#define IMAGE_MAX_WIDTH  150
#define IMAGE_MAX_HEIGHT  100
#import "MatchParserData.h"
typedef NS_ENUM(NSUInteger, MMTalkContentType) {
    MMTalkContentTypeText,
    MMTalkContentTypeImage,
    MMTalkContentTypeSound,
    MMTalkContentTypeFile,
    MMTalkContentTypeVedio,
    MMTalkContentTypePlace
};

typedef NS_ENUM(NSUInteger, MMTalkStatus) {
    MMTalkStatusNone,
    MMTalkStatusIsUploading,
    MMTalkStatusDownloadFailed,
    MMTalkStatusUploadFailed,
    MMTalkStatusDownloadFinish,
    MMTalkStatusUploadFinish,
    MMTalkStatusShouldDownlad
};

typedef NS_ENUM(NSUInteger, MMTalkSoundStatus) {
    MMTalkSoundStatusNormal,
    MMTalkSoundStatusIsplaying,
    MMTalkSoundStatusISRecording
};

typedef NS_ENUM(NSUInteger, MMTalkReachStatu) {
    MMTalkReachStatuOut,
    MMTalkReachStatuReach,
    MMTalkReachStatuRead
};


@interface MMTalkData : MatchParserData
@property(nonatomic)MMTalkContentType type;
@property(nonatomic)MMTalkStatus status;
@property(nonatomic)MMTalkSoundStatus soundStatu;
@property(nonatomic,strong)NSString * time;
@property(nonatomic,strong)NSString * friendJid;
@property(nonatomic,strong)NSString * loginJid;
@property(nonatomic,strong)NSString * friendId;
@property(nonatomic,strong)NSString * loginId;

@property(nonatomic,strong)NSString * friendHeadUrl;
@property(nonatomic,strong)NSString * friendName;
@property(nonatomic)NSUInteger talkId;

@property(nonatomic)NSInteger soundTime;
@property(nonatomic)BOOL fromSelf;
@property(nonatomic)BOOL soundPlaying;
@property(nonatomic)BOOL soundRecording;
@property(nonatomic)BOOL fileUploaded;
@property(nonatomic)BOOL showTime;
@property(nonatomic)BOOL readed;
@property(nonatomic)MMTalkReachStatu receipts;
@property(nonatomic,strong)NSString * receiptsId;
-(void)covert:(NSString*)msgBody;
-(NSString*)getMsgBody;

@end
