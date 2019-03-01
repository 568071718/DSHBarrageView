//
//  DSHBarrageChannel.m
//  DSHBarrageView
//
//  Created by 路 on 2019/2/28.
//  Copyright © 2019年 路. All rights reserved.
//

#import "DSHBarrageChannel.h"
#import "DSHBarrageViewCell.h"

@implementation DSHBarrageChannel

- (id)init {
    self = [super init];
    if (self) {
        _cells = [[NSHashTable alloc] initWithOptions:NSPointerFunctionsWeakMemory capacity:10];
    } return self;
}
@end
