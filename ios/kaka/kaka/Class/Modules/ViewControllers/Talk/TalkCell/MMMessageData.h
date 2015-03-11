//
//  MMMessageData.h
//  moumou
//
//  Created by towne on 3/9/15.
//  Copyright (c) 2015 com.feiniu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MatchParserData.h"

@interface MMMessageData : MatchParserData

@property(nonatomic,strong)NSString * cid;
@property(nonatomic,strong)NSString * uid;
@property(nonatomic,strong)NSString * toid;
@property(nonatomic,strong)NSString * chart;
@property(nonatomic,strong)NSString * pic;
@property(nonatomic,strong)NSString * video;
@property(nonatomic,strong)NSString * record;
@property(nonatomic,strong)NSString * time;
@property(nonatomic,strong)NSString * mode;

@property(nonatomic)BOOL showTime;
@property(nonatomic)BOOL readed;

@end
