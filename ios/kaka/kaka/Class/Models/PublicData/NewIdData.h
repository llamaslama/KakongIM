//
//  NewIdData.h
//  moumou
//
//  Created by towne on 10/30/14.
//  Copyright (c) 2014 com.feiniu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseData.h"

@interface NewIdData : Jastor<DataOperationDelegate>

@property(nonatomic,strong)NSString * tableName;
@property(nonatomic) int tableId;

@end
