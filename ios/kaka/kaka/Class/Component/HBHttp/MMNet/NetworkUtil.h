//
//  NetworkUtil.h
//  moumou
//
//  Created by towne on 10/30/14.
//  Copyright (c) 2014 com.feiniu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

#define NetWorkStatusChangeNotification @"NetWorkStatusChangeNotification"
@interface NetworkUtil : NSObject

+ (BOOL) getNetworkStatue;
@property(nonatomic)BOOL isExistenceNetwork;
@property(nonatomic,strong)Reachability * reachability;

+(id)shareUtil;
-(void)startNotification;

@end
