//
//  RequestParam.h
//  moumou
//
//  Created by towne on 10/30/14.
//  Copyright (c) 2014 com.feiniu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jastor.h"

@interface RequestParam : Jastor

@property(nonatomic, readonly) NSMutableDictionary *strParam;
@property(nonatomic, readonly) NSMutableDictionary *fileParam;


//添加一个str的参数
- (void) put:(NSString *) key withValue: (NSString *) value;

-(void)putEmptyStringForKey:(NSString*)key;

//添加一个文件参数，传入文件路径
/**
 添加一个文件参数，传入文件路径
 value 可以是一个文件路径，也可以是一个NSData
 **/
- (void) putFile:(NSString *) key withValue: (id) value name:(NSString*)name mimeType:(NSString*)mimeType fileType:(NSString*)fileType;

@end
