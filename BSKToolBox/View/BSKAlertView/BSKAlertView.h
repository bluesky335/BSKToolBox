//
//  BSKAlertView.h
//  MicroMemory
//
//  Created by rimi on 16/7/21.
//  Copyright © 2016年 BlueSky. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger ,BSKAlertViewAnimationType){
    BSKAlertViewAnimationTypeBigToSmall = 0,
    BSKAlertViewAnimationTypeSmallToBig,
    BSKAlertViewAnimationTypeOpacity,
    BSKAlertViewAnimationTypeBottomToTop,
    BSKAlertViewAnimationTypeTopToBottom,
    BSKAlertViewAnimationTypeLeftToRight,
    BSKAlertViewAnimationTypeRightToLeft,
    BSKAlertViewAnimationTypeFlowTopToBottom,
};

@interface BSKAlertView : UIView

@property (assign, nonatomic) CGFloat SpringDamping;//动画的弹簧系数，默认为1；值为0~1 ,越大弹动幅度越大
@property (assign, nonatomic) CGFloat SpringVelocity;//动画的弹簧初始速率，默认为0； 越大初始速度越快，
@property (assign, nonatomic) CGFloat animateDuration;//动画的时长，默认为0.25秒；
@property (strong, nonatomic) UIView * contentView;//要显示的View，默认为nil
@property (assign,nonatomic) BOOL responseToAction;//是否响应点击背景隐藏视图的手势操作
@property (assign, nonatomic) BSKAlertViewAnimationType animationTypeWhenShow;//弹出时的动画，隐藏时动画与之相反
@property (assign, nonatomic) BOOL showBackgroungShadow;//是否显示背景阴影
@property (assign, nonatomic,readonly) BOOL isShow;
@property (assign, nonatomic) BOOL maskToBounds;
@property (assign, nonatomic) CGFloat backgroundAlpha; //背景黑色的透明度
@property (assign, nonatomic) BOOL animatedContentViewAlpha;//是否动画ContentView的alpha属性，默认为YES（在动画类型为flow的时候无效）

@property (assign, nonatomic) UIViewAnimationOptions animationOptions;//动画选项，默认是 UIViewAnimationOptionTransitionNone|UIViewAnimationOptionCurveEaseInOut

@property (copy, nonatomic) void(^willAppearBlock)(BSKAlertView * view);//将要显示
@property (copy, nonatomic) void(^willDisappearBlock)(BSKAlertView * view);//将要隐藏
@property (copy, nonatomic) void(^DidAppearBlock)(BSKAlertView * view);//已经显示
@property (copy, nonatomic) void(^DidDisappearBlock)(BSKAlertView * view);//已经隐藏

-(void)show;//显示
-(void)hide;//隐藏
@end
