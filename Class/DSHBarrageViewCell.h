//
//  DSHBarrageViewCell.h
//  DSHBarrageView
//
//  Created by 路 on 2019/1/17.
//  Copyright © 2019年 路. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSHBarrageMessage.h"

@interface DSHBarrageViewCell : UIControl

// 绑定的弹幕消息
@property (strong ,nonatomic ,readonly) DSHBarrageMessage *message;

// 重写生成自定义子视图，需要在这个方法里计算自身宽度并返回
- (CGFloat)setupSubviews;
@end
