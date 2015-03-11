// RDVFirstViewController.m
// RDVTabBarController
//
// Copyright (c) 2013 Robert Dimitrov
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "MMMessageController.h"
#import "RDVTabBarController.h"
#import "RDVTabBarItem.h"

@interface MMMessageController() <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate,UISearchDisplayDelegate> {
}

@property (nonatomic, strong)     UITableView               *mainTv;
@end

@implementation MMMessageController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"tangqi";
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [[self rdv_tabBarItem] setBadgeValue:@"3"];
    
    _mainTv = [UITableView new];
    _mainTv.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44);
    _mainTv.delegate = self;
    _mainTv.dataSource = self;
    _mainTv.backgroundColor = [UIColor clearColor];
    _mainTv.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mainTv.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_mainTv];
    
    __weak MMMessageController *weakSelf = self;
    [_mainTv addPullToRefreshWithActionHandler:^{
        double delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            //                [weakSelf sendRequest];
            [weakSelf.mainTv.pullToRefreshView stopAnimating];
        });
    }];
    [_mainTv.pullToRefreshView setTitle:@"正在加载..." forState:SVPullToRefreshStateLoading];
    [_mainTv.pullToRefreshView setTitle:@"下拉刷新数据" forState:SVPullToRefreshStateStopped];
    [_mainTv.pullToRefreshView setTitle:@"释放开始加载" forState:SVPullToRefreshStateTriggered];
    
    [_mainTv addInfiniteScrollingWithActionHandler:^{
        //
        double delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [weakSelf.mainTv.infiniteScrollingView stopAnimating];
        });
    }];
    
    if (self.rdv_tabBarController.tabBar.translucent) {
        UIEdgeInsets insets = UIEdgeInsetsMake(0,
                                               0,
                                               CGRectGetHeight(self.rdv_tabBarController.tabBar.frame),
                                               0);
        _mainTv.contentInset = insets;
        _mainTv.scrollIndicatorInsets = insets;
    }
}

- (NSUInteger)supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return UIInterfaceOrientationMaskAll;
    } else {
        return UIInterfaceOrientationMaskPortrait;
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return YES;
    }
    return toInterfaceOrientation == UIInterfaceOrientationPortrait;
}

#pragma mark - Methods

- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    [[cell textLabel] setText:[NSString stringWithFormat:@"%@ Controller Cell %ld", self.title, (long)indexPath.row]];
}

#pragma mark - Table view

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
//    [self configureCell:cell forIndexPath:indexPath];
    NSString * cellstr = [NSString stringWithFormat:@"mess0%d",indexPath.row];
    UIImageView * celltmp = [[UIImageView alloc] initWithImage:[UIImage imageNamed:cellstr]];
    [cell addSubview:celltmp];
    
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    [[self rdv_tabBarItem] setBadgeValue:[NSString stringWithFormat:@"%ld", indexPath.row+1]];
}

@end
