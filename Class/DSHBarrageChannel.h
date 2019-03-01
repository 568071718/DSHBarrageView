//
//  DSHBarrageChannel.h
//  DSHBarrageView
//
//  Created by 路 on 2019/2/28.
//  Copyright © 2019年 路. All rights reserved.
//  弹幕通道 (private)

#import <UIKit/UIKit.h>

@class DSHBarrageViewCell;
@interface DSHBarrageChannel : NSObject

/// 通道标识
@property (assign ,nonatomic ,readonly) NSInteger channelIndex;

/// 通道在 DSHBarrageView 上对应的 y 坐标
@property (assign ,nonatomic ,readonly) CGFloat y;

/// 获取当前通道中所有的弹幕 cell
@property (strong ,nonatomic ,readonly) NSHashTable <DSHBarrageViewCell *>*cells;

/// 记录最后一个添加到该通道的弹幕 cell
@property (weak ,nonatomic) DSHBarrageViewCell *lastCell;
@end
