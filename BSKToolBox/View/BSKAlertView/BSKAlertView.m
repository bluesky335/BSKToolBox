    //
//  BSKAlertView.m
//  MicroMemory
//
//  Created by rimi on 16/7/21.
//  Copyright © 2016年 BlueSky. All rights reserved.
//

#import "BSKAlertView.h"

@interface BSKAlertView()<UIGestureRecognizerDelegate>
@property (assign, nonatomic) CGFloat fromeScale;
@property (assign, nonatomic) CGPoint ContentViewCenter;
@property (strong, nonatomic) UITapGestureRecognizer * bgTapGesture;
@property (strong, nonatomic) UIPanGestureRecognizer * bgPanGesture;
@property (strong, nonatomic) UIView * bgView;
@property (assign, nonatomic,readwrite) BOOL isShow;
@property (assign, nonatomic) CGFloat topReference;
@property (assign, nonatomic) CGFloat bottomReference;
@property (assign, nonatomic) CGFloat leftReference;
@property (assign, nonatomic) CGFloat rightReference;
@end

@implementation BSKAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
        [self initializeWithFrame:frame];
	}
	return self;
}

-(void)initializeWithFrame:(CGRect)frame{
    self.topReference = 0;
    self.bottomReference = self.frame.size.height;
    self.leftReference =0;
    self.rightReference = self.frame.size.width;
	self.frame = frame;
    self.animatedContentViewAlpha = YES;
    self.responseToAction = YES;
	self.bgView = [[UIView alloc]initWithFrame:self.bounds];
    self.animationTypeWhenShow = BSKAlertViewAnimationTypeSmallToBig;
    self.showBackgroungShadow = YES;
	self.backgroundColor = [UIColor clearColor];
	self.bgView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0];
	[self addSubview:self.bgView];
	self.alpha = 1;
    self.backgroundAlpha = 0.75;
    self.SpringDamping = 1;
    self.SpringVelocity = 0;
    self.animateDuration = 0.25;
    self.animationOptions = UIViewAnimationOptionTransitionNone|UIViewAnimationOptionCurveEaseInOut;
    _bgTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureAction:)];
    _bgTapGesture.delegate = self;
    _bgPanGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureAction:)];
    _bgPanGesture.delegate = self;
    [self.bgView addGestureRecognizer:_bgTapGesture];
    [self.bgView addGestureRecognizer:_bgPanGesture];
}

-(void)show{
    
    if (self.willAppearBlock) {
        self.willAppearBlock(self);
    }
    
    self.hidden = NO;
    self.alpha = 1;
    self.ContentViewCenter = self.contentView.center;
    
    if (self.contentView) {
        self.contentView.transform = CGAffineTransformMakeScale(_fromeScale, _fromeScale);
        if (_animatedContentViewAlpha) {
            self.contentView.alpha = 0;
        }else{
            self.contentView.alpha = 1;
        }
    }
    
    if (self.animationTypeWhenShow == BSKAlertViewAnimationTypeTopToBottom) {
        _contentView.center = CGPointMake(self.ContentViewCenter.x, self.topReference-1*(_contentView.bounds.size.height/2));
    }
    
    if (self.animationTypeWhenShow == BSKAlertViewAnimationTypeFlowTopToBottom) {
        _contentView.center = CGPointMake(self.ContentViewCenter.x, self.ContentViewCenter.y-25);
        self.contentView.alpha = 0;
    }
    
    if (self.animationTypeWhenShow == BSKAlertViewAnimationTypeBottomToTop) {
        _contentView.center = CGPointMake(self.ContentViewCenter.x, self.bottomReference+(_contentView.bounds.size.height/2));
    }
    
    if (self.animationTypeWhenShow == BSKAlertViewAnimationTypeLeftToRight) {
        _contentView.center = CGPointMake( self.leftReference-1*(self.contentView.bounds.size.width/2), self.ContentViewCenter.y);
    }
    
    if (self.animationTypeWhenShow == BSKAlertViewAnimationTypeRightToLeft) {
        _contentView.center = CGPointMake( self.rightReference+(self.contentView.bounds.size.width/2), self.ContentViewCenter.y);
    }
    
    [UIView animateWithDuration:self.animateDuration delay:0 usingSpringWithDamping:self.SpringDamping initialSpringVelocity:self.SpringVelocity options:self.animationOptions animations:^{
        if (self.contentView) {
            self.contentView.transform = CGAffineTransformMakeScale(1, 1);
            self.contentView.center = self.ContentViewCenter;
            if (_showBackgroungShadow) {
                self.bgView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:self.backgroundAlpha];
            }
            self.contentView.alpha = 1;
        }
        
	} completion:^(BOOL finished) {
        if (self.DidAppearBlock) {
            self.DidAppearBlock(self);
        }
        self.isShow = YES;
	}];
}

-(void)hide{
    if (self.willDisappearBlock) {
        self.willDisappearBlock(self);
    }
    if (self.contentView) {
        self.contentView.transform = CGAffineTransformMakeScale(1, 1);
    }
    
    [UIView animateWithDuration:self.animateDuration delay:0 usingSpringWithDamping:0 initialSpringVelocity:0 options:self.animationOptions animations:^{
        if (self.contentView) {
            self.contentView.transform = CGAffineTransformMakeScale(_fromeScale, _fromeScale);
            if (self.animationTypeWhenShow == BSKAlertViewAnimationTypeTopToBottom) {
                _contentView.center = CGPointMake(self.ContentViewCenter.x, self.topReference-1*(_contentView.bounds.size.height/2));
            }
            if (self.animationTypeWhenShow == BSKAlertViewAnimationTypeBottomToTop) {
                _contentView.center = CGPointMake(self.ContentViewCenter.x, self.bottomReference+(_contentView.bounds.size.height/2));
            }
            if (self.animationTypeWhenShow == BSKAlertViewAnimationTypeLeftToRight) {
                _contentView.center = CGPointMake(self.leftReference -1*(self.contentView.bounds.size.width/2), self.ContentViewCenter.y);
            }
            if (self.animationTypeWhenShow == BSKAlertViewAnimationTypeRightToLeft) {
                _contentView.center = CGPointMake( self.rightReference+(self.contentView.bounds.size.width/2), self.ContentViewCenter.y);
            }
            if (self.animationTypeWhenShow == BSKAlertViewAnimationTypeFlowTopToBottom) {
                _contentView.center = CGPointMake(self.ContentViewCenter.x, self.ContentViewCenter.y-25);
                self.contentView.alpha = 0;
            }
            if (_animatedContentViewAlpha) {
                self.contentView.alpha = 0;
            }
        }
        self.bgView.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        self.alpha = 0;
        if (self.DidDisappearBlock) {
            self.DidDisappearBlock(self);
        }
        self.hidden = YES;
        self.isShow = NO;
        self.contentView.center=self.ContentViewCenter;
        [self removeFromSuperview];
    }];
}

-(void)tapGestureAction:(UITapGestureRecognizer *)tap{
    if (!_responseToAction) {
        return;
    }
    [self hide];
}
-(void)panGestureAction:(UIPanGestureRecognizer *)pan{
    if (!_responseToAction) {
        return;
    }
    if (pan.state == UIGestureRecognizerStateBegan) {
        [self hide];
    }
}

#pragma mark - setter

-(void)setMaskToBounds:(BOOL)maskToBounds{
    _maskToBounds = maskToBounds;
    self.layer.masksToBounds = maskToBounds;
}

-(void)setShowBackgroungShadow:(BOOL)showBackgroungShadow{
    _showBackgroungShadow = showBackgroungShadow;
    if (_showBackgroungShadow) {
        self.bgView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:self.backgroundAlpha];
    }else{
        self.bgView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0];
    }
}

-(void)setAnimationTypeWhenShow:(BSKAlertViewAnimationType)animationTypeWhenShow{
    _animationTypeWhenShow = animationTypeWhenShow;
    switch (animationTypeWhenShow) {
        case BSKAlertViewAnimationTypeSmallToBig:
            _fromeScale = 0.01;
            break;
        case BSKAlertViewAnimationTypeBigToSmall:
            _fromeScale = 1.5;
            break;
        default:
            _fromeScale = 1.0;
            break;
    }
}

-(void)setContentView:(UIView *)contentView
{
    _contentView = contentView;
    _ContentViewCenter = _contentView.center;
    if (self.animatedContentViewAlpha) {
        _contentView.alpha = 0;
    }else{
        _contentView.alpha = 1;
    }
    [self addSubview:_contentView];
}

#pragma mark -  UIGestureRecognizerDelegate

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if (gestureRecognizer == self.bgTapGesture||gestureRecognizer == self.bgPanGesture) {
        if (self.contentView) {
            CGPoint p = [touch locationInView:self];
            if (_showBackgroungShadow) {
                 return !CGRectContainsPoint(self.contentView.frame, p);
            }else{
                return NO;
            }
        }else{
            return YES;
        }
    }else{
        return YES;
    }
}

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    if (_showBackgroungShadow) {
        return [super pointInside:point withEvent:event];
    }
    else{
        return CGRectContainsPoint(self.contentView.frame, point);
    }
}

@end
