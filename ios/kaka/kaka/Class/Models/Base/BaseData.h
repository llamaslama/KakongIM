//
//  BaseData.h
//  moumou
//
//  Created by towne on 10/30/14.
//  Copyright (c) 2014 com.feiniu. All rights reserved.
//

#import "Jastor.h"
#import "NSStrUtil.h"
#import "JSONKit.h"
#import "DataOperationDelegate.h"
#import "MMDBHelper.h"
@interface BaseData : Jastor<DataOperationDelegate>
@property(nonatomic) BOOL local;

@end
