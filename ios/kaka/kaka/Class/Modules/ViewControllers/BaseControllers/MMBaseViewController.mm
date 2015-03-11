//
//  MMBaseViewController.m
//  moumou
//
//  Created by towne on 10/30/14.
//  Copyright (c) 2014 com.feiniu. All rights reserved.
//

#import "MMBaseViewController.h"

#define LOG_SELF_METHOD    NSLog(@"<%@> Called:'%@'", self, NSStringFromSelector(_cmd));

@interface MMBaseViewController ()
{
    viewControllerCommunicationCallback _backActionCallback;
    viewControllerCommunicationCallback _updateActionCallback;
}

@property(strong,nonatomic) UIButton * leftButton;
@property(strong,nonatomic) UIButton * rightButton;

@end


@implementation MMBaseViewController
@synthesize updateActionCallback=_updateActionCallback,backActionCallback=_backActionCallback;
@synthesize leftButton = _leftButton,rightButton = _rightButton;

#pragma -mark UIViewControllerCommunicationDelegate
- (void)viewDidLoad
{
    if (IOS_VERSION >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [super viewDidLoad];
    UIViewController * controller=[self.navigationController.viewControllers objectAtIndex:0];
	// Do any additional setup after loading the view.
}

-(void)initDataForView:(NSDictionary*)dic
{
}

-(void)initDataForView:(id)object forKey:(NSString*)key
{}

-(void)update
{}

-(void)update:(id)param
{}

-(void)loadDataFromServer:(void(^)(id object))complete
{
}


/**
 *  功能:显示左按钮
 *  aVisible:是否显示按钮
 */
- (void)makeNaviLeftButtonVisible:(BOOL)aVisible
{
    [self __makeNaviButtonVisible:aVisible isLeft:YES];
}

/**
 *  功能:显示右按钮
 *  aVisible:是否显示按钮
 */
- (void)makeNaviRightButtonVisible:(BOOL)aVisible
{
    [self __makeNaviButtonVisible:aVisible isLeft:NO];
}

/**
 *  功能:显示左/右按钮
 *  aVisible:是否显示按钮 aLeft:是否是左按钮
 */
- (void)__makeNaviButtonVisible:(BOOL)aVisible isLeft:(BOOL)aLeft
{
    if (aVisible) {
        if (aLeft) {
            if (self.navigationItem.leftBarButtonItem == nil) {
                UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftButton];
                self.navigationItem.leftBarButtonItem = btnItem;
            } else {
                self.navigationItem.leftBarButtonItem.customView.hidden = NO;
            }
        } else {
            if (self.navigationItem.rightBarButtonItem == nil) {
                UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
                self.navigationItem.rightBarButtonItem = btnItem;
            } else {
                self.navigationItem.rightBarButtonItem.customView.hidden = NO;
            }
        }
    } else {
        if (aLeft) {
            self.navigationItem.leftBarButtonItem.customView.hidden = YES;
            self.navigationItem.hidesBackButton = YES;
        } else {
            self.navigationItem.rightBarButtonItem.customView.hidden = YES;
        }
    }
}

- (UIButton *)leftButton
{
    if (_leftButton == nil) {
        _leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 66, 33)];
        [_leftButton setBackgroundImage:[UIImage imageNamed:@"pub_title_ico_back"] forState:UIControlStateNormal];
        [_leftButton setBackgroundImage:[UIImage imageNamed:@"pub_title_ico_back_white"] forState:UIControlStateHighlighted];
        [_leftButton addTarget:self action:@selector(leftBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}

- (UIButton *)rightButton
{
    if (_rightButton == nil) {
        _rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [_rightButton addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

/**
 *  功能:左按钮点击行为，可在子类重写此方法
 */
- (void)leftBtnClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  功能:右按钮点击行为，可在子类重写此方法
 */
- (void)rightBtnClicked:(id)sender
{
    LOG_SELF_METHOD;
}

@end

@implementation UIViewController (Base)

-(UIViewController<UIViewControllerCommunicationDelegate>*)viewControllerForName:(NSString*)name Class:(Class)Class
{
    UIViewController<UIViewControllerCommunicationDelegate> * controller=(UIViewController<UIViewControllerCommunicationDelegate> *)[[Class alloc]initWithNibName:name bundle:[NSBundle mainBundle]];
    return controller;
}

@end