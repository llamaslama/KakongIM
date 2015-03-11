//
//  PageHeadView.h
//  moumou
//
//  Created by towne on 10/30/14.
//  Copyright (c) 2014 com.feiniu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface PageHeadView : UIView
{
    UIActivityIndicatorView * indicator;
    UILabel * loadText;
    
    BOOL isLoading;
    
    id _target;
    SEL _beginAction;
    SEL _endAction;
}
@property(nonatomic,strong)UITableView * tableView;
-(void)animmation;

-(BOOL) scrollViewDidEndDecelerating:(UIScrollView *)scrollView;

-(void) loadFinish;

-(void) addBeginLoadAction:(SEL)action;

-(void) addEndLoadAction:(SEL) action;

-(void)setTarget:(id)target;

@end



