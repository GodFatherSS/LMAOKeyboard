//
//  LMAOKeyTextField.m
//  LMAOKeybord
//
//  Created by Seth on 2016/11/11.
//  Copyright © 2016年 Seth. All rights reserved.
//

#import "LMAOKeyTextField.h"

@implementation LMAOKeyTextField


- (void)drawRect:(CGRect)rect {
    /** 计算坐标 */
    CGFloat y = 0;
    CGFloat width = rect.size.width / _passWordCount;
    CGFloat height = rect.size.height;
    CGFloat radius = rect.size.height*0.24/2;
    
    /** 创建存储坐标的数组 */
    NSMutableArray <NSValue *>*frameArr = [NSMutableArray array];
    
    /** 开启位图上下文 循环并绘制竖线*/
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (int i = 0; i < _passWordCount; i++) {
        [[UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0]set];
        CGContextAddRect(context, CGRectMake(i * (width), y, width, height));
        [frameArr addObject:[NSValue valueWithCGRect:CGRectMake(i * (width)+width/2-radius, y+height/2-radius, 2*radius, 2*radius)]];
    }
    CGContextStrokePath(context);
    
    /** 监听文字变化 */
    [self addTarget:self action:@selector(passWordDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    /** 监听文字个数变化,并且循环并绘制实心圆 */
    if (self.text.length) {
        for (int i = 0; i < self.text.length; i++) {
            [[UIColor blackColor]set];
            CGContextFillEllipseInRect(context, [frameArr[i] CGRectValue]);
            
        }
    }else{
        return;
    }
    
}
/** 监听文字的变化 */
- (void)passWordDidChange:(UITextField *)sender{
    if (sender.text.length > _passWordCount) {
        NSRange range = NSMakeRange(0, _passWordCount);
        sender.text = [sender.text substringWithRange:range];
    }
    [self setNeedsDisplay];
}
#pragma mark - 重写的方法
/** 重写 setPlaceholder 方法 防止出现 placeHolder*/
-(void)setPlaceholder:(NSString *)placeholder{
    
}

/** 重写 initWithFrame 方法 防止出现光标*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tintColor = [UIColor clearColor];
        self.textColor = [UIColor clearColor];
        self.keyboardType = UIKeyboardTypeNumberPad;
        _passWordCount = 6;
    }
    return self;
}
/** 重写文字颜色方法 让文字永远是透明色 */
-(void)setTextColor:(UIColor *)textColor{
    textColor = [UIColor clearColor];
    [super setTextColor:textColor];
}

/** 重写光标的颜色方法  让光标永远是透明色 */
-(void)setTintColor:(UIColor *)tintColor{
    tintColor = [UIColor clearColor];
    [super setTintColor:tintColor];
}
/** 禁用复制粘贴的功能 */
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    return NO;
}

/** 重写键盘类型 */
-(void)setKeyboardType:(UIKeyboardType)keyboardType{
    keyboardType = UIKeyboardTypeNumberPad;
    [super setKeyboardType:keyboardType];
}



@end
