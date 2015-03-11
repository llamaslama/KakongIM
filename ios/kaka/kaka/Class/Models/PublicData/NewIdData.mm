//
//  NewIdData.m
//  moumou
//
//  Created by towne on 10/30/14.
//  Copyright (c) 2014 com.feiniu. All rights reserved.
//

#import "NewIdData.h"

@implementation NewIdData
@synthesize tableId,tableName;
+(NSString *)getPrimaryKey
{
    return @"tableName";
}
+(NSString *)getTableName
{
    return @"NewIdData";
}

@end
