//
//  BSKViewPagerFlowLayout.m
//  掌萌宝贝-教师端
//
//  Created by 刘万林 on 2017/3/8.
//  Copyright © 2017年 cqyoumeiyi. All rights reserved.
//

#import "BSKViewPagerFlowLayout.h"

@interface BSKViewPagerFlowLayout ()
@end

@implementation BSKViewPagerFlowLayout

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    NSArray* attributes = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray * attributesToReturn = [NSMutableArray array];
    for (UICollectionViewLayoutAttributes * attr in attributes) {
        [attributesToReturn addObject:[attr copy]];
    }
    if (_itemAlignMode!=BSKViewPagerItemAlignModeLeft&&attributesToReturn.count==[self.collectionView numberOfItemsInSection:0]) {
            CGFloat w = 0.0f;
            for (UICollectionViewLayoutAttributes * attri in attributesToReturn) {
                w+=attri.frame.size.width;
            }
            if (w<(self.collectionView.frame.size.width)) {
                if (_itemAlignMode == BSKViewPagerItemAlignModeCenter) {
                    //居中
                    CGFloat offsetX = (self.collectionView.frame.size.width - w)/2.0;
                    for (UICollectionViewLayoutAttributes * attri in attributesToReturn) {
                        CGRect frame = attri.frame;
                        frame.origin.x += offsetX;
                        attri.frame = frame;
                    }
                }
                else if(_itemAlignMode == BSKViewPagerItemAlignModeAverage){
                    //平均
                    for (NSInteger index = 0; index <attributesToReturn.count; index++) {
                        UICollectionViewLayoutAttributes * attri = attributesToReturn[index];
                        CGRect frame = attri.frame;
                        frame.origin.x = index*(self.collectionView.frame.size.width/attributesToReturn.count);
                        frame.size.width = (self.collectionView.frame.size.width/attributesToReturn.count);
                        attri.frame = frame;
                    }
                }
            }
            UICollectionViewLayoutAttributes * attri = attributesToReturn[self.pager.selectedIndex];
            CGRect rec = attri.frame;
            CGRect frame = CGRectMake(rec.origin.x, self.pager.bounds.size.height-3, rec.size.width, 3);
            [UIView animateWithDuration:0.25 animations:^{
                self.pager.rectView.frame = frame;
            }];
    }else{
        UICollectionViewLayoutAttributes * attri = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:self.pager.selectedIndex inSection:0]];
        CGRect rec = attri.frame;
        CGRect frame = CGRectMake(rec.origin.x, self.pager.bounds.size.height-3, rec.size.width, 3);
        [UIView animateWithDuration:0.25 animations:^{
            self.pager.rectView.frame = frame;
        }];
    }
    
    return attributesToReturn;
}
@end
