// RDVSecondViewController.m
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

#import "MMLinkmanViewController.h"
#import "RDVTabBarController.h"
#import "OTSTabView.h"
#import "MMTalkViewController.h"

#define kDummyString    @" "

@interface MMLinkmanViewController() <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate,UISearchDisplayDelegate,OTSTabViewDelegate> {
}

@property (nonatomic, strong)     UITableView               *mainTv;
@property (nonatomic, strong)     UISearchDisplayController	*searchController;

@property(nonatomic, strong)      OTSTabView                *headTabView;

@property(nonatomic, strong)      MMTalkViewController      *mmtalkviewcontroller;

@property(nonatomic, strong)      NSMutableArray            *myFriends;
@property(nonatomic, strong)      NSMutableArray            *myCircles;
@end

@implementation MMLinkmanViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"联系人";
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self createViews];
    [self layoutViews];
    
    [self loadfriends];
}

-(void)loadfriends {
    
}

- (NSMutableArray *) myFriends {
    if (_myFriends == nil) {
        _myFriends = [@[@{@"李灵黛":@"LLD"},@{@"汤":@"towne"},@{@"阴露萍":@"YLP"},@{@"柳兰歌":@"LLG"},@{@"李念儿":@"LLR"},@{@"千湄":@"QM"}] mutableCopy];
    }
    return _myFriends;
}

- (NSMutableArray *) myCircles {
    if (_myCircles == nil) {
        _myCircles = [@[] mutableCopy];
    }
    return _myCircles;
}

-(void)createViews {
    
    _mainTv = [UITableView new];
    _mainTv.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44);
    _mainTv.delegate = self;
    _mainTv.dataSource = self;
    _mainTv.backgroundColor = [UIColor clearColor];
    _mainTv.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mainTv.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_mainTv];
    
    __weak MMLinkmanViewController *weakSelf = self;
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
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
    searchBar.placeholder = @"搜索";
    [searchBar sizeToFit];
    searchBar.delegate = self;
    
    _mainTv.tableHeaderView = searchBar;
    
    
    _searchController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    _searchController.delegate = self;
    _searchController.searchResultsDataSource = self;
    _searchController.searchResultsDelegate = self;
    
    self.searchDisplayController.searchBar.tintColor = [UIColor blackColor];
    
    self.mmtalkviewcontroller = [[MMTalkViewController alloc] initWithNibName:nil bundle:nil];
}

#pragma mark - Content Filtering
-(void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller{
    self.searchDisplayController.searchBar.showsCancelButton = YES;
    UIButton *cancelButton;
    UIView *topView = self.searchDisplayController.searchBar.subviews[0];
    for (UIView *subView in topView.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UINavigationButton")]) {
            cancelButton = (UIButton*)subView;
        }
    }
    if (cancelButton) {
        //Set the new title of the cancel button
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    }
}

- (void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller {

}

- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller {

}

- (void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView {

    [self configureTableView:_mainTv];
}

- (void)searchDisplayController:(UISearchDisplayController *)controller willUnloadSearchResultsTableView:(UITableView *)tableView {

}

- (void)searchDisplayController:(UISearchDisplayController *)controller willShowSearchResultsTableView:(UITableView *)tableView {

}

- (void)searchDisplayController:(UISearchDisplayController *)controller didShowSearchResultsTableView:(UITableView *)tableView {

}

- (void)searchDisplayController:(UISearchDisplayController *)controller willHideSearchResultsTableView:(UITableView *)tableView {

}

- (void)searchDisplayController:(UISearchDisplayController *)controller didHideSearchResultsTableView:(UITableView *)tableView {
    
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[cd] %@", searchString];
    
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {

    return YES;
}


- (void)configureTableView:(UITableView *)tableView {
    
    tableView.separatorInset = UIEdgeInsetsZero;
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
    
    UIView *tableFooterViewToGetRidOfBlankRows = [[UIView alloc] initWithFrame:CGRectZero];
    tableFooterViewToGetRidOfBlankRows.backgroundColor = [UIColor clearColor];
    tableView.tableFooterView = tableFooterViewToGetRidOfBlankRows;
}


#pragma mark - OTSTabViewDelegate
- (void)tabView:(OTSTabView *)aTabView changeToIndex:(int)aIndex
{
    if (aIndex == 0) {
        self.myFriends = [@[@{@"李灵黛":@"LLD"},@{@"汤":@"towne"},@{@"阴露萍":@"YLP"},@{@"柳兰歌":@"LLG"},@{@"李念儿":@"LLR"},@{@"千湄":@"QM"}] mutableCopy];
        [_mainTv reloadData];
    } else {
            self.myFriends = [@[@{@"武汉户外－万事达邻里":@"AAA"},@{@"JX35-武汉车友会":@"BBB"},@{@"单身贵族交友":@"CCC"},@{@"摄影成就梦想":@"DDD"},@{@"LOL英雄联盟":@"EEE"},@{@"武汉女人帮":@"FFF"}] mutableCopy];
        [_mainTv reloadData];
    }
}

-(void)layoutViews {
    
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

//header
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *textArray = @[@"好友", @"圈子"];
    UIColor *textColor = [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0];
    NSArray *selImages = @[@"product_left_tab_sel", @"product_right_tab_sel"];
    NSArray *normalImage = @[@"product_left_tab", @"product_right_tab"];
    NSArray *iconImages = @[@"lxr_icon_friends",@"lxr_icon_group"];
    self.headTabView= [[OTSTabView alloc] initWithFrame:CGRectMake(0, 44, 320, 30) texts:textArray color:textColor font:[UIFont systemFontOfSize:16.0] normalImages:normalImage selImages:selImages iconImages:iconImages];
    UIImageView * line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line"]];
    [line setFrame:CGRectMake(0, 30.5, 320, 0.5)];
    [self.headTabView addSubview:line];
    self.headTabView.delegate = self;
    return _headTabView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 82;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSString * cellstr = [NSString stringWithFormat:@"sellbg"];
    UIImageView * celltmp = [[UIImageView alloc] initWithImage:[UIImage imageNamed:cellstr]];
    [cell addSubview:celltmp];
    
    UILabel * _label = [UILabel new];

    [cell addSubview:_label];
    
    _label.text= [self.myFriends[indexPath.row] allKeys][0];
    _label.textColor = UIColorFromRGB(0x666666);
    _label.font = [UIFont systemFontOfSize:13.0];
    _label.backgroundColor=[UIColor clearColor];
    _label.textColor=[UIColor darkGrayColor];
    _label.textAlignment=NSTextAlignmentCenter;
    _label.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    [_label alignTop:@"40" leading:@"70" toView:_label.superview];


    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.myFriends count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [[self rdv_tabBarController] setTabBarHidden:YES];
    _mmtalkviewcontroller.friendName = [self.myFriends[indexPath.row] allKeys][0];
    _mmtalkviewcontroller.friendJid = [self.myFriends[indexPath.row] allValues][0];
    [self.navigationController pushViewController:_mmtalkviewcontroller animated:YES];
}

- (void) viewWillAppear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO];
}

@end
