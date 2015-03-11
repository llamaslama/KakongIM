//
//  HBImageloadFomDatabaseOperation.h
//  moumou
//
//  Created by towne on 10/30/14.
//  Copyright (c) 2014 com.feiniu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HBImageLoadOperation.h"
#import "HBImageDownloadOperation.h"
@interface HBImageloadFomDatabaseOperation : NSOperation<HBImageLoadOperation>

@property (assign, nonatomic, getter = isExecuting) BOOL executing;
@property (assign, nonatomic, getter = isFinished) BOOL finished;
@property (strong, nonatomic,readonly) HBImageDownloaderCompletedBlock completeBlock;
@property (strong, nonatomic,readonly)  NSString * url;

+(HBImageloadFomDatabaseOperation*)operationWithURL:(NSString*)url complete:(HBImageDownloaderCompletedBlock)completeBlock;

@end
