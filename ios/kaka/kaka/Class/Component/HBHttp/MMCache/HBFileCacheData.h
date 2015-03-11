//
//  HBFileCacheData.h
//  moumou
//
//  Created by towne on 10/30/14.
//  Copyright (c) 2014 com.feiniu. All rights reserved.
//

#import "BaseData.h"
@interface HBFileCacheData : BaseData
@property (nonatomic,strong) NSString * cacheFileName;
@property (nonatomic,strong) NSString * filekey;
@property (nonatomic)int cacheId;
@end
