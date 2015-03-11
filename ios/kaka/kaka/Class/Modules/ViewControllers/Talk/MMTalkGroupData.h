//
//  MMTalkGroupData.h
//  moumou
//
//  Created by towne on 10/30/14.
//  Copyright (c) 2014 com.feiniu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMTalkGroupData : NSObject
@property(nonatomic,strong)NSString * friendJid;
@property(nonatomic,strong)NSString * loginJid;
@property(nonatomic,strong)NSString * cname;
@property(nonatomic,strong)NSString * cheadUrl;
@property(nonatomic,strong)NSString * lastMsg;
@property(nonatomic,strong)NSString * lastTime;
@property(nonatomic)NSUInteger  newCount;
@end
