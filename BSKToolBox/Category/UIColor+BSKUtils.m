//
//  BSKUtils.m
//  BSKToolsBoxDemo
//
//  Created by 刘万林 on 2017/7/17.
//  Copyright © 2017年 BlueSky335. All rights reserved.
//

#import "UIColor+BSKUtils.h"

@implementation UIColor(BSKUtils)
-(BOOL)bsk_isSameColor:(UIColor*)color{
    if (!color||![color isKindOfClass:[UIColor class]]) {
        return NO;
    }
    return CGColorEqualToColor(self.CGColor, color.CGColor);
}

+(UIColor * _Nonnull)bsk_ColorWithHex:(int32_t)hex
{
    return [UIColor bsk_ColorWithHex:hex alpha:1.0];
}

+(UIColor * _Nonnull)bsk_ColorWithHex:(int32_t)hex alpha:(CGFloat)a{
    return [UIColor colorWithRed:(((hex & 0xFF0000) >> 16))/255.0 green:(((hex &0xFF00) >>8))/255.0 blue:((hex &0xFF))/255.0 alpha:a];
}
+(UIColor * _Nonnull)bsk_colorWithRed:(unsigned short)r green:(unsigned short)g blue:(unsigned short)b alpha:(unsigned short)a{
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a];
}

@end
