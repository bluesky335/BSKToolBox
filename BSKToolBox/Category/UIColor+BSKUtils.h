//
//  BSKUtils.h
//  BSKToolsBoxDemo
//
//  Created by 刘万林 on 2017/7/17.
//  Copyright © 2017年 BlueSky335. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor(BSKUtils)
-(BOOL)bsk_isSameColor:(UIColor*_Nullable)color;

/**
 <#Description#>

 @param hex <#hex description#>
 @return <#return value description#>
 */
+(UIColor * _Nonnull)bsk_ColorWithHex:(int32_t)hex;
+(UIColor * _Nonnull)bsk_ColorWithHex:(int32_t)hex alpha:(CGFloat)a;

+(UIColor * _Nonnull)bsk_colorWithRed:(unsigned short)r green:(unsigned short)g blue:(unsigned short)b alpha:(unsigned short)a;
@end
