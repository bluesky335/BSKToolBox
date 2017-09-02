//
//  BSKSwitch.h
//  BSKToolsBoxDemo
//
//  Created by 刘万林 on 2017/8/31.
//  Copyright © 2017年 BlueSky335. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface BSKSwitch : UIView

@property (copy, nonatomic) IBInspectable NSString * buttonText;
@property (copy, nonatomic) IBInspectable NSString * onText;
@property (copy, nonatomic) IBInspectable NSString * offText;

@property (strong, nonatomic) IBInspectable UIColor * onColor;
@property (strong, nonatomic) IBInspectable UIColor * offColor;

@property (strong, nonatomic) IBInspectable UIColor * onTextColor;
@property (strong, nonatomic) IBInspectable UIColor * offTextColor;

@property (strong, nonatomic) IBInspectable UIColor * offBorderColor;

@property (strong, nonatomic) IBInspectable UIColor * onButtonColor;
@property (strong, nonatomic) IBInspectable UIColor * offButtonColor;

@property (strong, nonatomic) IBInspectable UIColor * onButtonTextColor;
@property (strong, nonatomic) IBInspectable UIColor * offButtonTextColor;

@property (assign, nonatomic) IBInspectable CGFloat CornerRadius;
@property (assign, nonatomic,getter=isOn) IBInspectable BOOL on;
@end
