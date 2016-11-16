//
//  LMAOKeyboardView.h
//  LMAOKeybord
//
//  Created by Seth on 2016/11/11.
//  Copyright © 2016年 Seth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMAOTopPayView.h"
#import "LMAOSafeKeyboard.h"

@class LAMOKeyboard;
typedef enum{
    LMAOPayKeyboardViewType = 1,
}LMAOKeyboardViewType;

@protocol LMAOKeyboardDelegate <NSObject>

@optional
- (void)lmao_keyboardDidInput:(LAMOKeyboard *)keyboard;
- (void)lmao_keyboardDidDelete:(LAMOKeyboard *)keyboard;
- (void)lmao_keyboardDidCancel:(LAMOKeyboard *)keyboard;
- (void)lmao_keyboardDidGoNext:(LAMOKeyboard *)keyboard;
- (void)lmao_keyboardDidForgetPassword:(LAMOKeyboard *)keyboard;

@end

@interface LMAOKeyboard : UIView

+ (instancetype)keyboard;
- (void)dismiss;
@property (nonatomic, readonly) NSString *password;
@property (nonatomic, weak) id<LMAOKeyboardDelegate> delegate;

@end
