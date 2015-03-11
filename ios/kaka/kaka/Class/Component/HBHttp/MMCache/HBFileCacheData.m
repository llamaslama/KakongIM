//
//  HBFileCacheData.m
//  moumou
//
//  Created by towne on 10/30/14.
//  Copyright (c) 2014 com.feiniu. All rights reserved.
//

#import "HBFileCacheData.h"

@implementation HBFileCacheData
@synthesize filekey,cacheFileName,cacheId;
-(id)init{
    self= [super init];
    if(self){
        self.cacheFileName=nil;
        self.filekey=nil;
    }
    return self;
}

+(NSString *)getPrimaryKey
{
    return @"filekey";
}

+(NSString *)getTableName
{
    return @"HBFileCacheData";
}


@end
