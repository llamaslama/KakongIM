//
//  ResultEx.h
//  moumou
//
//  Created by towne on 10/30/14.
//  Copyright (c) 2014 com.feiniu. All rights reserved.
//

#import "Result.h"

@interface ResultEx : Result

- (BaseData *)getDataObject:(Class) cls;

- (NSArray *)getDataArray:(Class) cls;

- (BOOL) isSuccess;

+ (NSArray *)getDataArray:(Class) cls withStr:(NSString *) str;
+ (BaseData *)getDataObject:(Class) cls withStr:(NSString*) str;

@end
