//
//  MMTalkTransfersCenter.m
//  moumou
//
//  Created by towne on 10/30/14.
//  Copyright (c) 2014 com.feiniu. All rights reserved.
//

#import "MMTalkTransfersCenter.h"
#import "HBFileCache.h"
#import "UserService.h"
#import "NSTimeUtil.h"
#import "NetworkUtil.h"
#import "SocketIOPacket.h"
@implementation MMTalkTransfersCenter
+(instancetype)shareCenter
{
    static MMTalkTransfersCenter * center=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        center=[[MMTalkTransfersCenter alloc]init];
    });
    return center;
}
-(instancetype)init
{
    self=[super init];
    if (self) {
        _socketIO = [[SocketIO alloc] initWithDelegate:self];
    }
    return self;
}

-(void)connectToServer:(NSString *)host onPort:(NSInteger )port atUsekey:(NSString * )usekey
{
    _host = host;
    _port = port;
    _useKey = usekey;
    _connect = [self connect];
}

-(void)sendMessage:(MMMessageData *)data complete:(completeblock ) block {
    
    self.finishBlock = block;
    
    [_socketIO sendJSON:@{@"cid":data.cid,@"uid":data.uid,@"toid":data
                          .toid,@"chart":data.chart,@"mode":data.mode}];
    
//    if (![NetworkUtil getNetworkStatue]) {
//        data.status=MMTalkStatusUploadFailed;
//        [data formatUpdateToDb];
//        if (complete) {
//            complete(NO);
//        }
//        [self removeTalkDataForTalkID:data.talkId];
//        return;
//    }
//    [_uploadMsgs setObject:data forKey:[NSNumber numberWithInteger:data.talkId]];
//    if (data.type==MMTalkContentTypeText) {
//        [self sendXmppMessage:data complete:complete];
//    }else if(data.type==MMTalkContentTypeImage){
//        [self uploadData:^(BOOL success, id url) {
//            if (success) {
//                [[HBFileCache shareCache] forwardDataFromKey:data.content forKey:url];
//                data.content=url;
//                [self sendXmppMessage:data complete:complete];
//            }else{
//                data.status=MMTalkStatusUploadFailed;
//                [data formatUpdateToDb];
//                if (complete) {
//                    complete(NO);
//                }
//                [self removeTalkDataForTalkID:data.talkId];
//            }
//        } data:data];
//    }else if(data.type==MMTalkContentTypeSound){
//        [self uploadData:^(BOOL success, id url) {
//            if (success) {
//                [[HBFileCache shareCache] forwardDataFromKey:data.content forKey:url];
//                data.content=url;
//                [self sendXmppMessage:data complete:complete];
//            }else{
//                data.status=MMTalkStatusUploadFailed;
//                [data formatUpdateToDb];
//                if (complete) {
//                    complete(NO);
//                }
//                [self removeTalkDataForTalkID:data.talkId];
//            }
//        }data:data];
//    }
}



//-(void)removeTalkDataForTalkID:(NSInteger)talkID
//{
//    [_uploadMsgs removeObjectForKey:[NSNumber numberWithInteger:talkID]];
//}

/*
-(void)uploadData:(void(^)(BOOL success,id url))complete data:(MMTalkData*)data
{
    if (data.fileUploaded) {
        if (complete) {
            complete(YES,data.content);
        }
    }else{
        ServiceParam * param=[[ServiceParam alloc]init];
        
        
        [param put:@"from" withValue:data.loginId];
        [param put:@"to" withValue:data.friendId];
        NSString * fileName,*type;
        if (data.type==MMTalkContentTypeImage) {
            fileName=@"file.jpg";
            type=@"image";
        }else{
            fileName=@"file.amr";
            type=@"voice";
            [param put:@"recodTime" withValue:[NSString stringWithFormat:@"%ld",(long)data.soundTime]];
        }
        [param put:@"type" withValue:type];
         [param putFile:@"file" withValue:[[HBFileCache shareCache] filePathForKey:data.content]  name:fileName  mimeType:nil fileType:nil];
        [[[UserService alloc]init] uploadFileToServer:param completeBlock:^(id result) {
            if (complete) {
                complete(YES,result);
            }
        } failedBlock:^(id result) {
            if (complete) {
                complete(NO ,nil);
            }
        } view:nil];
    }
}
*/

-(void)goOnline{
    
    //发送在线状态
//    XMPPPresence *presence = [XMPPPresence presence];
//    [[self xmppStream] sendElement:presence];
    
}

-(void)goOffline{
    
    [_socketIO disconnect];
    
    //发送下线状态
//    XMPPPresence *presence = [XMPPPresence presenceWithType:@"unavailable"];
//    [[self xmppStream] sendElement:presence];
    
}

-(BOOL)connect{
    if (_socketIO) {
        [_socketIO connectToHost:_host onPort:_port];
    }
    //从本地取得用户名，密码和服务器地址
//    if (![xmppStream isDisconnected]) {
//        return YES;
//    }
    //设置用户
//    [xmppStream setMyJID:[XMPPJID jidWithString:_userName]];
    //设置服务器
//    [xmppStream setHostName:_host];
    //密码
    //连接服务器
//    NSError *error = nil;
//    if (![xmppStream connectWithTimeout:20 error:&error]) {
//        NSLog(@"cant connect ");
//        return NO;
//    }
    return YES;
}

-(void)disconnect{
    [self goOffline];
    _connect=NO;
}

//连接服务器
//- (void)xmppStreamDidConnect:(XMPPStream *)sender{
//    NSError *error = nil;
//    //验证密码
//    [[self xmppStream] authenticateWithPassword:_password error:&error];
//    [[NSNotificationCenter defaultCenter] postNotificationName:MMTalkConnectNotification object:[NSNumber numberWithBool:YES ] userInfo:nil];
//}

//- (void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error
//{
//    [[NSNotificationCenter defaultCenter] postNotificationName:MMTalkConnectNotification object:[NSNumber numberWithBool:NO ] userInfo:nil];
//}

//验证通过
//- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender{
//    [self goOnline];
//}

//收到消息
/*
- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message{
    
    NSXMLElement *received = [message elementForName:@"received"];
    if (received)
    {
        if ([received.xmlns isEqualToString:@"urn:xmpp:receipts"])//消息回执
        {
            NSString*  receiptsId;
            if([received attributeForName:@"id"]){
                receiptsId=[[received attributeForName:@"id"]stringValue];
            }else{
                receiptsId=[[message attributeForName:@"id"]stringValue];
            }
            MMTalkData* data=[[MMDBHelper shareDBHelper] searchSingle:[MMTalkData class] where:[NSString stringWithFormat:@"receiptsId='%@'",receiptsId] orderBy:nil];
            data.receipts=MMTalkReachStatuReach;
            [data formatUpdateToDb];
            [[NSNotificationCenter defaultCenter] postNotificationName:MMTalkReceiptNotification object:[NSNumber numberWithDouble:data.talkId] userInfo:nil];
            return;
        }
    }
    //    NSLog(@"message = %@", message);
    NSXMLElement *request = [message elementForName:@"request"];
	if (request)
	{
		if ([request.xmlns isEqualToString:@"urn:xmpp:receipts"])//消息回执
		{
			//组装消息回执
			XMPPMessage *msg = [XMPPMessage messageWithType:[message attributeStringValueForName:@"type"] to:message.from elementID:[message attributeStringValueForName:@"id"]];
			NSXMLElement *recieved = [NSXMLElement elementWithName:@"received" xmlns:@"urn:xmpp:receipts"];
            [received addAttributeWithName:@"id" stringValue:[message attributeStringValueForName:@"id"]];
			[msg addChild:recieved];
			
			//发送回执
			[self.xmppStream sendElement:msg];
		}
	}
    
    NSString *msg = [[message elementForName:@"body"] stringValue];
    NSString *from = [[message attributeForName:@"from"] stringValue];
    NSString * to=[[message attributeForName:@"to"] stringValue];
    NSString * subject=[[message elementForName:@"subject"]stringValue];
    
    NSRange range=[to rangeOfString:@"@"];
    NSMutableString * too=[NSMutableString stringWithString:[to substringToIndex:range.location]];
    
    
    range=[from rangeOfString:@"@"];
    NSMutableString * fromm=[NSMutableString stringWithString:[from substringToIndex:range.location]];
    
    //消息委托(这个后面讲)
    MMTalkData * data=[[MMTalkData alloc]init];
    data.friendId=[NSString stringWithString:fromm];
    data.loginId=[NSString stringWithString:too];
    
    [too appendFormat:@"@%@",_host];
    [fromm appendFormat:@"@%@",_host];
    data.friendJid=fromm;
    data.loginJid=too;
    
    NSXMLElement *properties=[message elementForName:@"properties"];
    for (NSXMLElement * ele in properties.children) {
        if ([ele.name isEqualToString:@"property"]) {
            [NSXMLProperty parserElement:ele callback:^(NSString *name, NSString *value) {
                if ([name isEqualToString:@"friendHeadUrl"]) {
                    data.friendHeadUrl=value;
                }else if([name isEqualToString:@"cname"]){
                    data.friendName=value;
                }else if([name isEqualToString:@"property"]){
                    data.soundTime=value.integerValue;
                }
            }];
        }
    }
    data.content=msg;
    data.time=[NSTimeUtil getNowTime];
    if ([subject isEqualToString:@"voice"]) {
        data.type=MMTalkContentTypeSound;
    }else if([subject isEqualToString:@"image"]){
        data.type=MMTalkContentTypeImage;
    }else{
        data.type=MMTalkContentTypeText;
        data.width=200;
    }
    
    [data formatInsertToDB:^(BOOL success) {
        [[NSNotificationCenter defaultCenter] postNotificationName:MMTalkNewMenssageNotification object:data userInfo:nil];
    }];
}


//消息发送失败
- (void)xmppStream:(XMPPStream *)sender didFailToSendMessage:(XMPPMessage *)message error:(NSError *)error
{
    NSXMLElement * ele=[message elementForName:@"talkId"];
    MMTalkData * data=[[MMDBHelper shareDBHelper] searchSingle:[MMTalkData class] where:[NSString stringWithFormat:@"talkId=%d",ele.stringValueAsInt] orderBy:nil];
    data.status=MMTalkStatusUploadFailed;
    [data formatUpdateToDb];
}

// 获取好友状态
- (void)xmppStream:(XMPPStream *)sender didReceivePresence:(XMPPPresence *)presence {
    NSString *presenceType = [presence type];
    NSString *presenceFromUser = [[presence from] user];
    if (![presenceFromUser isEqualToString:[[sender myJID] user]]) {
        MMTalkPresence * presence=[[MMTalkPresence alloc]init];
        presence.friendJid=presenceFromUser;
        if ([presenceType isEqualToString:@"available"]) {
            presence.status=MMTalkPresenceStatusAvailable;
        } else if ([presenceType isEqualToString:@"unavailable"]) {
            presence.status=MMTalkPresenceStatusUnavailable;
        }else if ([presenceType isEqualToString:@"do not disturb"]){
            presence.status=MMTalkPresenceStatusDoNotDisturb;
        }else if ([presenceType isEqualToString:@"away"]){
            presence.status=MMTalkPresenceStatusAway;
        }
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:MMTalkPresenceNotification object:presence userInfo:nil];
}



-(void)sendXmppMessage:(MMTalkData*)data complete:(void(^)(BOOL success))complete
{
    if (xmppStream.isConnected&&[NetworkUtil getNetworkStatue]) {
        NSXMLElement *mes = [NSXMLElement elementWithName:@"message"];
        [mes addAttributeWithName:@"id" stringValue:data.receiptsId];
        
        NSXMLElement *body = [NSXMLElement elementWithName:@"body"];
        [body setStringValue:data.content];
        
        [mes addChild:body];
        //生成XML消息文档
        //消息类型
        [mes addAttributeWithName:@"type" stringValue:@"chat"];
        //发送给谁
        [mes addAttributeWithName:@"to" stringValue:data.friendJid];
        //由谁发送
        [mes addAttributeWithName:@"from" stringValue:_userName];
        
        NSXMLElement *properties=[NSXMLElement elementWithName:@"properties" xmlns:@"http://www.jivesoftware.com/xmlns/xmpp/properties"];   //<properties xmlns="http://www.jivesoftware.com/xmlns/xmpp/properties">
        NSXMLElement * ele=[NSXMLProperty propertyElement:_userName forName:@"LoginJid"];
        [properties addChild:ele];
        
        ele=[NSXMLProperty propertyElement:data.friendHeadUrl forName:@"friendHeadUrl"];
        [properties addChild:ele];
        
        ele=[NSXMLProperty propertyElement:data.friendName forName:@"cname"];
        [properties addChild:ele];
        
        if (data.type==MMTalkContentTypeSound) {
            ele=[NSXMLProperty propertyElement:[NSString stringWithFormat:@"%ld",(long)data.soundTime] forName:@"property"];
            [properties addChild:ele];
        }else if(data.type==MMTalkContentTypeImage){
            ele=[NSXMLProperty propertyElement:[NSString stringWithFormat:@"%ld",(long)data.soundTime] forName:@"property"];
            [properties addChild:ele];
        }
        ele=[NSXMLProperty propertyElement:[NSString stringWithFormat:@"%@",data.content] forName:@"fileSendPath"];
        [properties addChild:ele];
       
        ele=[NSXMLProperty propertyElement:data.receiptsId forName:@"packetID"];
        [properties addChild:ele];
        
        [mes addChild:properties];
        NSXMLElement * subject=[NSXMLElement elementWithName:@"subject"];
        if (data.type==MMTalkContentTypeImage) {
            [subject setStringValue:@"image"];
        }else if(data.type==MMTalkContentTypeSound){
            [subject setStringValue:@"voice"];
        }else{
            [subject setStringValue:@"text"];
        }
        [mes addChild:subject];
        
        NSXMLElement *receipt = [NSXMLElement elementWithName:@"request" xmlns:@"urn:xmpp:receipts"];
        [mes addChild:receipt];
        //发送消息
        [[self xmppStream] sendElement:mes];
        data.status=MMTalkStatusUploadFinish;
        [data formatUpdateToDb];
        if (complete) {
            complete(YES);
        }
        [self removeTalkDataForTalkID:data.talkId];
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:MMTalkConnectNotification object:[NSNumber numberWithBool:NO ] userInfo:nil];
        data.status=MMTalkStatusUploadFailed;
        [data formatUpdateToDb];
        if (complete) {
            complete(NO);
        }
        [self removeTalkDataForTalkID:data.talkId];
    }
}
 */

# pragma mark -
# pragma mark socket.IO-objc delegate methods

- (void) socketIODidConnect:(SocketIO *)socket
{
    NSLog(@"socket.io connected.");
    
    //连接成功后绑定 sid - > _useKey
    
    if (_socketIO) {
        [_socketIO sendJSON:@{@"id":socket.sid,@"name":_useKey,@"mode":@"0"}];
    }
}

- (void) socketIO:(SocketIO *)socket didReceiveMessage:(SocketIOPacket *)packet {
    
    NSLog(@">>> %@",packet);
//    NSString * xxx = [packet data];
    
    if (!self.resultData) {
        self.resultData = [[NSMutableData alloc] init ];
    } else {
        [self.resultData setLength:0];
    }
    
    self.resultData = [NSMutableData dataWithData:[[packet data] dataUsingEncoding: NSUTF8StringEncoding]];
    
    if (self.finishBlock) {
        self.finishBlock(self.resultData);
    }
    
//    __alter(@"tit",xxx);
    
}

- (void) socketIO:(SocketIO *)socket onError:(NSError *)error
{
    if ([error code] == SocketIOUnauthorized) {
        NSLog(@"not authorized");
    } else {
        NSLog(@"onError() %@", error);
    }
    
    // 重新连接
    if (_socketIO) {
        [self connectToServer:_host onPort:_port atUsekey:_useKey];
    }
}

- (void) socketIODidDisconnect:(SocketIO *)socket disconnectedWithError:(NSError *)error
{
    NSLog(@"socket.io disconnected. did error occur? %@", error);
    [_socketIO disconnectForced];
}


@end
