//
//  UIButton+LMAOBlock.h
//  LMAOKeybord
//
//  Created by Seth on 2016/11/11.
//  Copyright © 2016年 Seth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (LMAOBlock)
- (void)addActionBlock:(void(^)(id sender))block forControlEvents:(UIControlEvents )event;
@end
