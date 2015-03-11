//
//  MatchParserData.h
//  moumou
//
//  Created by towne on 10/30/14.
//  Copyright (c) 2014 com.feiniu. All rights reserved.
//

#import "BaseData.h"
#import "MatchParser.h"
#import "UIColor+setting.h"


@interface MatchParserData : BaseData<MatchParserDelegate>
{
    __weak MatchParser * _match;
}
@property(nonatomic)float width;
@property(nonatomic)float height;
@property(nonatomic,strong)NSString * content;
+(NSCache*)shareCache;
@end
