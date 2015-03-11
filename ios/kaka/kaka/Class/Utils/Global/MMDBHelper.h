//
//  MMDBHelper.h
//  DoctorClient
//
//  Created by weqia on 14-4-25.
//  Copyright (c) 2014年 MM. All rights reserved.
//

#import "LKDBHelper.h"
#import "NewIdData.h"
@interface MMDBHelper : LKDBHelper
{
    NSLock * _thlock;
}
+(instancetype)shareDBHelper;
-(int)newIdforTable:(Class)cls;

@end
