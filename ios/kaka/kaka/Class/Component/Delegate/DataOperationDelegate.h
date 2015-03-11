//
//  DataOperationDelegate.h
//  moumou
//
//  Created by towne on 10/30/14.
//  Copyright (c) 2014 com.feiniu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DataOperationDelegate <NSObject>
@optional
+(id<DataOperationDelegate>)dataFromDbForKey:(NSString*)key;
+(id<DataOperationDelegate>)dataFromDb:(NSString*)where;
-(void)formatInsertToDB;
-(void)formatInsertToDB:(void(^)(BOOL success))callback;
-(void)formatUpdateToDb;
-(void)formatUpdateToDb:(void(^)(BOOL success))callback;
-(void)updateData:(NSString*)name;
-(void)copyData:(id)data;
-(void)initData;
@end
