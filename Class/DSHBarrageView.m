//
//  DSHBarrageView.m
//  DSHBarrageView
//
//  Created by 路 on 2019/1/17.
//  Copyright © 2019年 路. All rights reserved.
//

#import "DSHBarrageView.h"
#import "DSHBarrageChannel.h"

@interface DSHBarrageView ()

@property (strong ,nonatomic) CADisplayLink *timer;
@property (strong ,nonatomic) NSArray <DSHBarrageChannel *>*channels; // 当前所有通道
@property (strong ,nonatomic) NSMutableArray <DSHBarrageMessage *>*barrageMessages; // 队列内的消息
@end

@implementation DSHBarrageView

- (id)init {
    self = [super init];
    if (self) {
        [self setup];
    } return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    } return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (void)setup {
    self.backgroundColor = nil;
    self.clipsToBounds = YES;
    _topSpacing = [UIApplication sharedApplication].statusBarFrame.size.height + 20.f;
    _channelCount = 4;
    _channelHeight = 44.f;
    _interitemSpacing = 5.f;
    _lineSpacing = 5.f;
    _cellClass = [DSHBarrageViewCell class];
    _barrageMessages = [NSMutableArray array];
    [self reloadConfig];
}

// 收到一条弹幕消息
- (void)receivedMessage:(DSHBarrageMessage *)message; {
    NSInteger idleIndex = [self idleIndex];
    if (idleIndex == -1) {
        [_barrageMessages addObject:message];
    } else {
        [self showBarrageCellWithBarrageMessage:message idleIndex:idleIndex];
    }
}

- (void)showBarrageCellWithBarrageMessage:(DSHBarrageMessage *)barrageMessage idleIndex:(NSInteger)idleIndex {
    if (!_cellClass) {
        _cellClass = [DSHBarrageViewCell class];
    }
    DSHBarrageChannel *channel = _channels[idleIndex]; // 获取通道
    DSHBarrageViewCell *cell = [[_cellClass alloc] initWithFrame:CGRectMake(0, 0, 0, _channelHeight)];
    [cell setValue:barrageMessage forKey:@"message"];
    [cell addTarget:self action:@selector(clickActions:) forControlEvents:UIControlEventTouchUpInside];
    cell.frame = ({
        CGRect frame = cell.frame;
        frame.size.width = [cell setupSubviews];
        frame.origin.x = self.frame.size.width;
        frame.origin.y = channel.y;
        frame.size.height = _channelHeight;
        frame;
    });
    if ([_delegate respondsToSelector:@selector(barrageView:willDisplayBarrageCell:)]) {
        [_delegate barrageView:self willDisplayBarrageCell:cell];
    }
    [self addSubview:cell];
    [channel.cells addObject:cell];
    channel.lastCell = cell;
    if (!_timer) {
        _timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
        [_timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
}

// 返回一个可用的通道，没有可用通道返回 -1
- (NSInteger)idleIndex {
    for (DSHBarrageChannel *channel in _channels) {
        if (!channel.lastCell) {
            return channel.channelIndex;
        }
        if (CGRectGetMaxX(channel.lastCell.frame) < self.frame.size.width - _interitemSpacing) {
            return channel.channelIndex;
        }
    }
    return -1;
}

- (void)update {
    NSInteger cellCount = 0;
    for (DSHBarrageViewCell *cell in self.subviews) {
        if ([cell isKindOfClass:[DSHBarrageViewCell class]]) {
            CGRect frame = cell.frame;
            if (cell.message.speed <= 0) {
                cell.message.speed = arc4random() % 10 / 10.f + 0.5;
            }
            frame.origin.x -= 1.f * cell.message.speed;
            cell.frame = frame;
            if (CGRectGetMaxX(frame) <= 0) {
                [cell removeFromSuperview];
            } else {
                cellCount ++;
            }
        }
    }
    DSHBarrageMessage *message = _barrageMessages.firstObject;
    if (message) {
        NSInteger idleIndex = [self idleIndex];
        if (idleIndex >= 0) {
            [_barrageMessages removeObject:message];
            [self showBarrageCellWithBarrageMessage:message idleIndex:idleIndex];
            cellCount ++;
        }
    }
    if (cellCount <= 0) {
        [self destroy]; // 检测到没有弹幕时自动销毁定时器
    }
}

// 立即销毁内部定时器
- (void)destroy; {
    [_timer invalidate];
    _timer = nil;
}

#pragma mark - action
- (void)clickActions:(DSHBarrageViewCell *)sender {
    if ([_delegate respondsToSelector:@selector(barrageView:clickedBarrageCell:)]) {
        [_delegate barrageView:self clickedBarrageCell:sender];
    }
}

#pragma mark -
- (void)reloadConfig {
    CGFloat y = _topSpacing;
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:_channelCount];
    for (int i = 0; i < _channelCount; i ++) {
        DSHBarrageChannel *channel = [[DSHBarrageChannel alloc] init];
        [channel setValue:@(i) forKey:@"channelIndex"];
        [channel setValue:@(y) forKey:@"y"];
        array[i] = channel;
        y = y + _channelHeight + _lineSpacing;
    }
    _channels = [array copy];
}

- (void)setTopSpacing:(CGFloat)topSpacing {
    _topSpacing = topSpacing;
    [self reloadConfig];
}

- (void)setChannelCount:(NSInteger)channelCount {
    _channelCount = channelCount;
    [self reloadConfig];
}

- (void)setChannelHeight:(CGFloat)channelHeight {
    _channelHeight = channelHeight;
    [self reloadConfig];
}

- (void)setLineSpacing:(CGFloat)lineSpacing {
    _lineSpacing = lineSpacing;
    [self reloadConfig];
}

#pragma mark -
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (view == self) {
        return nil;
    }
    return view;
}

- (void)dealloc {
#if DEBUG
    NSLog(@"%s" ,__func__);
#endif
}

@end
