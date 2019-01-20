//
//  DemoBarrageViewCell.m
//  DSHBarrageView
//
//  Created by 路 on 2019/1/17.
//  Copyright © 2019年 路. All rights reserved.
//

#import "DemoBarrageViewCell1.h"

@implementation DemoBarrageViewCell1

- (CGFloat)setupSubviews {
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
    view.layer.cornerRadius = self.frame.size.height * .5;
    view.layer.masksToBounds = YES;
    view.userInteractionEnabled = NO;
    [self addSubview:view];
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    
    label.text = [NSString stringWithFormat:@"第%@条弹幕" ,self.message.body];
    [label sizeToFit];
    
    label.frame = ({
        CGRect frame = label.frame;
        frame.origin.x = 15.f;
        frame.origin.y = 0.f;
        frame.size.height = self.frame.size.height;
        frame.size.width = MAX(frame.size.width, arc4random() % 300 + 44.f);
        frame;
    });
    
    view.frame = ({
        CGRect frame = view.frame;
        frame.origin.x = 0.f;
        frame.origin.y = 0.f;
        frame.size.width = label.frame.size.width + label.frame.origin.x * 2;
        frame.size.height = self.frame.size.height;
        frame;
    });
    
    return CGRectGetMaxX(view.frame);
}

@end
