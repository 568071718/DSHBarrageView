//
//  DSHBarrageViewCell.m
//  DSHBarrageView
//
//  Created by 路 on 2019/1/17.
//  Copyright © 2019年 路. All rights reserved.
//

#import "DSHBarrageViewCell.h"

@interface DSHBarrageViewCell ()
@end

@implementation DSHBarrageViewCell

- (id)initWithFrame:(CGRect)frame; {
    self = [super initWithFrame:frame];
    if (self) {
    } return self;
}

// 重写生成自定义子视图，需要在这个方法里计算自身宽度并返回
- (CGFloat)setupSubviews; {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150.f + arc4random() % 200, self.frame.size.height)];
    view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
    view.layer.cornerRadius = view.frame.size.height * .5;
    view.layer.masksToBounds = YES;
    [self addSubview:view];
    UILabel *label = [[UILabel alloc] initWithFrame:view.bounds];
    label.text = @"未设置自定义cell类";
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    return CGRectGetMaxX(view.frame);
}

@end
