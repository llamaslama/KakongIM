//
//  ServiceParam.h
//  moumou
//
//  Created by towne on 10/30/14.
//  Copyright (c) 2014 com.feiniu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestParam.h"

@interface ServiceParam : RequestParam

@property (nonatomic,strong)NSString *  mode;
-(ServiceParam*)initWithMode:(NSString*)paramitype;

@end
