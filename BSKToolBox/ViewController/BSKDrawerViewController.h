//
//  BSKDrawerViewController.h
//  侧边栏
//
//  Created by 刘万林 on 2016/12/17.
//  Copyright © 2016年 刘万林. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, BSKDrawerAnimationMode) {
    //打开抽屉的动画选项
    BSKDrawerAnimationPush,
    BSKDrawerAnimationCover,
    BSKDrawerAnimationDynamicUncover,
    BSKDrawerAnimationStaticUncover
};


@interface BSKDrawerViewController : UIViewController
@property (strong, nonatomic)IBOutlet UIViewController * leftViewController;//抽屉控制器
@property (strong, nonatomic) UIViewController * centerViewController;//主体控制器
@property (assign, nonatomic)  BSKDrawerAnimationMode animationMode;//动画模式
@property (assign, nonatomic) BOOL isDrawerOpen;//抽屉是否打开  如果需要得到抽屉的打开与关闭事件，请用观察者模式监听这个属性。
@property (assign, nonatomic) BOOL canOpenDrawer;//是否可以打开抽屉
@property (assign, nonatomic) BOOL darkenCenterViewController;//centerViewController是否变暗
@property (assign, nonatomic) CGFloat drawerWidth;//抽屉的宽度
@property (assign, nonatomic) BOOL showShadow;//是否显示阴影
@property (assign, nonatomic) CGFloat animationDurationTime;//动画持续时间，默认0.2秒
@property (assign, nonatomic) CGRect frameToRespondOpenGesture;//响应打开抽屉手势的区域 默认为整个controller。
@property (assign, nonatomic) CGFloat openFlag;
@property (assign, nonatomic) CGFloat closeFlag;

/**
 关闭抽屉
 */
-(void)closeDrawer;

/**
 关闭抽屉
 */
-(void)closeDrawerWithComplate:(void(^)(BOOL isDrawerOpen))complate;


/**
 打开抽屉
 */
-(void)openDrawer;

/**
 打开抽屉
 */
-(void)openDrawerWithComplate:(void(^)(BOOL isDrawerOpen))complate;

@end


@interface BSKDrawerViewControllerSegue:UIStoryboardSegue
@end

