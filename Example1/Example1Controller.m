//
//  Example1Controller.m
//  DSHBarrageView
//
//  Created by 路 on 2019/1/20.
//  Copyright © 2019年 路. All rights reserved.
//

#import "Example1Controller.h"
#import "DSHBarrageView.h"
#import "DemoBarrageViewCell1.h"

@interface Example1Controller ()

@property (strong ,nonatomic) DSHBarrageView *barrageView;
@end

@implementation Example1Controller

#pragma mark - controller
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"基础用法";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _barrageView = [[DSHBarrageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _barrageView.topPadding = [UIApplication sharedApplication].statusBarFrame.size.height + 44.f + 20.f;
    _barrageView.cellClass = [DemoBarrageViewCell1 class];
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
    static NSInteger index = 0;
    index ++;
    DSHBarrageMessage *message = [[DSHBarrageMessage alloc] init];
    message.body = @(index);
    [_barrageView receivedMessage:message];
}

@end
