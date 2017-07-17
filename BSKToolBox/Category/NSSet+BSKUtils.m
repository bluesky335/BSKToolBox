//
//  NSSet+BSKUtils.m
//  BSKToolsBoxDemo
//
//  Created by 刘万林 on 2017/7/15.
//  Copyright © 2017年 BlueSky335. All rights reserved.
//

#import "NSSet+BSKUtils.h"

@implementation NSSet (BSKUtils)

-(NSArray<NSSet *>*)bsk_getAllSubSet{
    NSMutableArray * setArray = [NSMutableArray array];
    NSArray * object = self.allObjects;
    NSUInteger lenth = self.count;
    Byte bit[self.count];
    for (NSUInteger i = 0; i<lenth; i++) {
        bit[i]=0;
    }
    Byte cancelRepeat = 0;
    while (1) {
        NSMutableSet * subSet = [NSMutableSet set];
        for (NSUInteger i = 0; i<lenth; i++) {
            if (bit[i]) {
                [subSet addObject:object[i]];
            }
        }
        [setArray addObject:subSet];
        if (cancelRepeat) {
            break;
        }
        cancelRepeat = bsk_addBit(bit, lenth);
    }
    
    return setArray;
}

Byte bsk_addBit(Byte bit[],NSUInteger lenth){//模拟二进制加法，一位一位的往上加
    Byte carry = 1;
    NSUInteger index = 0;
    do {
        carry = bit[index];
        bit[index] = !bit[index];
        index++;
        if (index>=lenth) {
            break;
        }
    }while (carry);
    for (NSUInteger i = 0; i<lenth; i++) {
        if (!bit[i]) {
            return 0;
        }
    }
    return 1;
}

@end
