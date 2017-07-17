//
//  BSKDrawerViewController.m
//  侧边栏
//
//  Created by 刘万林 on 2016/12/17.
//  Copyright © 2016年 刘万林. All rights reserved.
//


#import "BSKDrawerViewController.h"
@interface BSKDrawerViewController ()<UIGestureRecognizerDelegate>
@property (strong, nonatomic) UIPanGestureRecognizer * drawerPanGesture;
@property (strong, nonatomic) UITapGestureRecognizer * closeDrawerTapGesture;
@property (assign, nonatomic) CGFloat openDrawerProgress;
@property (strong, nonatomic) UIView * centerMaskView;
@end

@implementation BSKDrawerViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initializeSelf];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initializeSelf];
    }
    return self;
}

/**
 初始化
 */
- (void)initializeSelf{
    _canOpenDrawer=YES;
    _animationMode = BSKDrawerAnimationDynamicUncover;
    _drawerWidth = -947818238;
    _showShadow = YES;
    _darkenCenterViewController = YES;
    _animationDurationTime = 0.2;
    _frameToRespondOpenGesture = CGRectZero;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    self.drawerPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(drawerPanAction:)];
    self.drawerPanGesture.delegate = self;
    [self.view addGestureRecognizer:self.drawerPanGesture];
    
    self.centerMaskView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.centerMaskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.closeDrawerTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeDrawerTapAction:)];
    [self.centerMaskView addGestureRecognizer:self.closeDrawerTapGesture];
}

-(void)closeDrawerTapAction:(UITapGestureRecognizer *)tap{
    [self closeDrawer];
}

-(void)drawerPanAction:(UIPanGestureRecognizer * )panGesture{
    switch (self.animationMode) {
        case BSKDrawerAnimationCover:
        {
            [self coverAnimationWithGesture:panGesture];
        }
            break;
        case BSKDrawerAnimationPush:
        {
            [self pushAnimationWithGesture:panGesture];
        }
            break;
        case BSKDrawerAnimationDynamicUncover:
        {
            [self dynamicUncoverAnimationWithGesture:panGesture];
        }
            break;
        case BSKDrawerAnimationStaticUncover:
        {
            [self staticUncoverAnimationWithGesture:panGesture];
        }
            break;
        default:
            break;
    }
}



/**
 打开抽屉
 */

-(void)openDrawer{
    [self openDrawerWithComplate:nil];
}

-(void)closeDrawer{
    [self closeDrawerWithComplate:nil];
}

-(void)openDrawerWithComplate:(void(^)(BOOL isDrawerOpen))complate{
    switch (self.animationMode) {
        case BSKDrawerAnimationCover:
        {
            
            if (self.showShadow) {
                self.leftViewController.view.layer.shadowColor = [UIColor blackColor].CGColor;
                self.leftViewController.view.layer.shadowOpacity = 0.5;
                self.leftViewController.view.layer.shadowOffset = CGSizeMake(3, 0);
                self.leftViewController.view.layer.shadowRadius = 7;
            }else{
                self.leftViewController.view.layer.shadowColor = [UIColor clearColor].CGColor;
            }
            self.centerViewController.view.layer.shadowColor = [UIColor clearColor].CGColor;
            
            if(!self.isDrawerOpen){
                [self.view addSubview:self.centerMaskView];
                self.centerMaskView.alpha = 0.02;
                self.leftViewController.view.frame = CGRectMake(-1*(self.drawerWidth+10), 0, self.drawerWidth, self.view.bounds.size.height);
                [self.view addSubview:self.leftViewController.view];
            }
            [self coverAnimationOpenComplate:complate];
        }
            break;
        case BSKDrawerAnimationPush:
        {
            
            if (self.showShadow) {
                self.centerViewController.view.layer.shadowColor = [UIColor blackColor].CGColor;
                self.centerViewController.view.layer.shadowOpacity = 0.5;
                self.centerViewController.view.layer.shadowOffset = CGSizeMake(-3, 0);
                self.centerViewController.view.layer.shadowRadius = 7;
            }else{
                self.centerViewController.view.layer.shadowColor = [UIColor clearColor].CGColor;
            }
            self.leftViewController.view.layer.shadowColor = [UIColor clearColor].CGColor;
            
            if(!self.isDrawerOpen){
                
                [self.view addSubview:self.centerMaskView];
                self.centerMaskView.alpha = 0.02;
                self.leftViewController.view.frame = CGRectMake(-1*(self.drawerWidth), 0, self.drawerWidth, self.view.bounds.size.height);
                [self.view insertSubview:self.leftViewController.view belowSubview:self.centerViewController.view];
            }
            [self pushAnimationOpenComplate:complate];
        }
            break;
        case BSKDrawerAnimationDynamicUncover:
        {
            
            if (self.showShadow) {
                self.centerViewController.view.layer.shadowColor = [UIColor blackColor].CGColor;
                self.centerViewController.view.layer.shadowOpacity = 0.5;
                self.centerViewController.view.layer.shadowOffset = CGSizeMake(-3, 0);
                self.centerViewController.view.layer.shadowRadius = 7;
            }else{
                self.centerViewController.view.layer.shadowColor = [UIColor clearColor].CGColor;
            }
            self.leftViewController.view.layer.shadowColor = [UIColor clearColor].CGColor;
            
            if(!self.isDrawerOpen){
                
                [self.view addSubview:self.centerMaskView];
                self.centerMaskView.alpha = 0.02;
                self.leftViewController.view.frame = CGRectMake(-0.5*(self.drawerWidth), 0, self.drawerWidth, self.view.bounds.size.height);
                [self.view insertSubview:self.leftViewController.view belowSubview:self.centerViewController.view];
            }
            [self dynamicUncoverAnimationOpenComplate:complate];
        }
            break;
            
        case BSKDrawerAnimationStaticUncover:
        {
            
            if (self.showShadow) {
                self.centerViewController.view.layer.shadowColor = [UIColor blackColor].CGColor;
                self.centerViewController.view.layer.shadowOpacity = 0.5;
                self.centerViewController.view.layer.shadowOffset = CGSizeMake(-3, 0);
                self.centerViewController.view.layer.shadowRadius = 7;
            }else{
                self.centerViewController.view.layer.shadowColor = [UIColor clearColor].CGColor;
            }
            self.leftViewController.view.layer.shadowColor = [UIColor clearColor].CGColor;
            
            if(!self.isDrawerOpen){
                
                [self.view addSubview:self.centerMaskView];
                self.centerMaskView.alpha = 0.02;
                self.leftViewController.view.frame = CGRectMake(0, 0, self.drawerWidth, self.view.bounds.size.height);
                [self.view insertSubview:self.leftViewController.view belowSubview:self.centerViewController.view];
            }
            [self dynamicUncoverAnimationOpenComplate:complate];
        }
            break;
            
        default:
            break;
    }
}

-(void)closeDrawerWithComplate:(void(^)(BOOL isDrawerOpen))complate{
    switch (self.animationMode) {
        case BSKDrawerAnimationCover:
        {
            [self coverAnimationCloseComplate:complate];
        }
            break;
            
        case BSKDrawerAnimationPush:
        {
            [self pushAnimationCloseComplate:complate];
        }
            break;
            
        case BSKDrawerAnimationDynamicUncover:
        {
            [self dynamicUncoverAnimationCloseComplate:complate];
        }
            break;
        case BSKDrawerAnimationStaticUncover:
        {
            [self staticUncoverAnimationCloseComplate:complate];
        }
            break;
        default:
            break;
    }
}

#pragma mark -  BSKDrawerAnimations

#pragma mark BSKDrawerAnimationPush


-(void)pushAnimationOpenComplate:(void(^)(BOOL isDrawerOpen))complate{
    
    [UIView animateWithDuration:_animationDurationTime delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.leftViewController.view.frame = CGRectMake(0, 0,self.drawerWidth, self.view.bounds.size.height);
        self.centerViewController.view.frame = CGRectMake(self.drawerWidth, 0, self.centerViewController.view.frame.size.width, self.centerViewController.view.frame.size.height);
        self.centerMaskView.frame = self.centerViewController.view.frame;
        if(self.darkenCenterViewController){
            self.centerMaskView.alpha = 1;
        }
        
    } completion:^(BOOL finished) {
        self.isDrawerOpen = YES;
        if (complate) {
            complate(self.isDrawerOpen);
        }
    }];
}


-(void)pushAnimationCloseComplate:(void(^)(BOOL isDrawerOpen))complate{
    
    
    [UIView animateWithDuration:_animationDurationTime delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.leftViewController.view.frame = CGRectMake(-1*(self.drawerWidth), 0,self.drawerWidth, self.view.bounds.size.height);
        self.centerMaskView.alpha = 0;
        self.centerViewController.view.frame = CGRectMake(0, 0, self.centerViewController.view.frame.size.width, self.centerViewController.view.frame.size.height);
        self.centerMaskView.frame = self.centerViewController.view.frame;
    } completion:^(BOOL finished) {
        self.isDrawerOpen = NO;
        [self.leftViewController.view removeFromSuperview];
        [self.centerMaskView removeFromSuperview];
        if (complate) {
            complate(self.isDrawerOpen);
        }
    }];
    
}


-(void)pushAnimationWithGesture:(UIPanGestureRecognizer *)panGesture{
    if (!self.leftViewController) {
        return;
    }
    CGPoint p = [panGesture translationInView:self.view];
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            if (self.showShadow) {
                self.centerViewController.view.layer.shadowColor = [UIColor blackColor].CGColor;
                self.centerViewController.view.layer.shadowOpacity = 0.5;
                self.centerViewController.view.layer.shadowOffset = CGSizeMake(-3, 0);
                self.centerViewController.view.layer.shadowRadius = 7;
            }else{
                self.centerViewController.view.layer.shadowColor = [UIColor clearColor].CGColor;
            }
            
            self.leftViewController.view.layer.shadowColor = [UIColor clearColor].CGColor;
            
            if(!self.isDrawerOpen&&p.x>0){
                NSLog(@"addd");
                [self.view addSubview:self.centerMaskView];
                self.centerMaskView.alpha = 0.02;
                self.leftViewController.view.frame = CGRectMake(-1*(self.drawerWidth), 0, self.drawerWidth, self.view.bounds.size.height);
                [self.view insertSubview:self.leftViewController.view belowSubview:self.centerViewController.view];
                
            }
        }
            break;
        case UIGestureRecognizerStateChanged:{
            if(!self.isDrawerOpen&&p.x>0){
                if(![self.view.subviews containsObject:self.leftViewController.view]){
                    self.leftViewController.view.frame = CGRectMake(-1*(self.drawerWidth), 0, self.drawerWidth, self.view.bounds.size.height);
                    [self.view insertSubview:self.leftViewController.view belowSubview:self.centerViewController.view];
                }
                if(![self.view.subviews containsObject:self.centerMaskView]){
                    self.centerMaskView.alpha = 0.02;
                    [self.view addSubview:self.centerMaskView];
                }
            }
            
            if (!self.isDrawerOpen) {
                CGFloat x =MIN(-1*(self.drawerWidth)+p.x,0);
                self.leftViewController.view.frame = CGRectMake(x, 0,self.drawerWidth, self.view.bounds.size.height);
                self.centerViewController.view.frame = CGRectMake(MAX(MIN(p.x,self.drawerWidth),0), 0, self.centerViewController.view.frame.size.width, self.centerViewController.view.frame.size.height);
                self.centerMaskView.frame = self.centerViewController.view.frame;
                self.openDrawerProgress = 1-(x/(-1*self.drawerWidth));
            }else{
                CGFloat x =MAX(MIN(p.x,0),-1*(self.drawerWidth));
                self.leftViewController.view.frame = CGRectMake(x, 0,self.drawerWidth, self.view.bounds.size.height);
                self.centerViewController.view.frame = CGRectMake(MIN(MAX(self.drawerWidth+p.x,0),self.drawerWidth), 0, self.centerViewController.view.frame.size.width, self.centerViewController.view.frame.size.height);
                self.centerMaskView.frame = self.centerViewController.view.frame;
                self.openDrawerProgress =1 - (x/(-1*self.drawerWidth));
                
            }
            if(self.darkenCenterViewController){
                self.centerMaskView.alpha = self.openDrawerProgress;
            }
        }
            break;
        default:
        { CGFloat flag = 0.7f;
            if (!self.isDrawerOpen) {
                flag = 0.3f;
            }
            if (self.openDrawerProgress>flag) {
                //如果进度大于flag就打开抽屉
                [self pushAnimationOpenComplate:nil];
            }else{
                [self pushAnimationCloseComplate:nil];
            }
        }
            break;
    }
}


#pragma mark BSKDrawerAnimationCover

-(void)coverAnimationOpenComplate:(void(^)(BOOL isDrawerOpen))complate{
    [UIView animateWithDuration:_animationDurationTime delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.leftViewController.view.frame = CGRectMake(0, 0,self.drawerWidth, self.view.bounds.size.height);
        
        if(self.darkenCenterViewController){
            self.centerMaskView.alpha = 1;
        }
        
    } completion:^(BOOL finished) {
        self.isDrawerOpen = YES;
        if (complate) {
            complate(self.isDrawerOpen);
        }
    }];
}


-(void)coverAnimationCloseComplate:(void(^)(BOOL isDrawerOpen))complate{
    
    [UIView animateWithDuration:_animationDurationTime delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.leftViewController.view.frame = CGRectMake(-1*(self.drawerWidth+10), 0,self.drawerWidth, self.view.bounds.size.height);
        self.centerMaskView.alpha = 0;
        
    } completion:^(BOOL finished) {
        self.isDrawerOpen = NO;
        [self.leftViewController.view removeFromSuperview];
        [self.centerMaskView removeFromSuperview];
        if (complate) {
            complate(self.isDrawerOpen);
        }
    }];
}


-(void)coverAnimationWithGesture:(UIPanGestureRecognizer *)panGesture{
    if (!self.leftViewController) {
        return;
    }
    
    CGPoint p = [panGesture translationInView:self.view];
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            
            if (self.showShadow) {
                self.leftViewController.view.layer.shadowColor = [UIColor blackColor].CGColor;
                self.leftViewController.view.layer.shadowOpacity = 0.5;
                self.leftViewController.view.layer.shadowOffset = CGSizeMake(3, 0);
                self.leftViewController.view.layer.shadowRadius = 7;
            }else{
                self.leftViewController.view.layer.shadowColor = [UIColor clearColor].CGColor;
            }
            self.centerViewController.view.layer.shadowColor = [UIColor clearColor].CGColor;
            
            if(!self.isDrawerOpen&&p.x>0){
                
                [self.view addSubview:self.centerMaskView];
                self.centerMaskView.alpha = 0.02;
                self.leftViewController.view.frame = CGRectMake(-1*(self.drawerWidth+10), 0, self.drawerWidth, self.view.bounds.size.height);
                [self.view addSubview:self.leftViewController.view];
            }
        }
            break;
        case UIGestureRecognizerStateChanged:{
            if(!self.isDrawerOpen&&p.x>0){
                if(![self.view.subviews containsObject:self.centerMaskView]){
                    self.centerMaskView.alpha = 0.02;
                    [self.view addSubview:self.centerMaskView];
                }
                if(![self.view.subviews containsObject:self.leftViewController.view]){
                    self.leftViewController.view.frame = CGRectMake(-1*(self.drawerWidth+10), 0, self.drawerWidth, self.view.bounds.size.height);
                    [self.view addSubview:self.leftViewController.view];
                }
            }
            if (!self.isDrawerOpen) {
                CGFloat x =MIN(-1*(self.drawerWidth+10)+p.x,0);
                self.leftViewController.view.frame = CGRectMake(x, 0,self.drawerWidth, self.view.bounds.size.height);
                self.openDrawerProgress = 1-(x/(-1*self.drawerWidth));
                
            }else{
                CGFloat x =MAX(MIN(p.x,0),-1*(self.drawerWidth+10));
                self.leftViewController.view.frame = CGRectMake(x, 0,self.drawerWidth, self.view.bounds.size.height);
                self.openDrawerProgress =1 - (x/(-1*self.drawerWidth));
                
            }
            if(self.darkenCenterViewController){
                self.centerMaskView.alpha = self.openDrawerProgress;
            }
        }
            break;
        case UIGestureRecognizerStateEnded:{
            CGFloat flag = 0.7f;
            if (!self.isDrawerOpen) {
                flag = 0.3f;
            }
            if (self.openDrawerProgress>flag) {
                //如果进度大于flag就打开抽屉
                [self coverAnimationOpenComplate:nil];
                break;
            }
        }
        default:
        {
            [self coverAnimationCloseComplate:nil];
        }
            break;
    }
}

#pragma mark BSKDrawerAnimationDynamicUncover

-(void)dynamicUncoverAnimationOpenComplate:(void(^)(BOOL isDrawerOpen))complate{
    
    
    [UIView animateWithDuration:_animationDurationTime delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.leftViewController.view.frame = CGRectMake(0, 0,self.drawerWidth, self.view.bounds.size.height);
        self.centerViewController.view.frame = CGRectMake(self.drawerWidth, 0, self.centerViewController.view.frame.size.width, self.centerViewController.view.frame.size.height);
        self.centerMaskView.frame = self.centerViewController.view.frame;
        if(self.darkenCenterViewController){
            self.centerMaskView.alpha = 1;
        }
    } completion:^(BOOL finished) {
        self.isDrawerOpen = YES;
        if (complate) {
            complate(self.isDrawerOpen);
        }
    }];
}


-(void)dynamicUncoverAnimationCloseComplate:(void(^)(BOOL isDrawerOpen))complate{
    
    [UIView animateWithDuration:_animationDurationTime delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.leftViewController.view.frame = CGRectMake(-0.5*(self.drawerWidth), 0,self.drawerWidth, self.view.bounds.size.height);
        self.centerMaskView.alpha = 0;
        self.centerViewController.view.frame = CGRectMake(0, 0, self.centerViewController.view.frame.size.width, self.centerViewController.view.frame.size.height);
        self.centerMaskView.frame = self.centerViewController.view.frame;
        
    } completion:^(BOOL finished) {
        self.isDrawerOpen = NO;
        [self.leftViewController.view removeFromSuperview];
        [self.centerMaskView removeFromSuperview];
        if (complate) {
            complate(self.isDrawerOpen);
        }
    }];
}


-(void)dynamicUncoverAnimationWithGesture:(UIPanGestureRecognizer *)panGesture{
    if (!self.leftViewController) {
        return;
    }
    
    CGPoint p = [panGesture translationInView:self.view];
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            if (self.showShadow) {
                self.centerViewController.view.layer.shadowColor = [UIColor blackColor].CGColor;
                self.centerViewController.view.layer.shadowOpacity = 0.5;
                self.centerViewController.view.layer.shadowOffset = CGSizeMake(-3, 0);
                self.centerViewController.view.layer.shadowRadius = 7;
            }else{
                self.centerViewController.view.layer.shadowColor = [UIColor clearColor].CGColor;
            }
            
            self.leftViewController.view.layer.shadowColor = [UIColor clearColor].CGColor;
            
            if(!self.isDrawerOpen&&p.x>0){
                
                [self.view addSubview:self.centerMaskView];
                self.centerMaskView.alpha = 0.02;
                self.leftViewController.view.frame = CGRectMake(-0.5*(self.drawerWidth), 0, self.drawerWidth, self.view.bounds.size.height);
                [self.view insertSubview:self.leftViewController.view belowSubview:self.centerViewController.view];
            }
        }
            break;
        case UIGestureRecognizerStateChanged:{
            if(!self.isDrawerOpen&&p.x>0){
                if(![self.view.subviews containsObject:self.leftViewController.view]){
                    self.leftViewController.view.frame = CGRectMake(-1*(self.drawerWidth), 0, self.drawerWidth, self.view.bounds.size.height);
                    [self.view insertSubview:self.leftViewController.view belowSubview:self.centerViewController.view];
                }
                if(![self.view.subviews containsObject:self.centerMaskView]){
                    self.centerMaskView.alpha = 0.02;
                    [self.view addSubview:self.centerMaskView];
                }
            }
            if (!self.isDrawerOpen) {
                CGFloat x =MIN(-1*(self.drawerWidth)+p.x,0);
                self.openDrawerProgress = 1-(x/(-1*self.drawerWidth));
                
                self.leftViewController.view.frame = CGRectMake(-0.5*(self.drawerWidth)+0.5*(self.drawerWidth)*self.openDrawerProgress, 0,self.drawerWidth, self.view.bounds.size.height);
                self.centerViewController.view.frame = CGRectMake(MAX(MIN(p.x,self.drawerWidth),0), 0, self.centerViewController.view.frame.size.width, self.centerViewController.view.frame.size.height);
                self.centerMaskView.frame = self.centerViewController.view.frame;
            }else{
                CGFloat x =MAX(MIN(p.x,0),-1*(self.drawerWidth));
                self.openDrawerProgress =1 - (x/(-1*self.drawerWidth));
                self.leftViewController.view.frame = CGRectMake(-0.5*(self.drawerWidth)+0.5*(self.drawerWidth)*self.openDrawerProgress, 0,self.drawerWidth, self.view.bounds.size.height);
                self.centerViewController.view.frame = CGRectMake(MIN(MAX(self.drawerWidth+p.x,0),self.drawerWidth), 0, self.centerViewController.view.frame.size.width, self.centerViewController.view.frame.size.height);
                self.centerMaskView.frame = self.centerViewController.view.frame;
                
            }
            if(self.darkenCenterViewController){
                self.centerMaskView.alpha = self.openDrawerProgress;
            }
        }
            break;
        case UIGestureRecognizerStateEnded:{
            CGFloat flag = 0.7f;
            if (!self.isDrawerOpen) {
                flag = 0.3f;
            }
            if (self.openDrawerProgress>flag) {
                //如果进度大于flag就打开抽屉
                [self dynamicUncoverAnimationOpenComplate:nil];
                break;
            }
        }
        default:
        {
            [self dynamicUncoverAnimationCloseComplate:nil];
        }
            break;
    }
}

#pragma mark BSKDrawerAnimationStaticUncover


-(void)staticUncoverAnimationOpenComplate:(void(^)(BOOL isDrawerOpen))complate{
    
    
    [UIView animateWithDuration:_animationDurationTime delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.centerViewController.view.frame = CGRectMake(self.drawerWidth, 0, self.centerViewController.view.frame.size.width, self.centerViewController.view.frame.size.height);
        self.centerMaskView.frame = self.centerViewController.view.frame;
        if(self.darkenCenterViewController){
            self.centerMaskView.alpha = 1;
        }
    } completion:^(BOOL finished) {
        self.isDrawerOpen = YES;
        if (complate) {
            complate(self.isDrawerOpen);
        }
    }];
}


-(void)staticUncoverAnimationCloseComplate:(void(^)(BOOL isDrawerOpen))complate{
    
    [UIView animateWithDuration:_animationDurationTime delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.centerMaskView.alpha = 0;
        self.centerViewController.view.frame = CGRectMake(0, 0, self.centerViewController.view.frame.size.width, self.centerViewController.view.frame.size.height);
        self.centerMaskView.frame = self.centerViewController.view.frame;
        
    } completion:^(BOOL finished) {
        self.isDrawerOpen = NO;
        [self.leftViewController.view removeFromSuperview];
        [self.centerMaskView removeFromSuperview];
        if (complate) {
            complate(self.isDrawerOpen);
        }
    }];
}


-(void)staticUncoverAnimationWithGesture:(UIPanGestureRecognizer *)panGesture{
    if (!self.leftViewController) {
        return;
    }
    
    CGPoint p = [panGesture translationInView:self.view];
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            if (self.showShadow) {
                self.centerViewController.view.layer.shadowColor = [UIColor blackColor].CGColor;
                self.centerViewController.view.layer.shadowOpacity = 0.5;
                self.centerViewController.view.layer.shadowOffset = CGSizeMake(-3, 0);
                self.centerViewController.view.layer.shadowRadius = 7;
            }else{
                self.centerViewController.view.layer.shadowColor = [UIColor clearColor].CGColor;
            }
            
            self.leftViewController.view.layer.shadowColor = [UIColor clearColor].CGColor;
            
            if(!self.isDrawerOpen&&p.x>0){
                
                [self.view addSubview:self.centerMaskView];
                self.centerMaskView.alpha = 0.02;
                self.leftViewController.view.frame = CGRectMake(0, 0, self.drawerWidth, self.view.bounds.size.height);
                [self.view insertSubview:self.leftViewController.view belowSubview:self.centerViewController.view];
            }
        }
            break;
        case UIGestureRecognizerStateChanged:{
            if(!self.isDrawerOpen&&p.x>0){
                if(![self.view.subviews containsObject:self.leftViewController.view]){
                    self.leftViewController.view.frame = CGRectMake(0, 0, self.drawerWidth, self.view.bounds.size.height);
                    [self.view insertSubview:self.leftViewController.view belowSubview:self.centerViewController.view];
                }
                if(![self.view.subviews containsObject:self.centerMaskView]){
                    self.centerMaskView.alpha = 0.02;
                    [self.view addSubview:self.centerMaskView];
                }
            }
            if (!self.isDrawerOpen) {
                CGFloat x =MIN(-1*(self.drawerWidth)+p.x,0);
                self.openDrawerProgress = 1-(x/(-1*self.drawerWidth));
                
                self.centerViewController.view.frame = CGRectMake(MAX(MIN(p.x,self.drawerWidth),0), 0, self.centerViewController.view.frame.size.width, self.centerViewController.view.frame.size.height);
                self.centerMaskView.frame = self.centerViewController.view.frame;
            }else{
                CGFloat x =MAX(MIN(p.x,0),-1*(self.drawerWidth));
                self.openDrawerProgress =1 - (x/(-1*self.drawerWidth));
                self.centerViewController.view.frame = CGRectMake(MIN(MAX(self.drawerWidth+p.x,0),self.drawerWidth), 0, self.centerViewController.view.frame.size.width, self.centerViewController.view.frame.size.height);
                self.centerMaskView.frame = self.centerViewController.view.frame;
                
            }
            if(self.darkenCenterViewController){
                self.centerMaskView.alpha = self.openDrawerProgress;
            }
        }
            break;
        case UIGestureRecognizerStateEnded:{
            CGFloat flag = 0.7f;
            if (!self.isDrawerOpen) {
                flag = 0.3f;
            }
            if (self.openDrawerProgress>flag) {
                //如果进度大于flag就打开抽屉
                [self staticUncoverAnimationOpenComplate:nil];
                break;
            }
        }
        default:
        {
            [self staticUncoverAnimationCloseComplate:nil];
        }
            break;
    }
}




#pragma mark - getter

-(CGFloat)drawerWidth{
    if (_drawerWidth == -947818238) {
        _drawerWidth=self.view.bounds.size.width*0.7;
    }
    return _drawerWidth;
}

#pragma mark - setter

-(void)setCenterViewController:(UIViewController *)centerViewController{
    _centerViewController=centerViewController;
    if (_centerViewController) {
        [self addChildViewController:_centerViewController];
        _centerViewController.view.frame = self.view.bounds;
        [self.view addSubview:_centerViewController.view];
    }
}

-(void)setLeftViewController:(UIViewController *)leftViewController{
    _leftViewController = leftViewController;
    if (_leftViewController) {
        [self addChildViewController:_leftViewController];
    }
}

#pragma mark - UIGestureRecognizerDelegate

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    CGPoint p = [touch locationInView:self.view];
    if (!self.isDrawerOpen) {
        if (_canOpenDrawer) {
            if (CGRectEqualToRect(_frameToRespondOpenGesture, CGRectZero)) {
                return YES;
            }else{
                return CGRectContainsPoint(_frameToRespondOpenGesture, p);
            }
        }else{
            return NO;
        }
    }
    else{
        if (CGRectContainsPoint(self.centerMaskView.frame,p) ) {
            return YES;
        }else{
            return NO;
        }
    }
    return self.canOpenDrawer;
}

-(BOOL)shouldAutorotate{
    return [self.centerViewController shouldAutorotate];
}
-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return [self.centerViewController supportedInterfaceOrientations];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer NS_AVAILABLE_IOS(7_0){
    return NO;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer NS_AVAILABLE_IOS(7_0){
    return YES;
}


@end
