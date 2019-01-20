//
//  DemoBarrageViewCell2.m
//  DSHBarrageView
//
//  Created by 路 on 2019/1/20.
//  Copyright © 2019年 路. All rights reserved.
//

#import "DemoBarrageViewCell2.h"

@implementation DemoBarrageViewCell2

- (CGFloat)setupSubviews {
    
    NSDictionary *body = self.message.body;
    
    UIImageView *head = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    head.layer.cornerRadius = 30 * .5;
    head.clipsToBounds = YES;
    head.contentMode = UIViewContentModeScaleAspectFill;
    [self setImageWithImagePath:body[@"head"] forImageView:head];
    [self addSubview:head];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.textColor = body[@"color"];
    label1.font = [UIFont systemFontOfSize:10];
    label1.text = [NSString stringWithFormat:@"%@：" ,body[@"nickname"]];
    [self addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.textColor = body[@"color"];
    label2.font = [UIFont systemFontOfSize:12];
    label2.text = body[@"content"];
    [self addSubview:label2];
    
    // 计算宽度
    [label1 sizeToFit];
    [label2 sizeToFit];
    
    label1.frame = ({
        CGRect frame = label1.frame;
        frame.origin.x = CGRectGetMaxX(head.frame) + 5.f;
        frame.origin.y = 0.f;
        frame;
    });
    label2.frame = ({
        CGRect frame = label2.frame;
        frame.origin.x = label1.frame.origin.x;
        frame.origin.y = self.frame.size.height - frame.size.height;
        frame;
    });
    return MAX(CGRectGetMaxX(label1.frame), CGRectGetMaxX(label2.frame));
}

- (void)setImageWithImagePath:(NSString *)urlString forImageView:(UIImageView *)imageView; {
    NSURLSession *session = [NSURLSession sharedSession];
    [[session downloadTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            UIImage *image = [UIImage imageWithContentsOfFile:location.path];
            dispatch_async(dispatch_get_main_queue(), ^{
                imageView.image = image;
            });
        }
    }] resume];
}

@end
