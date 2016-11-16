//
//  LMAOSafeKeyboard.m
//  LMAOKeybord
//
//  Created by Seth on 2016/11/11.
//  Copyright © 2016年 Seth. All rights reserved.
//

#import "LMAOSafeKeyboard.h"
#import "LMAOKeyboard.h"
#import "LMAOKeyboardDefine.h"
#import "LMAOKeyTextField.h"

@implementation LMAOSafeKeyboard
{
    LMAOType _type;
}

+ (LMAOSafeKeyboard *)keyboardWithOriginY:(CGFloat)y withType:(LMAOType)type{
    return [[LMAOSafeKeyboard alloc] initWithFrame:CGRectMake(0,y, LMAOSCREENWidth, LMAOKeyboardHeight) withType:type];
}

- (instancetype)initWithFrame:(CGRect)frame withType:(LMAOType)type
{
    self = [super initWithFrame:frame];
    if (self) {
        _type=type;
        [self configView];
    }
    return self;
}


- (void)configView{
    if (_type==LMAOTypeNumberPad) {
        [self configNumberPad];
    }
}

#pragma mark -- 数字键盘 --
- (void)configNumberPad{
        NSInteger cols = 3;
        NSInteger rows = 4;
        UIColor *lineColor = [UIColor colorWithRed:200/255.0 green:202/255.0 blue:206/255.0 alpha:1.0];
        UIColor *titleColor = [UIColor blackColor];
        UIColor *touchColor = [UIColor grayColor];
        UIFont *titleFont = [UIFont systemFontOfSize:26];
        CGFloat itemH = LMAOKeyboardHeight/rows;
        CGFloat itemW = LMAOSCREENWidth/cols;
        for (NSInteger i = 0; i < cols*rows; i++) {
                CGRect bounds = CGRectMake(i%cols*itemW, i/cols*itemH, itemW, itemH);
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.layer.borderWidth = 0.25;
                btn.layer.borderColor = lineColor.CGColor;
                btn.frame = bounds;
                btn.titleLabel.font = titleFont;
                btn.titleLabel.textColor = titleColor;
                [btn setTitleColor:titleColor forState:UIControlStateNormal];
                [btn setTitleColor:touchColor forState:UIControlStateHighlighted];
                SEL selector;
                if (i == (rows*cols-2-1)) {
                    selector =@selector(doneAction:);
                }else if (i== (rows*cols-1)){
                    selector = @selector(deleteAction:);
                }else{
                    selector = @selector(numberAction:);
                }
                NSInteger tag = i;
                [btn setTag:tag];
                [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:btn];
            
        }
        [self loadRandomNumber];
    
}


- (void)loadRandomNumber {
    NSArray *titles = [self generateRandomNumber];
    NSArray *subviews = self.subviews;
    [subviews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *tmp = (UIButton *)obj;
            NSInteger __tag = tmp.tag;
            NSString *title ;
            if (__tag == 9) {
                title = @"";
            }else if (__tag == 10) {
                title = [titles lastObject];
            }else if (__tag == 11){
                title = @"✗";
            }else {
                title = [titles objectAtIndex:__tag];
            }
            [tmp setTitle:title forState:UIControlStateNormal];
        }
    }];
}

- (NSArray *)generateRandomNumber {
    NSMutableArray *dataArray=[NSMutableArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",nil];
    NSMutableArray *resultArray=[NSMutableArray new];
    for (NSInteger i=0; i<10; i++) {
        NSInteger num=arc4random()%dataArray.count;
        [resultArray addObject:dataArray[num]];
        [dataArray removeObjectAtIndex:num];
    }
    return [resultArray copy];
}


#pragma mark -- 数字键盘 Action --
- (void)doneAction:(UIButton *)btn {
    NSLog(@"%@",[(LMAOKeyTextField *)self.inputSource text]);
}

- (void)deleteAction:(UIButton *)btn {
    LMAOKeyboard *keyboard = self.superview;
    
    if (self.inputSource) {
        if ([self.inputSource isKindOfClass:[LMAOKeyTextField class]]) {
            LMAOKeyTextField *tmp = (LMAOKeyTextField *)self.inputSource;
            if (tmp.text.length>1) {
                tmp.text = [tmp.text substringToIndex:tmp.text.length-1];
                [tmp setNeedsDisplay];
                
                [keyboard setValue:tmp.text forKey:@"password"];
            } else {
                [keyboard setValue:nil forKey:@"password"];
            }
        }
    }
    
    if ([keyboard.delegate respondsToSelector:@selector(lmao_keyboardDidDelete:)]) {
        [keyboard.delegate lmao_keyboardDidDelete:keyboard];
    }
    
}

- (void)numberAction:(UIButton *)btn {
    LMAOKeyboard *keyboard = self.superview;

    if (self.inputSource) {
        if ([self.inputSource isKindOfClass:[LMAOKeyTextField class]]) {
            LMAOKeyTextField *tmp = (LMAOKeyTextField *)self.inputSource;
            NSString *title = [btn titleLabel].text;
            if (tmp.text.length < tmp.passWordCount) {
                tmp.text=[NSString stringWithFormat:@"%@%@",tmp.text,title];
                [tmp setNeedsDisplay];
                [keyboard setValue:tmp.text forKey:@"password"];
            }
        }
    }
    
    if ([keyboard.delegate respondsToSelector:@selector(lmao_keyboardDidInput:)]) {
        [keyboard.delegate lmao_keyboardDidInput:keyboard];
    }
    
}


@end
