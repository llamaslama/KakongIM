//
//  BaseData.m
//  moumou
//
//  Created by towne on 10/30/14.
//  Copyright (c) 2014 com.feiniu. All rights reserved.
//

#import "BaseData.h"

@implementation BaseData
+(int)getTableVersion
{
    return 1;
}
+(NSString *)getPrimaryKey
{
    return @"objectId";
}
+(id<DataOperationDelegate>)dataFromDbForKey:(NSString*)key
{
    return nil;
}

+(id<DataOperationDelegate>)dataFromDb:(NSString*)where
{
    return nil;
}

-(void)formatInsertToDB:(void(^)(BOOL success))callback
{}
-(void)formatInsertToDB
{
    
}
-(void)formatUpdateToDb
{}
-(void)formatUpdateToDb:(void(^)(BOOL success))callback
{}

-(void)updateData:(NSString*)name
{}

-(void)copyData:(id)data
{}
-(void)initData
{}
@end
