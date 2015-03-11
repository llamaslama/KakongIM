//
//  MMTalkUploadCenter.m
//  moumou
//
//  Created by towne on 10/30/14.
//  Copyright (c) 2014 com.feiniu. All rights reserved.
//

#import "MMTalkUploadCenter.h"

@implementation MMTalkUploadCenter

+(instancetype)shareCenter
{
    static MMTalkUploadCenter * center=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        center=[[MMTalkUploadCenter alloc]init];
    });
    return center;
}
-(void)sendMessage:(MMTalkData*)data complete:(void(^)(BOOL success))complete
{
    if (data.type==MMTalkContentTypeText) {
    }else if(data.type==MMTalkContentTypeImage){
    }else if(data.type==MMTalkContentTypeSound){
    }
}

@end
