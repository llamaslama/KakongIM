//
//  ServiceParam.m
//  moumou
//
//  Created by towne on 10/30/14.
//  Copyright (c) 2014 com.feiniu. All rights reserved.
//

#import "ServiceParam.h"
@implementation ServiceParam

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

-(ServiceParam*)initWithMode:(NSString*)parammode
{
    if(self=[super init]) {
        self.mode=parammode;
    }
    return self;
}
@end
