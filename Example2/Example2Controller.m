//
//  Example2Controller.m
//  DSHBarrageView
//
//  Created by 路 on 2019/1/20.
//  Copyright © 2019年 路. All rights reserved.
//

#import "Example2Controller.h"
#import "DSHBarrageView.h"
#import "DemoBarrageViewCell2.h"

@interface Example2Controller () <DSHBarrageViewDelegate>

@property (strong ,nonatomic) DSHBarrageView *barrageView;
@end

@implementation Example2Controller

#pragma mark - controller
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"模拟应用";
    
    _barrageView = [[DSHBarrageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _barrageView.topPadding = [UIApplication sharedApplication].statusBarFrame.size.height + 44.f + 20.f;
    _barrageView.cellClass = [DemoBarrageViewCell2 class];
    _barrageView.channelHeight = 30.f;
    _barrageView.lineSpacing = 20.f;
    _barrageView.channelCount = 5;
    _barrageView.delegate = self;
    [self.view addSubview:_barrageView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)dealloc {
    [_barrageView destroy];
}

#pragma mark -
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    DSHBarrageMessage *message = [[DSHBarrageMessage alloc] init];
    message.body = [self randomMessage];
    message.speed = 0;
    [_barrageView receivedMessage:message];
}

// 代理
- (void)barrageView:(DSHBarrageView *)barrageView clickedBarrageCell:(DSHBarrageViewCell *)barrageViewCell; {
    NSDictionary *body = barrageViewCell.message.body;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"第%@条弹幕" ,body[@"id"]] message:[NSString stringWithFormat:@"%@:%@" ,body[@"nickname"] ,body[@"content"]] preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"好的" style:0 handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - 模拟数据
- (NSDictionary *)randomMessage {
    static NSInteger index = 0;
    index ++;
    return @{@"color":[self randomColor],
             @"content":[self randomContent],
             @"nickname":[self randomName],
             @"head":[self randomHead],
             @"id":@(index),};
}
- (UIColor *)randomColor {
    return [UIColor colorWithRed:arc4random() % 255 / 255.f
                           green:arc4random() % 255 / 255.f
                            blue:arc4random() % 255 / 255.f
                           alpha:1.f];
}
- (NSString *)randomContent {
    static NSArray *array = nil;
    if (!array) {
        array = @[@"红红火火恍恍惚惚",
                  @"你今天真好看",
                  @"那个xx你真逗，呵呵",
                  @"这波操作可以",
                  @"溜了溜了，拜拜",
                  @"666666666666666666666",
                  @"半醉半醒日复日，花落或开年复年",
                  @"小姐姐我可以点个歌吗",];
    }
    return array[arc4random() % array.count];
}
- (NSString *)randomName {
    static NSArray *array = nil;
    if (!array) {
        array = @[@"醉红尘。",
                  @"抚琴观沧海",
                  @"倚楼听风雨",
                  @"rain",
                  @"春暖花开",];
    }
    return array[arc4random() % array.count];
}

- (NSString *)randomHead {
    static NSArray *array = nil;
    if (!array) {
        array = @[@"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1899397357,205586921&fm=27&gp=0.jpg",
                  @"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2951924714,3607611016&fm=27&gp=0.jpg",
                  @"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3069244644,2570574027&fm=27&gp=0.jpg",
                  @"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2802691956,955693789&fm=27&gp=0.jpg",
                  @"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3336226061,4016676102&fm=27&gp=0.jpg",];
    }
    return array[arc4random() % array.count];
}

@end
