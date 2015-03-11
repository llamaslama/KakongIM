//
//  PagePhotosDataSource.h
//  moumou
//
//  Created by towne on 10/30/14.
//  Copyright (c) 2014 com.feiniu. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol PagePhotosDataSource<NSObject>

// 有多少页
//
- (int)numberOfPages;

// 每页的图片
//
- (UIView *)imageAtIndex:(int)index;

- (void)endScroll;

-(void)pageChange:(NSUInteger)currentPage;

@end
