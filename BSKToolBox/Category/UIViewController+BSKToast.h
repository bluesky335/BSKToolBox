//
//  UIViewController+BSKToast.h
//  MicroMemory
//
//  Created by rimi on 16/7/18.
//  Copyright © 2016年 BlueSky. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BSKToastConfig : NSObject

@property (strong, nonatomic,readonly) NSNotification       * kbWillShowNotification;
@property (assign, nonatomic,readonly) CGSize               keyBoardSize;
@property (assign, nonatomic,readonly) BOOL                 isKeyboardShowing;

@property (strong, nonatomic         ) UIColor              * ToastBackgroundColor;
@property (strong, nonatomic         ) UIColor              * ToastTextColor;
@property (strong, nonatomic         ) UIFont               * ToastTextFont;
@property (assign, nonatomic         ) CGFloat              ToastCornerRadius;
@property (assign, nonatomic         ) CGFloat              ShadowAlpha;
@property (assign, nonatomic         ) CGFloat              ShadowRadius;

+(instancetype)shareInstance;

/**
 如果想让提示的文字在键盘弹出时不被遮挡，请在APPDelegate里的application:didFinishLaunchingWithOptions:方法中调用一次这个方法，获得键盘弹出和隐藏的通知。
 */
-(void)getKeyBoardNotification;

@end

@interface UIViewController (BSKToast)

/**
 弹出文字提示，类似安卓的Toast

 @param text 提示的文字
 @param seconds 停留时间
 */
-(void)bsk_MakeToast:(NSString *)text
            WithTime:(double)seconds;
/**
 弹出警告的文字提示，类似安卓的Toast

 @param text 提示的文字
 @param seconds 停留时间
 */
-(void)bsk_MakeErrorToast:(NSString *)text
                 WithTime:(double)seconds;
/**
 弹出文字提示，类似安卓的Toast

 @param text 提示的文字
 @param seconds 停留时间
 */
+(void)bsk_MakeToast:(NSString *)text
            WithTime:(double)seconds;
/**
 弹出警告的文字提示，类似安卓的Toast

 @param text 提示的文字
 @param seconds 停留时间
 */
+(void)bsk_MakeErrorToast:(NSString *)text
                 WithTime:(double)seconds;
@end

