//
//  NSObject+BSKUtils.m
//  BSKToolsBoxDemo
//
//  Created by 刘万林 on 2017/7/17.
//  Copyright © 2017年 BlueSky335. All rights reserved.
//

#import "NSObject+BSKUtils.h"

@implementation NSObject (BSKUtils)
-(BOOL)bsk_isNullObject{
    return [self isKindOfClass:[NSNull class]];
}
@end
