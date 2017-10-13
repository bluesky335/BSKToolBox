//
//  BSKViewPager.m
//  融云Test
//
//  Created by 刘万林 on 2016/12/21.
//  Copyright © 2016年 刘万林. All rights reserved.
//

#import "BSKViewPager.h"
#import "BSKViewPagerFlowLayout.h"
#import "BSKUtils.h"
@interface BSKViewPagerStatusModel : NSObject
@property (assign, nonatomic) BSKViewPagerItemStatus status;
@property (assign, nonatomic) BOOL selected;
@property (copy, nonatomic) NSString * title;
@property (assign, nonatomic) BOOL canChangeStstus;
@end

@implementation BSKViewPagerStatusModel

-(void)setSelected:(BOOL)selected{
    _selected = selected;
    if (self.canChangeStstus) {
        if (selected) {
           if (self.status!=BSKViewPagerItemStatusUp) {
               self.status = BSKViewPagerItemStatusUp;
           }else{
               self.status = BSKViewPagerItemStatusDown;
           }
        }else{
            self.status = BSKViewPagerItemStatusNormal;
        }
    }
}

@end

@interface BSKViewPager()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) UICollectionView * buttonCollectionView;
@property (strong, nonatomic) UIView * lineView;
@property (strong, nonatomic) BSKViewPagerFlowLayout  *layout;
@property (strong, nonatomic) NSMutableArray<BSKViewPagerStatusModel *>* statusArray;
@property (strong, nonatomic) NSMutableDictionary * itemSize;
@end
@implementation BSKViewPager

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeViewPager];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initializeViewPager];
    }
    return self;
}
-(void)initializeViewPager
{
    self.imageWidth = 14;
    _padingLeftAndRight = 0;
    [self setCurentSelectedIndex:0];
    _tintColor = [UIColor darkTextColor];
    _selectedTintColor = [UIColor blueColor];
    _titleFont = [UIFont systemFontOfSize:18];
    _titles = @[];
    _showBootomLine = YES;
    _lineView = [[UIView alloc] init];
    _minimumItemWidth = 30;
    _showImageOnRight = NO;
    _itemAlignMode = BSKViewPagerItemAlignModeAverage;
    self.imageForStatusUp = [UIImage imageNamed:@"BSK_升序"];
    self.imageForStatusDown = [UIImage imageNamed:@"BSK_降序"];
    self.imageForStatusNormale = [UIImage imageNamed:@"BSK_默认"];
    self.rectView = [[UIView alloc]initWithFrame:CGRectMake(0,0,0,0)];
    self.lineView.backgroundColor = self.selectedTintColor;
    self.rectView.backgroundColor = self.selectedTintColor;
    self.userInteractionEnabled = YES;
    [self addSubview:self.buttonCollectionView];
    [self addSubview:self.lineView];
    [self.buttonCollectionView addSubview:self.rectView];
    self.buttonCollectionView.allowsSelection = YES;
    self.buttonCollectionView.allowsMultipleSelection = NO;
    [self setNeedsLayout];
    
#if TARGET_INTERFACE_BUILDER
    self.backgroundColor = [UIColor redColor];
    self.titles = @[@"item",@"item2",@"item3"];
#endif
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.lineView.frame = CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1);
    self.buttonCollectionView.frame = CGRectMake(self.padingLeftAndRight, 0, self.bounds.size.width-2*self.padingLeftAndRight, self.bounds.size.height);
}

#pragma mark - UICollectionViewDataSource,UICollectionViewDelegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.statusArray.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    BSKViewPagerStatusModel * status = self.statusArray[indexPath.row];
    if([self.delegate respondsToSelector:@selector(ViewPager:canChangeStatusAtIndex:)]){
        status.canChangeStstus = [self.delegate ViewPager:self canChangeStatusAtIndex:indexPath.row];
    }else{
        status.canChangeStstus = NO;
    }
    if (self.delegate&&[self.delegate respondsToSelector:@selector(ViewPager:widthForItemAtIndex:)]) {
        CGFloat wihth = [self.delegate ViewPager:self widthForItemAtIndex:indexPath.row];
        CGSize size = CGSizeMake(wihth>_minimumItemWidth?wihth:_minimumItemWidth, self.bounds.size.height);
        self.itemSize[BSKIntToStr(indexPath.row)] = NSStringFromCGSize(size);
        return size;
    }
    else{
        NSString * text = self.statusArray[indexPath.row].title;
        CGSize recSize = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleFont} context:nil].size;
        if (self.statusArray[indexPath.row].canChangeStstus) {
            CGSize size = CGSizeMake(recSize.width+self.imageWidth+20, self.bounds.size.height);
            self.itemSize[BSKIntToStr(indexPath.row)] = NSStringFromCGSize(size);
            return size;
        }
        
        CGSize size = CGSizeMake(recSize.width+10, self.bounds.size.height);
        self.itemSize[BSKIntToStr(indexPath.row)] = NSStringFromCGSize(size);
        return size;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BSKViewPagerCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    BSKViewPagerStatusModel * status = self.statusArray[indexPath.row];
    [cell setTitleFont:self.titleFont ];
    cell.selectedTintColor = self.selectedTintColor;
    cell.tintColor         = self.tintColor;
    cell.imageForNormal    = self.imageForStatusNormale;
    cell.imageForDown      = self.imageForStatusDown;
    cell.imageForUp        = self.imageForStatusUp;
    cell.selected          = status.selected;
    cell.title             = status.title;
    cell.canChangeStatus   = status.canChangeStstus;
    cell.status            = status.status;
    cell.showImageOnRight  = self.showImageOnRight;
    cell.imageWidth        = self.imageWidth;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    BOOL canSelected = YES;
    if (self.delegate&&[self.delegate respondsToSelector:@selector(ViewPager:CanSelectedItemAtIndex:)]) {
        canSelected = [self.delegate ViewPager:self CanSelectedItemAtIndex:indexPath.row];
    }
    if (!canSelected) {
        [collectionView deselectItemAtIndexPath:indexPath animated:YES];
        return;
    }
    self.selectedIndex = indexPath.row;
}

#pragma mark - setter
-(void)setTitles:(NSArray *)titles{
    _titles = titles;
    NSMutableArray<BSKViewPagerStatusModel *> * array = [NSMutableArray array];
    for (NSString * str in titles) {
        BSKViewPagerStatusModel * status = [[BSKViewPagerStatusModel alloc] init];
        status.title                     = str;
        status.status                    = BSKViewPagerItemStatusNormal;
        
        [array addObject:status];
    }
    if (array.count>0) {
        array.firstObject.selected = YES;
    }
    self.statusArray = array;
    [self.buttonCollectionView reloadData];
    [self.buttonCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
}
-(void)setCurentSelectedIndex:(NSInteger)selectedIndex{
    self.selectedIndex = selectedIndex;
}

-(void)reload{
    NSMutableArray<BSKViewPagerStatusModel *> * array = [NSMutableArray array];
    for (NSString * str in self.titles) {
        BSKViewPagerStatusModel * status = [[BSKViewPagerStatusModel alloc] init];
        status.title                     = str;
        status.status                    = BSKViewPagerItemStatusNormal;
        
        [array addObject:status];
    }
    if (array.count>self.selectedIndex) {
        array[self.selectedIndex].selected = YES;
    }else if(array.count>0){
        _selectedIndex = 0;
    }
    self.statusArray = array;
    [self.layout invalidateLayout];
    [self.buttonCollectionView reloadData];
    self.selectedIndex = self.selectedIndex;//为了更新选中index的"canChangeStstus";
}

-(void)setSelectedIndex:(NSInteger)selectedIndex{
    
    if (!(selectedIndex<self.titles.count)) {
        return ;
    }
    BSKViewPagerStatusModel * status = self.statusArray[selectedIndex];
    if([self.delegate respondsToSelector:@selector(ViewPager:canChangeStatusAtIndex:)]){
        status.canChangeStstus = [self.delegate ViewPager:self canChangeStatusAtIndex:selectedIndex];
    }else{
        status.canChangeStstus = NO;
    }
    if (selectedIndex!=_selectedIndex) {
        for ( BSKViewPagerStatusModel * status in self.statusArray) {
            if (status.selected) {
                status.selected = NO;
            }
        }
    }
    self.statusArray[selectedIndex].selected = YES;
    _selectedIndex = selectedIndex;
    
    if ([self.buttonCollectionView indexPathsForSelectedItems].count==0||[self.buttonCollectionView indexPathsForSelectedItems].firstObject.row!=selectedIndex) {
        [self.buttonCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:selectedIndex inSection:0] animated:YES scrollPosition:self.autoScrollToCenter?UICollectionViewScrollPositionCenteredHorizontally:UICollectionViewScrollPositionNone];
    }else{
        [self.buttonCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:selectedIndex inSection:0] atScrollPosition:self.autoScrollToCenter?UICollectionViewScrollPositionCenteredHorizontally:UICollectionViewScrollPositionNone animated:YES];
    }
    [self.layout invalidateLayout];
    [[self buttonCollectionView] reloadData];
    if (self.delegate&&[self.delegate respondsToSelector:@selector(ViewPager:didSelectedItemAtIndex:withStatus:)]) {
        [self.delegate ViewPager:self didSelectedItemAtIndex:selectedIndex withStatus:self.statusArray[selectedIndex].status];
    }else if (self.delegate&&[self.delegate respondsToSelector:@selector(ViewPager:didSelectedItemAtIndex:)]) {
        [self.delegate ViewPager:self didSelectedItemAtIndex:selectedIndex];
    }
}


-(void)setTintColor:(UIColor *)tintColor{
    _tintColor = tintColor;
    [self.buttonCollectionView reloadData];
}

-(void)setTitleFont:(UIFont *)titleFont{
    _titleFont = titleFont;
    [self.buttonCollectionView reloadData];
}

-(void)setSelectedTintColor:(UIColor *)selectedTintColor{
    _selectedTintColor = selectedTintColor;
    self.rectView.backgroundColor = selectedTintColor;
    if (!self.bottomLineColor) {
       self.lineView.backgroundColor = selectedTintColor;
    }
}

-(void)setBottomLineColor:(UIColor *)bottomLineColor{
    _bottomLineColor = bottomLineColor;
    self.lineView.backgroundColor = self.bottomLineColor;
}

-(void)setPadingLeftAndRight:(CGFloat)padingLeftAndRight{
    _padingLeftAndRight = padingLeftAndRight;
    [self setNeedsLayout];
}

#pragma mark - setter

-(void)setItemAlignMode:(BSKViewPagerItemAlignMode)itemAlignMode{
    _itemAlignMode = itemAlignMode;
    self.layout.itemAlignMode = itemAlignMode;
}

-(void)setDelegate:(id<BSKViewPagerDelegate>)delegate{
    _delegate = delegate;
    self.selectedIndex = self.selectedIndex;//为了更新选中index的"canChangeStstus";
    [self.buttonCollectionView reloadData];
}

#pragma mark - getter

-(UICollectionView *)buttonCollectionView{
    if (!_buttonCollectionView) {
        
        _buttonCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.layout];
        self.layout.pager = self;
        _buttonCollectionView.bounces = NO;
        _buttonCollectionView.delegate = self;
        _buttonCollectionView.dataSource = self;
        _buttonCollectionView.backgroundColor = [UIColor clearColor];
        _buttonCollectionView.showsHorizontalScrollIndicator = NO;
        _buttonCollectionView.allowsMultipleSelection = NO;
        [_buttonCollectionView registerNib:[UINib nibWithNibName:@"BSKViewPagerCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"cell"];
    }
    return _buttonCollectionView;
}

-(BSKViewPagerFlowLayout *)layout{
    if (!_layout) {
        _layout = [[BSKViewPagerFlowLayout alloc] init];
        _layout.itemAlignMode = self.itemAlignMode;
        _layout.minimumLineSpacing = 0;
        _layout.minimumInteritemSpacing = 0;
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _layout;
}

-(void)setShowBootomLine:(BOOL)showBootomLine{
    _showBootomLine = showBootomLine;
    self.lineView.hidden = !showBootomLine;
}

@end
