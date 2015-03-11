
//
//  MMTalkData.m
//  moumou
//
//  Created by towne on 10/30/14.
//  Copyright (c) 2014 com.feiniu. All rights reserved.
//

#import "MMTalkData.h"

@implementation MMTalkData

+(NSString *)getPrimaryKey
{
    return @"talkId";
}
+(NSString *)getTableName
{
    return @"MMTalkData";
}
-(instancetype)init
{
    self=[super init];
    if (self) {
        self.talkId=[[MMDBHelper shareDBHelper] newIdforTable:[self class]];
    }
    return self;
}

-(void)formatInsertToDB:(void(^)(BOOL success))callback
{
    [[MMDBHelper shareDBHelper] insertToDB:self callback:callback];
}
-(void)formatInsertToDB
{
    [self formatInsertToDB:nil];
}
-(void)formatUpdateToDb:(void (^)(BOOL))callback
{
    [[MMDBHelper shareDBHelper] updateToDB:self where:[NSString stringWithFormat:@"talkId=%lu",(unsigned long)self.talkId] callback:callback];
}
-(void)formatUpdateToDb
{
    [self formatUpdateToDb:nil];
}


-(void)covert:(NSString*)msgBody
{
    NSDictionary * dic=[msgBody objectFromJSONString];
    if ([dic isKindOfClass:[NSDictionary class] ]) {
        NSString * type=[dic objectForKey:@"type"];
        if ([type isEqual:@"1"]) {
            self.type=MMTalkContentTypeText;
        }else if([type isEqual:@"2"]){
            self.type=MMTalkContentTypeImage;
        }else if([type isEqual:@"3"]){
            self.type=MMTalkContentTypeSound;
        }
    }
    self.content=[dic objectForKey:@"content"];
}
-(NSString*)getMsgBody
{
    NSMutableDictionary * dic=[NSMutableDictionary dictionary];
    if (self.type==MMTalkContentTypeText) {
        [dic setObject:@"1" forKey:@"type"];
    }else if(self.type==MMTalkContentTypeImage){
        [dic setObject:@"2" forKey:@"type"];
    }else if(self.type==MMTalkContentTypeSound){
        [dic setObject:@"3" forKey:@"type"];
    }
    [dic setObject:self.content forKey:@"content"];
    return [dic JSONString];
}

@end
