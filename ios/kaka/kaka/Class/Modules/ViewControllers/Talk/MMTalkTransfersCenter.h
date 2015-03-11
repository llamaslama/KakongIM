//
//  MMTalkTransfersCenter.h
//  moumou
//
//  Created by towne on 10/30/14.
//  Copyright (c) 2014 com.feiniu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMMessageData.h"
#import "MMTalkPresence.h"
#import "SocketIO.h"

#define MMTalkNewMenssageNotification  @"MMTalkNewMenssageNotification"     

#define MMTalkReceiptNotification      @"MMTalkReceiptNotification"

#define MMTalkPresenceNotification     @"MMTalkPresenceNotification"

#define MMTalkConnectNotification      @"MMTalkConnectNotification"

typedef void (^completeblock)(NSMutableData * data);

@interface MMTalkTransfersCenter : NSObject<SocketIODelegate>
@property(nonatomic,strong,readonly)   SocketIO      * socketIO;
@property(nonatomic,strong)            NSMutableData * resultData;
@property (strong, nonatomic)          completeblock   finishBlock;
@property(nonatomic,strong)            NSString      * useKey;
@property(nonatomic,strong,readonly)   NSString      * host;
@property(nonatomic)                   NSInteger       port;
@property(nonatomic)                   BOOL            connect;

+(instancetype)shareCenter;

-(void)connectToServer:(NSString *)host onPort:(NSInteger )port atUsekey:(NSString * )usekey;

-(void)sendMessage:(MMMessageData *)data complete:(completeblock ) block;

@end
