//
//  BSKUtils.m
//  LoveStillArtHouse
//
//  Created by 刘万林 on 13/05/2017.
//  Copyright © 2017 Me. All rights reserved.
//

#import "BSKUtils.h"
#import <CommonCrypto/CommonDigest.h>
#import "BSKToolBox.h"

@import MapKit;
@implementation BSKUtils
@end
@implementation BSKUtils(Navigation)


+(void)navigationFromCurentLocationTo:(NSString *)name
                             Latitude:(CGFloat)latitude
                            Longitude:(CGFloat)longitude
{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"请选择导航方式" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * actionIOS = [UIAlertAction actionWithTitle:@"使用手机自带的“地图”" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [BSKUtils naviGationByIOSTo:name Latitude:latitude Longitude:longitude];
    }];
    UIAlertAction * actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]])// -- 使用 canOpenURL 判断需要在info.plist 的 LSApplicationQueriesSchemes 添加 iosamap 。
    {
        UIAlertAction * actionGaode = [UIAlertAction actionWithTitle:@"使用“高德地图”" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [BSKUtils naviGationByGaoDeMapTo:name Latitude:latitude Longitude:longitude];
        }];
        [alertController addAction:actionGaode];
    }
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]])// -- 使用 canOpenURL 判断需要在info.plist 的 LSApplicationQueriesSchemes 添加 baidumap 。
    {
        UIAlertAction * actionBaidu = [UIAlertAction actionWithTitle:@"使用“百度地图”" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [BSKUtils naviGationByBaiDuMapTo:name Latitude:latitude Longitude:longitude];
        }];
        [alertController addAction:actionBaidu];
    }
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"qqmap://"]])// -- 使用 canOpenURL 判断需要在info.plist 的 LSApplicationQueriesSchemes 添加 qqmap 。
    {
        UIAlertAction * actionQQ = [UIAlertAction actionWithTitle:@"使用“腾讯地图”" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [BSKUtils naviGationByQQuMapTo:name Latitude:latitude Longitude:longitude];
        }];
        [alertController addAction:actionQQ];
    }
    
    [alertController addAction:actionIOS];
    [alertController addAction:actionCancel];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}

+(void)navigationFrom:(NSString *)nameA
            LatitudeA:(CGFloat)latitudeA
           LongitudeA:(CGFloat)longitudeA
                   To:(NSString *)nameB
             Latitude:(CGFloat)latitudeB
           LongitudeB:(CGFloat)longitudeB
{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"请选择导航方式" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * actionIOS = [UIAlertAction actionWithTitle:@"使用手机自带的“地图”" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [BSKUtils naviGationByIOSFrom:nameA
                            LatitudeA:latitudeA
                           LongitudeA:longitudeA
                                   To:nameB
                             Latitude:latitudeB
                           LongitudeB:longitudeB
         ];
    }];
    UIAlertAction * actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]])// -- 使用 canOpenURL 判断需要在info.plist 的 LSApplicationQueriesSchemes 添加 iosamap 。
    {
        UIAlertAction * actionGaode = [UIAlertAction actionWithTitle:@"使用“高德地图”" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [BSKUtils naviGationByGaoDeMapFrom:nameA
                                     LatitudeA:latitudeA
                                    LongitudeA:longitudeA
                                            To:nameB
                                      Latitude:latitudeB
                                    LongitudeB:longitudeB
             ];
        }];
        [alertController addAction:actionGaode];
    }
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]])// -- 使用 canOpenURL 判断需要在info.plist 的 LSApplicationQueriesSchemes 添加 baidumap 。
    {
        UIAlertAction * actionBaidu = [UIAlertAction actionWithTitle:@"使用“百度地图”" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [BSKUtils naviGationByBaiDuMapFrom:nameA
                                     LatitudeA:latitudeA
                                    LongitudeA:longitudeA
                                            To:nameB
                                      Latitude:latitudeB
                                    LongitudeB:longitudeB
             ];
        }];
        [alertController addAction:actionBaidu];
    }
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"qqmap://"]])// -- 使用 canOpenURL 判断需要在info.plist 的 LSApplicationQueriesSchemes 添加 qqmap 。
    {
        UIAlertAction * actionQQ = [UIAlertAction actionWithTitle:@"使用“腾讯地图”" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [BSKUtils naviGationByQQuMapFrom:nameA
                                   LatitudeA:latitudeA
                                  LongitudeA:longitudeA
                                          To:nameB
                                    Latitude:latitudeB
                                  LongitudeB:longitudeB
             ];
        }];
        [alertController addAction:actionQQ];
    }
    
    [alertController addAction:actionIOS];
    [alertController addAction:actionCancel];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}

#pragma mark ------------------------------ 导航 - iOS自带
+ (void)naviGationByIOSTo:(NSString *)name
                 Latitude:(CGFloat)latitude
                Longitude:(CGFloat)longitude
{
    
    //当前的位置
    CLLocationCoordinate2D endCoor = CLLocationCoordinate2DMake(latitude, longitude);
    MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:endCoor addressDictionary:nil]];
    toLocation.name = name;
    //toLocation.name = self.address.text;
    [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                   launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,
                                   MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]
                                   }
     ];
}

+ (void)naviGationByIOSFrom:(NSString *)nameA
                  LatitudeA:(CGFloat)latitudeA
                 LongitudeA:(CGFloat)longitudeA
                         To:(NSString *)nameB
                   Latitude:(CGFloat)latitudeB
                 LongitudeB:(CGFloat)longitudeB
{
    
    CLLocationCoordinate2D startCoor = CLLocationCoordinate2DMake(latitudeA, longitudeA);
    CLLocationCoordinate2D endCoor = CLLocationCoordinate2DMake(latitudeB, longitudeB);
    MKMapItem *fromeLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:startCoor addressDictionary:nil]];
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:endCoor addressDictionary:nil]];
    fromeLocation.name = nameA;
    toLocation.name = nameB;
    //toLocation.name = self.address.text;
    [MKMapItem openMapsWithItems:@[fromeLocation, toLocation] launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
}
#pragma mark ------------------------------ 导航 - 高德

+ (void)naviGationByGaoDeMapTo:(NSString *)name
                      Latitude:(CGFloat)latitude
                     Longitude:(CGFloat)longitude
{
    CGFloat lat1 = [[NSUserDefaults standardUserDefaults] doubleForKey:@"Location:latitude"];
    CGFloat lng1 = [[NSUserDefaults standardUserDefaults] doubleForKey:@"Location:longitude"];
    NSString * startName = @"我的位置";
    [BSKUtils naviGationByGaoDeMapFrom:startName
                             LatitudeA:lat1
                            LongitudeA:lng1
                                    To:name
                              Latitude:latitude
                            LongitudeB:longitude
     ];
}
+ (void)naviGationByGaoDeMapFrom:(NSString *)nameA
                       LatitudeA:(CGFloat)latitudeA
                      LongitudeA:(CGFloat)longitudeA
                              To:(NSString *)nameB
                        Latitude:(CGFloat)latitudeB
                      LongitudeB:(CGFloat)longitudeB
{
    NSString * url = [[NSString stringWithFormat:@"iosamap://path?sourceApplication=applicationName&sid=BGVIS1&slat=%f&slon=%f&sname=%@&did=BGVIS2&dlat=%f&dlon=%f&dname=%@&dev=0&m=0&t=0",latitudeA,longitudeA,nameA,latitudeB,longitudeB,nameB]
                      stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    } else {
        [UIViewController bsk_MakeToast:@"请先安装高德地图" WithTime:1];
    }
}
#pragma mark ------------------------------ 导航 - 百度
+ (void)naviGationByBaiDuMapTo:(NSString *)name
                      Latitude:(CGFloat)latitude
                     Longitude:(CGFloat)longitude
{
    CGFloat lat1 = [[NSUserDefaults standardUserDefaults] doubleForKey:@"Location:latitude"];
    CGFloat lng1 = [[NSUserDefaults standardUserDefaults] doubleForKey:@"Location:longitude"];
    NSString * startName = @"我的位置";
    [BSKUtils naviGationByBaiDuMapFrom:startName
                             LatitudeA:lat1
                            LongitudeA:lng1
                                    To:name
                              Latitude:lat1
                            LongitudeB:longitude
     ];
}

+ (void)naviGationByBaiDuMapFrom:(NSString *)nameA
                       LatitudeA:(CGFloat)latitudeA
                      LongitudeA:(CGFloat)longitudeA
                              To:(NSString *)nameB
                        Latitude:(CGFloat)latitudeB
                      LongitudeB:(CGFloat)longitudeB
{
    NSString *url = [[NSString stringWithFormat:@"baidumap://map/direction?origin=name:%@|latlng:%lf,%lf&destination=name:%@|latlng:%lf,%lf&mode=driving&src=webapp.navi.86town.86town",nameA,latitudeA,longitudeA,nameB,latitudeA ,longitudeB] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSLog(@"--url = : %@",url);
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]])// -- 使用 canOpenURL 判断需要在
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }else{
        [UIViewController bsk_MakeToast:@"请先安装百度地图" WithTime:1];
    }    
}
#pragma mark ------------------------------ 导航 - 腾讯
+ (void)naviGationByQQuMapTo:(NSString *)name
                    Latitude:(CGFloat)latitude
                   Longitude:(CGFloat)longitude
{
    CGFloat lat1 = [[NSUserDefaults standardUserDefaults] doubleForKey:@"Location:latitude"];
    CGFloat lng1 = [[NSUserDefaults standardUserDefaults] doubleForKey:@"Location:longitude"];
    NSString * startName = @"我的位置";
    [BSKUtils naviGationByQQuMapFrom:startName
                           LatitudeA:lat1
                          LongitudeA:lng1
                                  To:startName
                            Latitude:latitude
                          LongitudeB:longitude
     ];
    
}
+ (void)naviGationByQQuMapFrom:(NSString *)nameA
                     LatitudeA:(CGFloat)latitudeA
                    LongitudeA:(CGFloat)longitudeA
                            To:(NSString *)nameB
                      Latitude:(CGFloat)latitudeB
                    LongitudeB:(CGFloat)longitudeB
{
    NSString *url = [[NSString stringWithFormat:@"qqmap://map/routeplan?referer=RoutePlanningDemo&tocoord=%f,%f&to=%@&type=drive&fromcoord=%f,%f&from=%@",latitudeB,longitudeB,nameB,latitudeA,longitudeB,nameA] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSLog(@"--url = : %@",url);
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"qqmap://"]])
    {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }else{
        [UIViewController bsk_MakeToast:@"请先安装腾讯地图" WithTime:1];
    }
}

#pragma mark - ● ===============================

@end

@implementation BSKUtils(AlertText)
//提示框： 取消 确定
+ (void)popAlertLeftAndRightActionWithContl:(UIViewController *)vc Title:(NSString *)title message:(NSString *)message leftItem:(NSString *)left rightItem:(NSString *)right leftAction:(cancelAction)cancelAction rightAction:(sureAction)sureAction {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:left style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
        if(cancelAction){cancelAction(action);}
    }];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:right style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
        if(sureAction){sureAction(action);}
    }];
    [alert addAction:cancel];
    [alert addAction:sure];
    //
    [vc presentViewController:alert animated:YES completion:nil];
}

//提示框： 确定按钮
+ (void)popAlertControllerAndSureWithContl:(UIViewController *)vc Title:(NSString *)title message:(NSString *)message sureAction:(sureAction)sureAction {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureActoin = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
        if(sureAction){sureAction(action);}
    }];
    [alert addAction:sureActoin];
    //
    [vc presentViewController:alert animated:YES completion:nil];
    
}

/**
 从颜色获取图片
 
 @param color 颜色
 @return UIimage
 */
+ (UIImage*) createImageWithColor: (UIColor*) color
{
    return [BSKUtils createImageWithColor:color Size:CGSizeMake(0.5, 0.5)];
}

+ (UIImage*) createImageWithColor: (UIColor*) color Size:(CGSize)size
{
    CGRect rect=CGRectMake(0,0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+(BOOL)isPhoneNumber:(NSString *) phoneNumber {
    NSString *MOBILE = @"0?(1)[0-9]{10}";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:phoneNumber];
}

+(NSString * )getTimeTextWithTimeSince1970:(NSTimeInterval )time{
    NSDateFormatter * formater = [[NSDateFormatter alloc] init];
    NSString *timeStr = nil;
    double now = (NSInteger)[[NSDate date] timeIntervalSince1970];
    
    NSDate * date =[NSDate dateWithTimeIntervalSince1970:time];
    NSDate * tomorrow = [NSDate dateWithTimeIntervalSince1970:now+24*60*60];
    NSDate * yesterday = [NSDate dateWithTimeIntervalSince1970:now-24*60*60];
    
    [formater setDateFormat:@"yyyy.MM.dd HH:mm"];
    NSString * tomorrowStr = [formater stringFromDate:tomorrow];
    NSString * yesterdayStr = [formater stringFromDate:yesterday];
    NSString * nowStr = [formater stringFromDate:[NSDate dateWithTimeIntervalSince1970:now]];
    
    NSString * dateStr = [formater stringFromDate:date];
    
    if ([dateStr isEqualToString:nowStr]) {
        [formater setDateFormat:@"今天 HH:mm"];
    }else if ([dateStr isEqualToString:tomorrowStr]){
        [formater setDateFormat:@"明天 HH:mm"];
    }else if ([dateStr isEqualToString:yesterdayStr]){
        [formater setDateFormat:@"昨天 HH:mm"];
    }else{
        NSString * yearStr = [nowStr substringToIndex:3];
        if ([dateStr bsk_isStartWith:yearStr]) {
            [formater setDateFormat:@"M月d日 HH:mm"];
        }else{
            [formater setDateFormat:@"yyyy M月d日 HH:mm"];
        }
    }
    timeStr = [formater stringFromDate:date];
    return timeStr;
}

/**
 *  压缩图片到指定文件大小
 *
 *  @param image 目标图片
 *  @param size  目标大小（最大值）
 *
 *  @return 返回的图片文件
 */

+ (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size{
    NSData * data = UIImageJPEGRepresentation(image, 1.0);
    CGFloat dataKBytes = data.length/1000.0;
    CGFloat maxQuality = 0.9f;
    CGFloat lastData = dataKBytes;
    while (dataKBytes > size && maxQuality > 0.01f) {
        maxQuality = maxQuality - 0.01f;
        data = UIImageJPEGRepresentation(image, maxQuality);
        dataKBytes = data.length / 1000.0;
        if (lastData == dataKBytes) {
            break;
        }else{
            lastData = dataKBytes;
        }
    }
    return data;
}

+(NSInteger )getWeekWithDate:(NSDate * )date{
    NSCalendar * calendr = [NSCalendar currentCalendar];
    NSDateComponents * components = [calendr components:NSCalendarUnitWeekday fromDate:[NSDate date]];
    NSInteger week = (components.weekday-1)>0?(components.weekday-1):7;
    return week;
}

+(NSString * )getWeekStringWithdate:(NSDate * )date{
    return [BSKUtils getWeekStringWithWeekNumber:[BSKUtils getWeekWithDate:date]];
}


+(NSString * )getWeekStringWithWeekNumber:(NSInteger ) weekNumber{
    NSString * week = nil;
    switch (weekNumber) {
        case 1:
            week = @"星期一";
            break;
        case 2:
            week = @"星期二";
            break;
        case 3:
            week = @"星期三";
            break;
        case 4:
            week = @"星期四";
            break;
        case 5:
            week = @"星期五";
            break;
        case 6:
            week = @"星期六";
            break;
        case 7:
            week = @"星期日";
            break;
            
        default:
            week = @"错误的weekNumber";
            break;
    }
    return week;
}

+(NSString *)getStringWithNumber:(double)number{
    NSString * str = [NSString stringWithFormat:@"%g",number];
    if (number>=100000000) {
        double n = number /100000000;
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        numberFormatter.numberStyle = kCFNumberFormatterNoStyle;//
        numberFormatter.positiveFormat = @"###0.0亿";// 类似dateFormatter
        numberFormatter.formatWidth = 0; // 数据宽度为20，
        numberFormatter.paddingCharacter = @"a";// 不足前面补 a
        numberFormatter.locale = [NSLocale currentLocale];// 本地化
        numberFormatter.generatesDecimalNumbers = NO;// 默认 NO,YES-转换成 NSNumber 方法会转换成 NSDecimalNumber
        str = [numberFormatter stringFromNumber:@(n)];
    }else if (number>=10000000) {
        double n = number /10000000;
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        numberFormatter.numberStyle = kCFNumberFormatterNoStyle;//
        numberFormatter.positiveFormat = @"###0.0千万";// 类似dateFormatter
        numberFormatter.formatWidth = 0; // 数据宽度为20，
        numberFormatter.paddingCharacter = @"a";// 不足前面补 a
        numberFormatter.locale = [NSLocale currentLocale];// 本地化
        numberFormatter.generatesDecimalNumbers = NO;// 默认 NO,YES-转换成 NSNumber 方法会转换成 NSDecimalNumber
        str = [numberFormatter stringFromNumber:@(n)];
    }else if (number>=1000000) {
        double n = number /1000000;
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        numberFormatter.numberStyle = kCFNumberFormatterNoStyle;//
        numberFormatter.positiveFormat = @"###0.0百万";// 类似dateFormatter
        numberFormatter.formatWidth = 0; // 数据宽度为20，
        numberFormatter.paddingCharacter = @"a";// 不足前面补 a
        numberFormatter.locale = [NSLocale currentLocale];// 本地化
        numberFormatter.generatesDecimalNumbers = NO;// 默认 NO,YES-转换成 NSNumber 方法会转换成 NSDecimalNumber
        str = [numberFormatter stringFromNumber:@(n)];
    }else
//        if (number>=100000) {
//        double n = number /100000;
//        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
//        numberFormatter.numberStyle = kCFNumberFormatterNoStyle;//
//        numberFormatter.positiveFormat = @"###0.0十万";// 类似dateFormatter
//        numberFormatter.formatWidth = 0; // 数据宽度为20，
//        numberFormatter.paddingCharacter = @"a";// 不足前面补 a
//        numberFormatter.locale = [NSLocale currentLocale];// 本地化
//        numberFormatter.generatesDecimalNumbers = NO;// 默认 NO,YES-转换成 NSNumber 方法会转换成 NSDecimalNumber
//        str = [numberFormatter stringFromNumber:@(n)];
//    }else
        if (number>=10000) {
        double n = number /10000;
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        numberFormatter.numberStyle = kCFNumberFormatterNoStyle;//
        numberFormatter.positiveFormat = @"###0.0万";// 类似dateFormatter
        numberFormatter.formatWidth = 0; // 数据宽度为20，
        numberFormatter.paddingCharacter = @"a";// 不足前面补 a
        numberFormatter.locale = [NSLocale currentLocale];// 本地化
        numberFormatter.generatesDecimalNumbers = NO;// 默认 NO,YES-转换成 NSNumber 方法会转换成 NSDecimalNumber
        str = [numberFormatter stringFromNumber:@(n)];
    }
    return str;
}



@end


NSString * BSKString( NSObject const * obj,...){
    va_list arg_ptr;
    NSObject const * nArgValue = obj;
    va_start(arg_ptr,obj);
    NSMutableString * str = [NSMutableString string];
    while(nArgValue != nil&&nArgValue!=NULL)
    {
        if ([nArgValue isKindOfClass:[NSNumber class]]) {
            NSNumber * number =  ( NSNumber * )nArgValue;
            NSString * nstr = [NSString stringWithFormat:@"%@",number];
            NSRange range = [nstr rangeOfString:@"."];
            if (range.location<nstr.length-2) {
                [str appendString:[NSString stringWithFormat:@"%.2lf",[number doubleValue]]];
            }else{
                [str appendString:nstr];
            }
        }else{
            [str appendString:[NSString stringWithFormat:@"%@",nArgValue]];
        }
        nArgValue=va_arg(arg_ptr,NSObject *);
    }
    return str;
}

NSString * __nonnull BSKIntToStr(NSInteger number){
#if __LP64__ || (TARGET_OS_EMBEDDED && !TARGET_OS_IPHONE) || TARGET_OS_WIN32 || NS_BUILD_32_LIKE_64
    return [NSString stringWithFormat:@"%ld",number];
#else
    return [NSString stringWithFormat:@"%d",number];
#endif
}


NSInteger BSK_DayFromSeconds(NSTimeInterval s){
    return ((NSInteger)s)/(3600*24);
}
NSInteger BSK_HorFromSeconds(NSTimeInterval s){
    return ((NSInteger)s)%(3600*24)/3600;
}
NSInteger BSK_MinutesSeconds(NSTimeInterval s){
    return ((NSInteger)s)%3600/60;
}
NSInteger BSK_SecondsFromSeconds(NSTimeInterval s){
    return ((NSInteger)s)%60;
}
