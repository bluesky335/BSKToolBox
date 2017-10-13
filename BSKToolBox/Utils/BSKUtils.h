//
//  BSKUtils.h
//  LoveStillArtHouse
//
//  Created by 刘万林 on 13/05/2017.
//  Copyright © 2017 Me. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^sureAction)(id _Nullable action);
typedef void(^cancelAction)(id _Nullable action);

@interface BSKUtils : NSObject
@end


#pragma mark - ● 导航
/**
 调起已安装的导航软件，从当前位置到目的地，
 请在使用这些方法之前将起点位置的经纬度用：[[NSUserDefaults standardUserDefaults]setDouble:0.0 forKey:@""] 方法
 把经纬度用”Location:latitude“和“Location:longitude”两个key分别保存。
 */
@interface BSKUtils(Navigation)
#pragma mark 用已安装的导航应用导航
/**
 从当前位置启用导航软件导航到目的地，支持手机自带地图，高德地图，百度地图，腾讯地图，只会显示已安装的地图
需要在info.plist 的 LSApplicationQueriesSchemes 添加 baidumap,iosamap,qqmap 。
 
 @param name 目的地名称
 @param latitude 目的地纬度
 @param longitude 目的地经度
 */
+(void)navigationFromCurentLocationTo:(NSString * __nonnull)name
                             Latitude:(CGFloat)latitude
                            Longitude:(CGFloat)longitude;

/**
 启用导航软件导航到目的地，支持手机自带地图，高德地图，百度地图，腾讯地图，只会显示已安装的地图
 需要在info.plist 的 LSApplicationQueriesSchemes 添加 baidumap,iosamap,qqmap 。

 @param nameA 起点名称
 @param latitudeA 起点纬度
 @param longitudeA 起点经度
 @param nameB 终点名称
 @param latitudeB 终点纬度
 @param longitudeB 终点经度
 */
+(void)navigationFrom:(NSString * __nonnull)nameA
            LatitudeA:(CGFloat)latitudeA
           LongitudeA:(CGFloat)longitudeA
                   To:(NSString * __nonnull)nameB
             Latitude:(CGFloat)latitudeB
           LongitudeB:(CGFloat)longitudeB;

#pragma mark 手机自带的【地图】导航
/**
 从当前位置启用手机自带的【地图】导航到目的地。
 
 @param name 目的地名称
 @param longitude 目的地经度
 @param latitude 目的地纬度
 */
+ (void)naviGationByIOSTo:(NSString * __nonnull)name
                 Latitude:(CGFloat)latitude
                Longitude:(CGFloat)longitude;
/**
 启用手机自带的【地图】导航到目的地。
 
 @param nameA 起点名称
 @param latitudeA 起点纬度
 @param longitudeA 起点经度
 @param nameB 终点名称
 @param latitudeB 终点纬度
 @param longitudeB 终点经度
 */
+ (void)naviGationByIOSFrom:(NSString * __nonnull)nameA
                  LatitudeA:(CGFloat)latitudeA
                 LongitudeA:(CGFloat)longitudeA
                         To:(NSString * __nonnull)nameB
                   Latitude:(CGFloat)latitudeB
                 LongitudeB:(CGFloat)longitudeB;




#pragma mark 高德地图导航
/**
 从当前位置启用【高德地图】导航到目的地，手机应该安装有【高德地图】才能启用成功。
 需要在info.plist 的 LSApplicationQueriesSchemes 添加 iosamap 。
 
 @param name 目的地名称
 @param longitude 目的地经度
 @param latitude 目的地纬度
 */
+ (void)naviGationByGaoDeMapTo:(NSString * __nonnull)name
                      Latitude:(CGFloat)latitude
                     Longitude:(CGFloat)longitude;

/**
 启用【高德地图】导航到目的地，手机应该安装有【高德地图】才能启用成功。
 需要在info.plist 的 LSApplicationQueriesSchemes 添加 iosamap 。
 
 @param nameA 起点名称
 @param latitudeA 起点纬度
 @param longitudeA 起点经度
 @param nameB 终点名称
 @param latitudeB 终点纬度
 @param longitudeB 终点经度
 */
+ (void)naviGationByGaoDeMapFrom:(NSString *__nonnull)nameA
                       LatitudeA:(CGFloat)latitudeA
                      LongitudeA:(CGFloat)longitudeA
                              To:(NSString *__nonnull)nameB
                        Latitude:(CGFloat)latitudeB
                      LongitudeB:(CGFloat)longitudeB;


#pragma mark 百度地图导航
/**
 从当前位置启用【百度地图】导航到目的地，手机应该安装有【百度地图】才能启用成功。
 需要在info.plist 的 LSApplicationQueriesSchemes 添加 baidumap 。
 
 @param name 目的地名称
 @param longitude 目的地经度
 @param latitude 目的地纬度
 */
+ (void)naviGationByBaiDuMapTo:(NSString * __nonnull)name
                      Latitude:(CGFloat)latitude
                     Longitude:(CGFloat)longitude;

/**
 启用【百度地图】导航到目的地，手机应该安装有【百度地图】才能启用成功。
 需要在info.plist 的 LSApplicationQueriesSchemes 添加 baidumap 。
 
 @param nameA 起点名称
 @param latitudeA 起点纬度
 @param longitudeA 起点经度
 @param nameB 终点名称
 @param latitudeB 终点纬度
 @param longitudeB 终点经度
 */
+ (void)naviGationByBaiDuMapFrom:(NSString *__nonnull)nameA
                       LatitudeA:(CGFloat)latitudeA
                      LongitudeA:(CGFloat)longitudeA
                              To:(NSString *__nonnull)nameB
                        Latitude:(CGFloat)latitudeB
                      LongitudeB:(CGFloat)longitudeB;

#pragma mark 腾讯地图导航
/**
 从当前位置启用【腾讯地图】导航到目的地，手机应该安装有【腾讯地图】才能启用成功。
 需要在info.plist 的 LSApplicationQueriesSchemes 添加 qqmap 。
 
 @param name 目的地名称
 @param latitude 目的地纬度
 @param longitude 目的地经度
 */
+ (void)naviGationByQQuMapTo:(NSString * __nonnull)name
                    Latitude:(CGFloat)latitude
                   Longitude:(CGFloat)longitude;
/**
 启用【腾讯地图】导航到目的地，手机应该安装有【腾讯地图】才能启用成功。
 需要在info.plist 的 LSApplicationQueriesSchemes 添加 qqmap 。
 
 @param nameA 起点名称
 @param latitudeA 起点纬度
 @param longitudeA 起点经度
 @param nameB 终点名称
 @param latitudeB 终点纬度
 @param longitudeB 终点经度
 */
+ (void)naviGationByQQuMapFrom:(NSString *__nonnull)nameA
                     LatitudeA:(CGFloat)latitudeA
                    LongitudeA:(CGFloat)longitudeA
                            To:(NSString *__nonnull)nameB
                      Latitude:(CGFloat)latitudeB
                    LongitudeB:(CGFloat)longitudeB;

@end

#pragma mark - ● 弹出系统默认样式的提示框

@interface BSKUtils(AlertText)


/**
 弹出一个只有确定按钮的提示框
 
 @param vc 弹出提示框的controller
 @param title 提示框标题
 @param message 提示的内容
 @param sureAction 确定按钮的block
 */
+ (void)popAlertControllerAndSureWithContl:(UIViewController *__nonnull)vc
                                     Title:(NSString *__nonnull)title
                                   message:(NSString *__nonnull)message
                                sureAction:(sureAction __nonnull )sureAction;


/**
 弹出一个带确定和取消按钮的提示框
 
 @param vc 弹出提示框的controller
 @param title 提示框标题
 @param message 提示的内容
 @param left 确定按钮的文字
 @param right 取消按钮的文字
 @param cancelAction 确定按钮的block
 @param sureAction 取消按钮的block
 */
+ (void)popAlertLeftAndRightActionWithContl:(UIViewController *__nonnull)vc
                                      Title:(NSString * __nonnull)title
                                    message:(NSString * __nonnull)message
                                   leftItem:(NSString * __nonnull)left
                                  rightItem:(NSString * __nonnull)right
                                 leftAction:(cancelAction __nonnull)cancelAction
                                rightAction:(sureAction __nonnull)sureAction;

#pragma mark - ● 从颜色创建图片

/**
 从颜色获取UIImage
 
 @param color 颜色
 @return UIimage
 */
+ (UIImage* __nonnull) createImageWithColor: (UIColor* __nonnull) color;


/**
 从颜色创建UIImage

 @param color 颜色
 @param size UIImage的大小
 @return UIImage
 */
+ (UIImage* __nonnull) createImageWithColor: (UIColor* __nonnull) color
                                       Size:(CGSize)size;

#pragma mark - ● 检查手机号的合法性
/**
 判断是否是手机号码
 
 @param phoneNumber 电话号
 @return 返回一个布尔值表示是否是手机号
 */
+(BOOL)isPhoneNumber:(NSString * __nonnull) phoneNumber;


#pragma mark - ● 时间戳格式化
/**
 从时间戳获取格式化的时间字符串 yyy-MM-dd hh:mm 或 昨天/今天 hh:mm
 
 @param time 时间戳
 @return 时间字符串
 */
+(NSString * __nonnull)getTimeTextWithTimeSince1970:(NSTimeInterval )time;


#pragma mark - ● 压缩UIImage的大小
/**
 *  压缩图片到指定文件大小
 *
 *  @param image 目标图片
 *  @param size  目标大小（最大值,单位：字节）
 *
 *  @return 返回的图片文件
 */
+ (NSData * __nonnull)compressOriginalImage:(UIImage * __nonnull)image
                        toMaxDataSizeKBytes:(CGFloat)size;

#pragma mark - ● 日历相关
/**
 根据日期获取星期几
 
 @param date 时间
 @return 星期几 从1开始 1~7
 */
+(NSInteger )getWeekWithDate:(NSDate * __nonnull)date;

/**
 根据时间获取汉字的星期几字符串
 
 @param date 时间
 @return 星期字符串
 */
+(NSString * __nonnull)getWeekStringWithdate:(NSDate * __nonnull)date;

/**
 根据星期几的数字（1~7）获取汉字的星期几字符串
 
 @param weekNumber 星期几（1~7）
 @return 星期字符串
 */
+(NSString * __nonnull)getWeekStringWithWeekNumber:(NSInteger )weekNumber;


/**
 根据数字获取字符串如：1000000得到@"1百万"

 @param number 数字
 @return 返回的数字字符串
 */
+(NSString * __nonnull)getStringWithNumber:(double)number;

@end


NSInteger BSK_DayFromSeconds(NSTimeInterval s);//从秒获取天数
NSInteger BSK_HorFromSeconds(NSTimeInterval s);//从秒获取除掉整天后的小时
NSInteger BSK_MinutesSeconds(NSTimeInterval s);//从秒获取除掉整小时后的分
NSInteger BSK_SecondsFromSeconds(NSTimeInterval s);//从秒获取除掉整分的秒

#pragma mark - ● 其他
/**
 拼接字符串
 
 @param obj 拼接的NSObject对象
 @param ... 可变参数，数量不固定，以nil结尾
 @return 拼接后的字符串
 */
NSString * _Nullable BSKString(NSObject const * _Nullable obj,...);

/**
 整型转字符串

 @param number 整型数字
 @return 字符串
 */
NSString * __nonnull BSKIntToStr(NSInteger number);


