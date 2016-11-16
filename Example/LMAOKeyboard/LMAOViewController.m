//
//  LMAOViewController.m
//  LMAOKeyboard
//
//  Created by Seth on 11/16/2016.
//  Copyright (c) 2016 Seth. All rights reserved.
//

#import "LMAOViewController.h"
#import "LMAOKeyboard.h"
@interface LMAOViewController ()<LMAOKeyboardDelegate>
{
    LMAOKeyboard *_keyboard;
}
@end

@implementation LMAOViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _keyboard = [LMAOKeyboard keyboard];
    _keyboard.delegate = self;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _keyboard = nil;
}

#pragma mark - LMAOKeyboardDelegate
- (void)lmao_keyboardDidCancel:(LMAOKeyboard *)keyboard {
    NSLog(@"取消！");
}

- (void)lmao_keyboardDidGoNext:(LMAOKeyboard *)keyboard {
    NSLog(@"下一步！");
}

- (void)lmao_keyboardDidForgetPassword:(LMAOKeyboard *)keyboard {
    NSLog(@"忘记密码！");
}

- (void)lmao_keyboardDidInput:(LMAOKeyboard *)keyboard {
    NSLog(@"密码为：%@", keyboard.password);
}

- (void)lmao_keyboardDidDelete:(LMAOKeyboard *)keyboard {
    NSLog(@"删除后：%@", keyboard.password);
}

@end
