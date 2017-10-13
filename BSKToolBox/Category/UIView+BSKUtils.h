//
//  UIView+BSKUtils.h
//  BSKToolsBoxDemo
//
//  Created by 刘万林 on 2017/7/17.
//  Copyright © 2017年 BlueSky335. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BSKUtils)
-(void)bsk_addShadow;

-(void)bsk_addShadowsmall;

-(void)bsk_addBorderWithColor:(UIColor *)color
                        Width:(CGFloat)width
                 cornerRadius:(CGFloat)radius;
@end
