//
//  LMAOTopPayView.m
//  LMAOKeybord
//
//  Created by Seth on 2016/11/11.
//  Copyright © 2016年 Seth. All rights reserved.
//

#import "LMAOTopPayView.h"
#import "LMAOKeyboardDefine.h"
#import "UIButton+LMAOBlock.h"
@implementation LMAOTopPayView
{
    UIButton *_closeBtn;
    UILabel *_titleLabel;
    UILabel *_hintLabel;
    UIButton *_nextBtn;
    UIButton *_forgetPswBtn;
}

+ (LMAOTopPayView *)payViewWithFrame:(CGRect)frame;{
    return [[LMAOTopPayView alloc]initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, LMAOSCREENWidth, LMAOTopPayHeight)];
    if (self) {
        [self configUI];
    }
    return self;
}


- (void)configUI{
    // 关闭按钮
    _closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0,60,40)];
//    [_closeBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [_closeBtn setTitle:@"❌" forState:UIControlStateNormal];
    [_closeBtn setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forState:UIControlStateNormal];
    [self addSubview:_closeBtn];
    // 标题
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, LMAOSCREENWidth-160, 40)];
    _titleLabel.text = @"输入支付密码";
    _titleLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.textAlignment=NSTextAlignmentCenter;
    [self addSubview:_titleLabel];
    
    // 下一步按钮
    _nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(LMAOSCREENWidth-80, 0, 60, 40)];
    [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    _nextBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_nextBtn setTitleColor: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forState:UIControlStateNormal];
    [self addSubview:_nextBtn];

    //密码输入框
    _textField=[[LMAOKeyTextField alloc]initWithFrame:CGRectMake(30, 60, LMAOSCREENWidth-60, 40)];
    _textField.userInteractionEnabled=NO;
    [self addSubview:_textField];
    
    // 忘记密码按钮
    _forgetPswBtn = [[UIButton alloc] initWithFrame:CGRectMake(LMAOSCREENWidth-80, 110, 80, 30)];
    [_forgetPswBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
    _forgetPswBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_forgetPswBtn setTitleColor:[UIColor colorWithRed:104/255.0 green:136/255.0 blue:217/255.0 alpha:1.0] forState:UIControlStateNormal];
    [self addSubview:_forgetPswBtn];
    
    // 提示语句
//    _hintLabel = [[UILabel alloc] init];
//    _hintLabel.textColor = [UIColor colorWithRed:255/255.0 green:59/255.0 blue:48/255.0 alpha:1.0];
//    _hintLabel.font = [UIFont systemFontOfSize:14];
//    [self addSubview:_hintLabel];
}

-(void)setCloseBtnBlock:(void (^)(id))closeBtnBlock{
    _closeBtnBlock=[closeBtnBlock copy];
    [_closeBtn addActionBlock:closeBtnBlock forControlEvents:UIControlEventTouchUpInside];
}

-(void)setNextBtnBlock:(void (^)(id))nextBtnBlock{
    _nextBtnBlock=[nextBtnBlock copy];
    [_nextBtn addActionBlock:nextBtnBlock forControlEvents:UIControlEventTouchUpInside];
}

-(void)setForgetPswBtnBlock:(void (^)(id))forgetPswBtnBlock{
    _forgetPswBtnBlock=[forgetPswBtnBlock copy];
    [_forgetPswBtn addActionBlock:_forgetPswBtnBlock forControlEvents:UIControlEventTouchUpInside];
}




@end
