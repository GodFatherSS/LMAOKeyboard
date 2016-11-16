//
//  LMAOKeyboardDefine.h
//  LMAOKeybord
//
//  Created by Seth on 2016/11/11.
//  Copyright © 2016年 Seth. All rights reserved.
//

#ifndef LMAOKeyboardDefine_h
#define LMAOKeyboardDefine_h

#define LMAOWS(weakSelf)  __weak __typeof(&*self)weakSelf = self; 
#define LMAOSCREENWidth   [UIScreen mainScreen].bounds.size.width
#define LMAOSCREENHeight  [UIScreen mainScreen].bounds.size.height
#define LMAOSCREENBounds  [UIScreen mainScreen].bounds
#define LMAOWindowFirst  [[[UIApplication sharedApplication] windows] firstObject]
#define LMAOTopPayHeight 150
#define LMAOKeyboardHeight  216


#endif /* LMAOKeyboardDefine_h */
