//
//  UIViewControllerCommunicationDelegate.h
//  moumou
//
//  Created by towne on 10/30/14.
//  Copyright (c) 2014 com.feiniu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^viewControllerCommunicationCallback)(id data);

@protocol UIViewControllerCommunicationDelegate <NSObject>
@optional
@property(nonatomic,strong) viewControllerCommunicationCallback backActionCallback;
@property(nonatomic,strong) viewControllerCommunicationCallback updateActionCallback;


-(void)initDataForView:(NSDictionary*)dic;

-(void)initDataForView:(id)object forKey:(NSString*)key;

-(void)update;

-(void)update:(id)param;

@end
