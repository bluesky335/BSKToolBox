//
//  NSString+SHA.h
//  BSKToolsBoxDemo
//
//  Created by 刘万林 on 2017/7/15.
//  Copyright © 2017年 BlueSky335. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SHA)
-(NSString *_Nullable)bsk_sha1;
-(NSString *_Nullable)bsk_sha224;
-(NSString *_Nullable)bsk_sha256;
-(NSString *_Nullable)bsk_sha384;
-(NSString *_Nullable)bsk_sha512;
/**
 获取字符串的MD5编码（32位，大写）
 
 @return md5编码
 */
-(NSString * __nonnull)bsk_MD5;
@end
