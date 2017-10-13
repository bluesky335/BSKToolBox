//
//  NSString+BSKUtils.h
//  BSKToolsBoxDemo
//
//  Created by 刘万林 on 2017/7/15.
//  Copyright © 2017年 BlueSky335. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSKNSStringUtilsConfig : NSObject
+( instancetype _Nonnull)shareConfig;
-(void)setCIBucketName:(nonnull NSString * )bucketName;
@end


@interface NSString (BSKUtils)

/**
 判断字符串是否是NSNULL类或全是空字符

 @return 判断结果布尔值
 */
-(BOOL)bsk_isEmptyString;

/**
 判断字符串是否是以某个字符串开头

 @param str 开头的字符串
 @return 判断结果布尔值
 */
-(BOOL)bsk_isStartWith:(NSString*__nonnull)str;

/**
 判断字符串是否以某个字符串结尾

 @param str 结尾的字符串
 @return 判断结果布尔值
 */
-(BOOL)bsk_isEndWith:(NSString*__nonnull)str;

/**
 为字符串添加删除线，返回一个NSMutableAttributedString
 
 @return 添加了删除线的NSMutableAttributedString
 */
-(NSMutableAttributedString *__nonnull)bsk_addDeleteLine;

/**
 用字符串创建一个NSURL

 @return NSURL
 */
-(NSURL*__nullable)bsk_UrlFromeString;

/**
 替换字符串中的@“http://”为@“https://” 并以此创建一个NSURL
 
 @return NSURL
 */
-(NSURL* __nullable)bsk_HttpsUrlFromeHttpString;


/**
 仅适用于腾讯云万象优图的图片url链接，等比缩放图片到size的大小

 @param size 图片的大小
 @return 处理之后的图片url
 */
-(NSURL*__nonnull)bsk_CIImageHttpsUrlWithSize:(CGSize)size;


/**
 仅适用于腾讯云万象优图的图片url链接，等比缩放图片到指定的大小

 @param width 图片宽度
 @param height 图片高度
 @return 处理之后的图片url
 */
-(NSURL*__nonnull)bsk_CIImageHttpsUrlWithWidth:(CGFloat)width
                                        Height:(CGFloat)height;


@end
