//
//  BrowseViewController.h
//  moumou
//
//  Created by towne on 10/30/14.
//  Copyright (c) 2014 com.feiniu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMBaseViewController.h"
@interface BrowseViewController : MMBaseViewController <UIWebViewDelegate>
{
    IBOutlet UIWebView * _webView;
    IBOutlet UIToolbar * _toolBar;
    IBOutlet UIBarButtonItem * _back;
    IBOutlet UIBarButtonItem * _forword;
    IBOutlet UIBarButtonItem * _refresh;
}
@property(nonatomic,strong) NSString * url;
@property (nonatomic, strong) NSURL *fileUrl;
@property (nonatomic, strong) NSString *labelTitle;
@end
