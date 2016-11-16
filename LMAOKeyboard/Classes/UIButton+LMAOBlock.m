//
//  UIButton+LMAOBlock.m
//  LMAOKeybord
//
//  Created by Seth on 2016/11/11.
//  Copyright © 2016年 Seth. All rights reserved.
//

#import "UIButton+LMAOBlock.h"
#import <objc/runtime.h>

static const NSInteger block_key;
@interface LMAOtarget : NSObject
@property (nonatomic,copy)void (^block)(id sender);
@end

@implementation LMAOtarget

- (instancetype)initWithBlock:(void(^)(id sender))block
{
    if ([super init]) {
        self.block = [block copy];
    }
    return self;
}
- (void)buttonAction:(id)sender
{
    if (self.block) {
        self.block(sender);
    }
}

@end

@implementation UIButton (LMAOBlock)
- (void)addActionBlock:(void (^)(id))block forControlEvents:(UIControlEvents )event
{
    if (!block) {
        return;
    }
    [self addtargetBlock:block forControlEvents:event];
    
}
- (void)addtargetBlock:(void(^)(id))block forControlEvents:(UIControlEvents )event
{
    LMAOtarget *target = [[LMAOtarget alloc] initWithBlock:block];
    NSMutableArray *targets = [self _dj_allBlockTargets];
    [targets addObject:target];
    [self addTarget:target action:@selector(buttonAction:) forControlEvents:event];
}

- (NSMutableArray *)_dj_allBlockTargets
{
    NSMutableArray *targets = objc_getAssociatedObject(self, &block_key);
    if (!targets) {
        targets = [NSMutableArray array];
        objc_setAssociatedObject(self, &block_key, targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return targets;
}
@end
