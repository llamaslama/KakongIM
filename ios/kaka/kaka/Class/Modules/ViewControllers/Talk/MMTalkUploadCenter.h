//
//  MMTalkUploadCenter.h
//  moumou
//
//  Created by towne on 10/30/14.
//  Copyright (c) 2014 com.feiniu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMTalkData.h"
@interface MMTalkUploadCenter : NSObject
+(instancetype)shareCenter;

-(void)sendMessage:(MMTalkData*)data complete:(void(^)(BOOL success))complete;


@end
