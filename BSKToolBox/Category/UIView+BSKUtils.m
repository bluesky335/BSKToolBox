//
//  UIView+BSKUtils.m
//  BSKToolsBoxDemo
//
//  Created by 刘万林 on 2017/7/17.
//  Copyright © 2017年 BlueSky335. All rights reserved.
//

#import "UIView+BSKUtils.h"

@implementation UIView (BSKUtils)
-(void)bsk_addShadow{
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(3, 3);
    self.layer.shadowRadius = 5;
    self.layer.shadowOpacity = 0.3;
}
-(void)bsk_addShadowsmall{
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowRadius = 0.5;
    self.layer.shadowOpacity = 1;
}

-(void)bsk_addBorderWithColor:(UIColor *)color Width:(CGFloat)width cornerRadius:(CGFloat)radius{
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
    self.layer.cornerRadius = radius;
}

@end
