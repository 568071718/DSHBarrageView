//
//  DSHBarrageMessage.h
//  DSHBarrageView
//
//  Created by 路 on 2019/1/18.
//  Copyright © 2019年 路. All rights reserved.
//  弹幕消息配置

#import <UIKit/UIKit.h>

@interface DSHBarrageMessage : NSObject

- (id)init;

/// 设置弹幕滚动速度,当设置0或者小于0时为随机速度(0.5 - 1.5)
@property (assign ,nonatomic) CGFloat speed;

/// 记录弹幕数据
@property (strong ,nonatomic) id body;
@end
