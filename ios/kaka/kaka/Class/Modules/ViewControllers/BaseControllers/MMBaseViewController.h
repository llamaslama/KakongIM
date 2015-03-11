//
//  MMBaseViewController.h
//  moumou
//
//  Created by towne on 10/30/14.
//  Copyright (c) 2014 com.feiniu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerCommunicationDelegate.h"
#import "UIImageView+Cache.h"
#import "UIViewControllerOperationDelegate.h"
#import "UIView+Global.h"
#import "NSViewUtil.h"
#import "DialogUtil.h"
#import "NSTimeUtil.h"
@interface MMBaseViewController : UIViewController<UIViewControllerCommunicationDelegate>
-(void)loadDataFromServer:(void(^)(id object))complete;

- (UIButton *)leftButton;
- (UIButton *)rightButton;
- (void)makeNaviLeftButtonVisible:(BOOL)aVisible;
- (void)makeNaviRightButtonVisible:(BOOL)aVisible;

@end


@interface UIViewController (Base)

-(UIViewController<UIViewControllerCommunicationDelegate>*)viewControllerForName:(NSString*)name Class:(Class)Class;

@end

