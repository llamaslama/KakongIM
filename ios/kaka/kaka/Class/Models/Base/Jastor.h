//
//  Jastor.h
//  moumou
//
//  Created by towne on 10/30/14.
//  Copyright (c) 2014 com.feiniu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Jastor : NSObject<NSCoding>

@property (nonatomic, copy) NSString * objectId;

+ (id)objectFromDictionary:(NSDictionary*)dictionary;

- (id)initWithDictionary:(NSDictionary *)dictionary;

- (NSMutableDictionary *)toDictionary;

-(NSMutableDictionary*)toDictionaryWithProperty:(BOOL(^)(NSString * propertyName))property;


@end
