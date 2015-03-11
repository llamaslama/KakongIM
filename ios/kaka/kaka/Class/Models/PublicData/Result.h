//
//  Result.h
//  moumou
//
//  Created by towne on 10/30/14.
//  Copyright (c) 2014 com.feiniu. All rights reserved.
//

#import "BaseData.h"

@interface Result : BaseData

@property (nonatomic, strong) NSString *ret;
@property (nonatomic, strong) NSString *object;
@property (nonatomic, strong) NSString *list;
@property (nonatomic, strong) NSString *msg;

@end
