//
//  NSOperationQueue+global.h
//  moumou
//
//  Created by towne on 10/30/14.
//  Copyright (c) 2014 com.feiniu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSOperationQueue (global)
+(id)uploadQueue;
+(id)downLoadQueue;
+(id)operationQueue;
+(id)dboprationQueue;
+(id)otherQueue;
@end
