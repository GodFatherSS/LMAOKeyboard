//
//  LMAOTopPayView.h
//  LMAOKeybord
//
//  Created by Seth on 2016/11/11.
//  Copyright © 2016年 Seth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMAOKeyTextField.h"
@interface LMAOTopPayView : UIView

@property (nonatomic,copy) void(^closeBtnBlock)(id sender);
@property (nonatomic,copy) void(^nextBtnBlock)(id sender);
@property (nonatomic,copy) void(^forgetPswBtnBlock)(id sender);
@property (nonatomic,strong) LMAOKeyTextField *textField; ;
+ (LMAOTopPayView *)payViewWithFrame:(CGRect)frame;

@end
