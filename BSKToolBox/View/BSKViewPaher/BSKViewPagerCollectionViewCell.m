//
//  BSKViewPagerCollectionViewCell.m
//  掌萌宝贝-教师端
//
//  Created by 刘万林 on 2017/3/6.
//  Copyright © 2017年 cqyoumeiyi. All rights reserved.
//

#import "BSKViewPagerCollectionViewCell.h"

@interface BSKViewPagerCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *leftImage;
@property (weak, nonatomic) IBOutlet UIImageView *rightImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelCenter;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftImageWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightImageWidth;

@end

@implementation BSKViewPagerCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setSelected:(BOOL)selected{
    if (selected) {
        self.titleLabel.textColor = self.selectedTintColor;
    }else{
        self.titleLabel.textColor = self.tintColor;
    }
}

-(void)setStatus:(BSKViewPagerItemStatus)status{
    _status = status;
    if (!_canChangeStatus) {
        self.leftImage.hidden = YES;
        self.rightImage.hidden = YES;
        return;
    }
    if (status==BSKViewPagerItemStatusUp) {
        if (self.imageForUp) {
            self.leftImage.image = self.imageForUp;
            self.rightImage.image = self.imageForUp;
        }
        
    }else if(status == BSKViewPagerItemStatusDown){
        if (self.imageForDown) {
            self.leftImage.image = self.imageForDown;
            self.rightImage.image = self.imageForDown;
        }
    }else{
        if (self.imageForNormal) {
            self.leftImage.image = self.imageForNormal;
            self.rightImage.image = self.imageForNormal;
        }
    }
}
-(void)setCanChangeStatus:(BOOL)canChangeStatus{
    _canChangeStatus = canChangeStatus;
    if (!_canChangeStatus) {
        self.leftImage.hidden = YES;
        self.rightImage.hidden = YES;
        
        if (!self.canChangeStatus) {
            self.titleLabelCenter.constant = 0;
        }
    }
}

-(void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
}

-(void)setTitleFont:(UIFont *)titleFont{
    self.titleLabel.font = titleFont;
}

-(void)setSelectedTintColor:(UIColor *)selectedTintColor{
    _selectedTintColor = selectedTintColor;
    if (self.selected) {
        self.titleLabel.textColor = selectedTintColor;
    }
}

-(void)setTintColor:(UIColor *)tintColor{
    _tintColor = tintColor;
    if (!self.selected) {
        self.titleLabel.textColor = tintColor;
    }
}

-(void)setShowImageOnRight:(BOOL)showImageOnRight{

    _showImageOnRight = showImageOnRight;
    if (showImageOnRight) {
        self.leftImage.hidden = YES;
        self.rightImage.hidden = NO;
        self.titleLabelCenter.constant = self.bounds.size.height*0.25*-1;
    }else{
        self.leftImage.hidden = NO;
        self.rightImage.hidden = YES;
        self.titleLabelCenter.constant = self.bounds.size.height*0.25;
    }
    if (!self.canChangeStatus) {
        self.titleLabelCenter.constant = 0;
        self.leftImage.hidden = YES;
        self.rightImage.hidden = YES;
    }
}
-(void)setImageWidth:(CGFloat)imageWidth{
    _imageWidth = imageWidth;
    self.leftImageWidth.constant = imageWidth;
    self.rightImageWidth.constant = imageWidth;
}




@end
