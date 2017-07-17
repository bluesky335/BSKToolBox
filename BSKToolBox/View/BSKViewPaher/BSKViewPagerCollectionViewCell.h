//
//  BSKViewPagerCollectionViewCell.h
//  掌萌宝贝-教师端
//
//  Created by 刘万林 on 2017/3/6.
//  Copyright © 2017年 cqyoumeiyi. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,BSKViewPagerItemStatus){
    BSKViewPagerItemStatusNormal,
    BSKViewPagerItemStatusUp,
    BSKViewPagerItemStatusDown
};

@interface BSKViewPagerCollectionViewCell : UICollectionViewCell
@property (assign, nonatomic) BOOL canChangeStatus;
@property (assign, nonatomic) BOOL showImageOnRight;
@property (copy, nonatomic) NSString * title;
@property (strong, nonatomic) UIColor * tintColor;
@property (strong, nonatomic) UIColor * selectedTintColor;
@property (assign, nonatomic) BSKViewPagerItemStatus status;
@property (strong, nonatomic) UIImage * imageForUp;
@property (strong, nonatomic) UIImage * imageForDown;
@property (strong, nonatomic) UIImage * imageForNormal;
@property (assign, nonatomic) CGFloat imageWidth;

-(void)setTitleFont:(UIFont *)titleFont;

@end
