//
//  NSSet+BSKUtils.h
//  BSKToolsBoxDemo
//
//  Created by 刘万林 on 2017/7/15.
//  Copyright © 2017年 BlueSky335. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSSet (BSKUtils)

/**
 获取集合的所有子集
 @return 子集数组
 */
-(NSArray<NSSet *>* __nonnull )bsk_getAllSubSet;
@end
