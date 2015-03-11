//
//  UserService.h
//  moumou
//
//  Created by towne on 10/30/14.
//  Copyright (c) 2014 com.feiniu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResultEx.h"
#import "ServiceParam.h"
#import "ASIFormDataRequest.h"
#import "NSOperationQueue+global.h"


@class UserService;

@interface UserService :NSObject
{
    void(^_complete)(id  result);
    void(^_failed)(id  result);
}
+ (UserService *)sharedInstance;

- (NSString*)getFileUploadUrl;

+ (NSString*)encodeBase64:(NSData*)data;
+ (NSString *)decodeBase64:(NSData *)data;

-(ASIHTTPRequest*)uploadFileToServer:(ServiceParam *)param completeBlock:(void(^)(id  result))completeBlock failedBlock:(void(^)(id result))failedBlock view:(UIView*)view;

-(void)cancel;
@end
