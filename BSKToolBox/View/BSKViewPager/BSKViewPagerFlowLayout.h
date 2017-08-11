//
//  BSKViewPagerFlowLayout.h
//  掌萌宝贝-教师端
//
//  Created by 刘万林 on 2017/3/8.
//  Copyright © 2017年 cqyoumeiyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSKViewPager.h"
@interface BSKViewPagerFlowLayout : UICollectionViewFlowLayout
@property (weak, nonatomic) BSKViewPager * pager;
@property (assign, nonatomic) BSKViewPagerItemAlignMode itemAlignMode;//当item较少的时候的对齐方式
@end
