//
//  MMMessageData.m
//  moumou
//
//  Created by towne on 3/9/15.
//  Copyright (c) 2015 com.feiniu. All rights reserved.
//

#import "MMMessageData.h"

@implementation MMMessageData

-(void)formatUpdateToDb
{
    [self formatUpdateToDb:nil];
}

-(void)formatUpdateToDb:(void (^)(BOOL))callback
{
    [[MMDBHelper shareDBHelper] updateToDB:self where:[NSString stringWithFormat:@"cid=%lu",(unsigned long)self.cid] callback:callback];
}

@end
