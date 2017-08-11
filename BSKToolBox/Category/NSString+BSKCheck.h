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
-(BOOL)bsk_isMobilePhoneNumber;
-(BOOL)bsk_isEmailAddress;
-(BOOL)bsk_isIDCardNumber;
-(BOOL)bsk_isNumber;
//-(BOOL)bsk_is;

@end
