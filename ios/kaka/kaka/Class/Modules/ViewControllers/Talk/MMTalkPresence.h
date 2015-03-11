//
//  MMTalkPresence.h
//  moumou
//
//  Created by towne on 10/30/14.
//  Copyright (c) 2014 com.feiniu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, MMTalkPresenceStatus) {
    MMTalkPresenceStatusAvailable,     //在线
    MMTalkPresenceStatusAway,      //离开
    MMTalkPresenceStatusDoNotDisturb,  //忙碌
    MMTalkPresenceStatusUnavailable // 离线
};

@interface MMTalkPresence : NSObject
@property(nonatomic,strong)NSString * friendJid;
@property(nonatomic)MMTalkPresenceStatus status ;
@end
