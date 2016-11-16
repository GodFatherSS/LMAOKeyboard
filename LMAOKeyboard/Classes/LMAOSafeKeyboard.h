//
//  LMAOSafeKeyboard.h
//  LMAOKeybord
//
//  Created by Seth on 2016/11/11.
//  Copyright © 2016年 Seth. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    LMAOTypeNumberPad = 1,
    LMAOTypeDecimalPad ,
    LMAOTypeASCIICapable
}LMAOType;

@interface LMAOSafeKeyboard : UIView
@property (nonatomic, strong) UIView *inputSource;
+ (LMAOSafeKeyboard *)keyboardWithOriginY:(CGFloat)y withType:(LMAOType)type;

@end
