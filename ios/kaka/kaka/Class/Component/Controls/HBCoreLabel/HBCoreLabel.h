//
//  HBCoreLabel.h
//  moumou
//
//  Created by towne on 10/30/14.
//  Copyright (c) 2014 com.feiniu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MatchParser.h"
@class HBCoreLabel;
@protocol HBCoreLabelDelegate <NSObject>
@optional
-(void)coreLabel:(HBCoreLabel*)coreLabel linkClick:(NSString*)linkStr;
-(void)coreLabel:(HBCoreLabel *)coreLabel phoneClick:(NSString *)linkStr;
-(void)coreLabel:(HBCoreLabel *)coreLabel mobieClick:(NSString *)linkStr;

@end

@interface HBCoreLabel : UILabel<UIActionSheetDelegate>
{
    MatchParser* _match;
    
    BOOL touch;
    
    id<MatchParserDelegate> _data;
    
    NSString * _linkStr;
    
    NSString * _linkType;
    
    BOOL _copyEnableAlready;
    
    BOOL _attributed;
}
@property(nonatomic,strong ) MatchParser * match;
@property(nonatomic,strong) IBOutlet id<HBCoreLabelDelegate> delegate;
@property(nonatomic) BOOL linesLimit;
-(void)registerCopyAction;
@end
