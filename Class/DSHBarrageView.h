//
//  DSHBarrageView.h
//  DSHBarrageView
//
//  Created by 路 on 2019/1/17.
//  Copyright © 2019年 路. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSHBarrageViewCell.h"

@class DSHBarrageView;
@protocol DSHBarrageViewDelegate <NSObject>
@optional
- (void)barrageView:(DSHBarrageView *)barrageView clickedBarrageCell:(DSHBarrageViewCell *)barrageViewCell;
- (void)barrageView:(DSHBarrageView *)barrageView willDisplayBarrageCell:(DSHBarrageViewCell *)barrageViewCell;
@end

@interface DSHBarrageView : UIView

@property (weak ,nonatomic) IBOutlet id <DSHBarrageViewDelegate>delegate;

/// 上边距
@property (assign ,nonatomic) CGFloat topSpacing;

/// 设置最多有多少通道
@property (assign ,nonatomic) NSInteger channelCount;

/// 设置通道高度
@property (assign ,nonatomic) CGFloat channelHeight;

/// 设置自定义弹幕cell类
@property (strong ,nonatomic) Class cellClass;

/// 通道之间的间距
@property (assign ,nonatomic) CGFloat lineSpacing;

/// 同一通道内弹幕之间的间距
@property (assign ,nonatomic) CGFloat interitemSpacing;

/// 收到一条弹幕消息
- (void)receivedMessage:(DSHBarrageMessage *)message;

/// 立即销毁内部定时器
- (void)destroy;
@end
