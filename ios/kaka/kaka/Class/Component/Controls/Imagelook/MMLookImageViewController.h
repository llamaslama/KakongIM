//
//  MMLookImageViewController.h
//  moumou
//
//  Created by towne on 10/30/14.
//  Copyright (c) 2014 com.feiniu. All rights reserved.
//

#import "MMBaseViewController.h"
#import "PagePhotosView.h"
@interface MMLookImageViewController : MMBaseViewController<PagePhotosDataSource>
@property(nonatomic,strong)NSArray * smallImages;
@property(nonatomic,strong)NSArray * bigUrls;
@property(nonatomic)NSUInteger currentIndex;
@property(nonatomic,strong,readonly)PagePhotosView * pageView;


@property(nonatomic,strong)id<UIViewControllerOperationDelegate>dismissImage;
@end
