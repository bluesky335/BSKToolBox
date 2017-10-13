//
//  BSKSwitch.h
//  BSKToolsBoxDemo
//
//  Created by 刘万林 on 2017/8/31.
//  Copyright © 2017年 BlueSky335. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface BSKSwitch : UIControl

@property (copy, nonatomic  ) IBInspectable NSString * buttonText;//圆形按钮上的文字（空间有限、建议只设置一个字）
@property (copy, nonatomic  ) IBInspectable NSString * onText;//开启状态的文字
@property (copy, nonatomic  ) IBInspectable NSString * offText;//关闭状态的文字

@property (strong, nonatomic) IBInspectable UIColor  * onColor;//开启状态的背景颜色
@property (strong, nonatomic) IBInspectable UIColor  * offColor;//关闭状态的背景颜色

@property (strong, nonatomic) IBInspectable UIColor  * onTextColor;//开启状态的文字颜色
@property (strong, nonatomic) IBInspectable UIColor  * offTextColor;//关闭状态的文字颜色

@property (strong, nonatomic) IBInspectable UIColor  * offBorderColor;//关闭状态的边框颜色

@property (strong, nonatomic) IBInspectable UIColor  * onButtonColor;//开启状态的圆形按钮背景颜色
@property (strong, nonatomic) IBInspectable UIColor  * offButtonColor;//关闭状态的圆形按钮背景颜色

@property (strong, nonatomic) IBInspectable UIColor  * onButtonTextColor;//开启状态的圆形按钮文字颜色
@property (strong, nonatomic) IBInspectable UIColor  * offButtonTextColor;//关闭状态的圆形按钮文字颜色

@property (assign, nonatomic) IBInspectable CGFloat  CornerRadius;//按钮的圆角
@property (assign, nonatomic,getter = isOn) IBInspectable BOOL on;//开启还是关闭
@end

