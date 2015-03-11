//
//  UITableViewCellDelegate.h
//  moumou
//
//  Created by towne on 10/30/14.
//  Copyright (c) 2014 com.feiniu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UITableViewCellDelegate <NSObject>
@optional
-(void)tableViewCell:(UITableViewCell*)tableViewCell buttonClickAction:(UIButton*)button;

-(void)tableViewCell:(UITableViewCell *)tableViewCell operationType:(const NSString*)type object:(id)object;

@end
