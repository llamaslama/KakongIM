//
//  ViewController.m
//  SocketTesterARC
//
//  Created by Kyeck Philipp on 01.06.12.
//  Copyright (c) 2012 beta_interactive. All rights reserved.
//

#import "ViewController.h"
#import "SocketIOPacket.h"//;

//弹出框
#define __alter(title,msg)\
{\
UIAlertView*_alert=[[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];\
_alert.transform=CGAffineTransformMakeTranslation(0,80); \
[_alert show];\
}

const NSString* cid;

@interface ViewController ()

@end

@implementation ViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    // create socket.io client instance
    socketIO = [[SocketIO alloc] initWithDelegate:self];
    
    // you can update the resource name of the handshake URL
    // see https://github.com/pkyeck/socket.IO-objc/pull/80
    // [socketIO setResourceName:@"whatever"];
    
    // if you want to use https instead of http
    // socketIO.useSecure = YES;
    
    // pass cookie(s) to handshake endpoint (e.g. for auth)
    NSDictionary *properties = [NSDictionary dictionaryWithObjectsAndKeys:
                                    @"localhost", NSHTTPCookieDomain,
                                    @"/", NSHTTPCookiePath,
                                    @"auth", NSHTTPCookieName,
                                    @"56cdea636acdf132", NSHTTPCookieValue,
                                    nil];
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:properties];
    NSArray *cookies = [NSArray arrayWithObjects:cookie, nil];
    
    socketIO.cookies = cookies;
    
    // connect to the socket.io server that is running locally at port 3000
    
    [socketIO connectToHost:@"119.97.220.38" onPort:4810];
//    [socketIO connectToHost:@"192.168.0.100" onPort:4810];
//    [socketIO connectToHost:@"172.16.162.3" onPort:4810];
    
}

const NSString * A = @"towne";
const NSString * B = @"qi";

# pragma mark -
# pragma mark socket.IO-objc delegate methods

- (void) socketIODidConnect:(SocketIO *)socket
{
    NSLog(@"socket.io connected.");
    //连接成功后绑定 sid
    [socketIO sendJSON:@{@"id":socketIO.sid,@"name":A,@"mode":@"0"}];
}

- (IBAction)doSomething:(id)sender {
    [socketIO sendJSON:@{@"cid":@"1234567",@"uid":A,@"toid":B,@"chart":@"hello !",@"mode":@"1"}];
}

- (void) socketIO:(SocketIO *)socket didReceiveMessage:(SocketIOPacket *)packet {
    
    NSLog(@">>> %@",packet);
    NSString * xxx = [packet data];
    __alter(@"tit",xxx);
    
}

- (void) socketIO:(SocketIO *)socket didReceiveEvent:(SocketIOPacket *)packet
{
    NSLog(@"didReceiveEvent()");

    // test acknowledge
    SocketIOCallback cb = ^(id argsData) {
        NSDictionary *response = argsData;
        // do something with response
        NSLog(@"ack arrived: %@", response);
        
        // test forced disconnect
        [socketIO disconnectForced];
    };
    [socketIO sendMessage:@"hello back!" withAcknowledge:cb];
    
    // test different event data types
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"test1" forKey:@"key1"];
    [dict setObject:@"test2" forKey:@"key2"];
    [socketIO sendEvent:@"welcome" withData:dict];
    
    [socketIO sendEvent:@"welcome" withData:@"testWithString"];
    
    NSArray *arr = [NSArray arrayWithObjects:@"test1", @"test2", nil];
    [socketIO sendEvent:@"welcome" withData:arr];
}

- (void) socketIO:(SocketIO *)socket onError:(NSError *)error
{
    if ([error code] == SocketIOUnauthorized) {
        NSLog(@"not authorized");
    } else {
        NSLog(@"onError() %@", error);
    }
    [socketIO connectToHost:@"119.97.220.38" onPort:4810];
}


- (void) socketIODidDisconnect:(SocketIO *)socket disconnectedWithError:(NSError *)error
{
    NSLog(@"socket.io disconnected. did error occur? %@", error);
    [socketIO connectToHost:@"119.97.220.38" onPort:4810];
}

# pragma mark -

- (void) viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


@end
