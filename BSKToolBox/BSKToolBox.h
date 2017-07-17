//
//  BSKToolBox.h
//  BSKToolsBoxDemo
//
//  Created by 刘万林 on 2017/7/15.
//  Copyright © 2017年 BlueSky335. All rights reserved.
//


//自定义的Log方法，用法同NSLog；
#define BSKLog(FORMAT, ...) fprintf(stderr,"BSK:【%s : %d】\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

#define UIColorFromeRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

/**
 Bool转字符串

 @param b bool
 @return @"YES"或@"NO"
 */
#define BSKBoolStr(b) b?@"YES":@"NO"

#define APPRootVC [UIApplication sharedApplication].keyWindow.rootViewController

#import "BSKConstant.h"
#import "NSString+BSKUtils.h"
#import "UIViewController+BSKToast.h"
#import "NSString+SHA.h"
#import "NSSet+BSKUtils.h"
#import "UIColor+BSKUtils.h"
#import "UIView+BSKUtils.h"
#import "NSObject+BSKUtils.h"
#import "BSKUtils.h"
