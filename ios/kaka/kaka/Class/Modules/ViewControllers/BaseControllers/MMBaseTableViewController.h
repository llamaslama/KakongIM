//
//  MMBaseTableViewController.h
//  moumou
//
//  Created by towne on 10/30/14.
//  Copyright (c) 2014 com.feiniu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMBaseViewController.h"
@interface MMBaseTableViewController : UITableViewController<UIViewControllerCommunicationDelegate>

-(void)backAction;

-(void)rightButtonAction;
-(void)loadDataFromServer:(void(^)(id object))complete;
@end
