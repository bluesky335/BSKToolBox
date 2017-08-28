//
//  BSKViewPager.h
//  融云Test
//
//  Created by 刘万林 on 2016/12/21.
//  Copyright © 2016年 刘万林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSKViewPagerCollectionViewCell.h"

typedef NS_ENUM(NSInteger,BSKViewPagerItemAlignMode){
    BSKViewPagerItemAlignModeCenter,//中心对其
    BSKViewPagerItemAlignModeLeft,//左对齐
    BSKViewPagerItemAlignModeAverage//平均
};

@class BSKViewPager;

@protocol BSKViewPagerDelegate<NSObject>

/**
 可选方法，根据需求选择实现
 */
@optional

/**
 自定义没个item的宽度

 @param viewPager BSKViewPager
 @param index index
 @return item宽度
 */
-(CGFloat)ViewPager:(BSKViewPager *)viewPager widthForItemAtIndex:(NSInteger)index;

/**
 是否可以改变升序和降序的状态

 @param viewPager BSKViewPager
 @param index index
 @return 布尔值
 */
-(BOOL)ViewPager:(BSKViewPager *)viewPager canChangeStatusAtIndex:(NSInteger)index;

-(BOOL)ViewPager:(BSKViewPager *)viewPager CanSelectedItemAtIndex:(NSInteger)index;
//以下两个方法二选一即可，第一个方法有更高的优先级，一旦实现第一个方法第二个就不会被调用。
-(void)ViewPager:(BSKViewPager *)viewPager didSelectedItemAtIndex:(NSInteger)index withStatus:(BSKViewPagerItemStatus)status;
-(void)ViewPager:(BSKViewPager *)viewPager didSelectedItemAtIndex:(NSInteger)index;

@end

@interface BSKViewPager : UIView

@property (assign, nonatomic) BOOL showImageOnRight;//让图片显示在按钮右边
@property (strong, nonatomic) UIView * rectView;//滑块
@property (strong, nonatomic) UIImage * imageForStatusUp;//升序的按钮图片
@property (strong, nonatomic) UIImage * imageForStatusDown;//降序的按钮图片
@property (strong, nonatomic) UIImage * imageForStatusNormale;//未选中时的按钮图片
@property (strong, nonatomic) NSArray * titles;//显示的按钮标题们
@property (strong, nonatomic) UIColor * tintColor;//前景色
@property (strong, nonatomic) UIColor * selectedTintColor;//选中按钮的前景色
@property (strong, nonatomic) UIColor * bottomLineColor;//底部线条颜色
@property (strong, nonatomic) UIFont * titleFont;//按钮的字体
@property (assign, nonatomic) NSInteger selectedIndex;//选中的index
@property (assign, nonatomic) CGFloat padingLeftAndRight;//距离左右的内边距
@property (weak, nonatomic) id<BSKViewPagerDelegate> delegate;//点击事件代理
@property (assign, nonatomic) CGFloat minimumItemWidth;
@property (assign, nonatomic) CGFloat imageWidth;//设置图片宽度，高度等于宽度。默认为14
@property (assign, nonatomic) BSKViewPagerItemAlignMode itemAlignMode;//当item较少的时候的对齐方式.默认为’BSKViewPagerItemAlignModeAverage(平均)'
@property (assign, nonatomic) BOOL showBootomLine;

-(void)setCurentSelectedIndex:(NSInteger)selectedIndex;
@end


