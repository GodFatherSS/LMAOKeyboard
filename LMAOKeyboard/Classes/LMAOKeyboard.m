//
//  LMAOKeyboardView.m
//  LMAOKeybord
//
//  Created by Seth on 2016/11/11.
//  Copyright © 2016年 Seth. All rights reserved.
//

#import "LMAOKeyboard.h"
#import "LMAOKeyboardDefine.h"

static UIView *bGView=nil;
static LMAOKeyboard* contentView=nil;
static CGFloat keyboardViewHeight=0;

@interface LMAOKeyboard ()
@property (nonatomic,assign) LMAOKeyboardViewType type;
@end

@implementation LMAOKeyboard
{
    UIView *_bgView;
}

+ (instancetype)keyboard {
    bGView=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    bGView.backgroundColor=[UIColor blackColor];
    bGView.alpha=0.4;
    [LMAOWindowFirst addSubview:bGView];
    contentView=[[LMAOKeyboard alloc]initWithType:1];
    [LMAOWindowFirst addSubview:contentView];
    [LMAOKeyboard show];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:contentView action:@selector(cancel)];
    [bGView addGestureRecognizer:tap];
    return contentView;
}

+(void)show
{
    [UIView animateWithDuration:0.3 animations:^{
        contentView.frame = CGRectMake(0, LMAOSCREENHeight-keyboardViewHeight, LMAOSCREENWidth, keyboardViewHeight);
//        if (contentView.type==LMAOPayKeyboardViewType) {
//            [contentView.topView.textField becomeFirstResponder];
//        }
    } completion:^(BOOL finished) {
        
    }];
}

+(void)hide
{
    [UIView animateWithDuration:0.3 animations:^{
        bGView.alpha = 0;
        contentView.frame = CGRectMake(0, LMAOSCREENHeight, LMAOSCREENWidth, keyboardViewHeight);
    } completion:^(BOOL finished) {
        [bGView removeFromSuperview];
        [contentView removeFromSuperview];
        bGView=nil;
        contentView=nil;
    }];
}


- (id)initWithType:(LMAOKeyboardViewType)type
{
    self = [super init];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        _type=type;
        [self configView];
    }
    return self;
}

- (void)configView{
    if (_type==LMAOPayKeyboardViewType) {
        [self configPayKeyboardView];
    }
}

- (void)configPayKeyboardView{
    keyboardViewHeight=LMAOTopPayHeight+LMAOKeyboardHeight;
    self.frame=CGRectMake(0, LMAOSCREENHeight, LMAOSCREENWidth, keyboardViewHeight);
    LMAOTopPayView *topView=[LMAOTopPayView payViewWithFrame:CGRectMake(0, 0, 0, 0)];
    LMAOWS(ws);
    topView.closeBtnBlock=^(id sender){
        [ws cancel];
    };
    topView.nextBtnBlock=^(id sender){
        [ws next];
    };
    topView.forgetPswBtnBlock=^(id sender){
        [ws forgetPs];
    };
    
    [self addSubview:topView];
    LMAOSafeKeyboard *keyBoard=[LMAOSafeKeyboard keyboardWithOriginY:LMAOTopPayHeight withType:LMAOTypeNumberPad];
    [self addSubview:keyBoard];
    
    keyBoard.inputSource=topView.textField;
}

- (void)dismiss {
    [LMAOKeyboard hide];
}

- (void)cancel{
    if ([_delegate respondsToSelector:@selector(lamo_keyboardDidCancel:)]) {
        [_delegate lmao_keyboardDidCancel:self];
    }
    [self dismiss];
}

- (void)next{
    if ([_delegate respondsToSelector:@selector(lamo_keyboardDidGoNext:)]) {
        [_delegate lmao_keyboardDidGoNext:self];
    }
    [self dismiss];
}

- (void)forgetPs{
    if ([_delegate respondsToSelector:@selector(lamo_keyboardDidForgetPassword:)]) {
        [_delegate lmao_keyboardDidForgetPassword:self];
    }
    [self dismiss];
}

- (void)dealloc {
    bGView = nil;
    contentView = nil;
}



@end
