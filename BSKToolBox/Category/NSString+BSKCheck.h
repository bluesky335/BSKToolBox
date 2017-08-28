//
//  NSString+BSKCheck.h
//  BSKToolsBoxDemo
//
//  Created by 刘万林 on 2017/8/7.
//  Copyright © 2017年 BlueSky335. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (BSKCheck)

-(BOOL)bsk_matchesWithRegex:(NSString * )regex;
-(BOOL)bsk_isEmailAddress;
-(BOOL)bsk_isIDCardNumber;
-(BOOL)bsk_isNumber;

/**
 是否是手机号

 @return YES or NO
 */
-(BOOL)bsk_isMobilePhoneNumber;

/**
 是否是电话号（包括固定电话和手机）
 
 @return YES or NO
 */
-(BOOL)bsk_isPhoneNumber;

/**
 是否是固定电话号码（仅支持中国）
 
 @return YES or NO
 */
-(BOOL)bsk_isTelephoneNumber;


@end
