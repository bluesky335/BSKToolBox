//
//  BSKSwitch.m
//  BSKToolsBoxDemo
//
//  Created by 刘万林 on 2017/8/31.
//  Copyright © 2017年 BlueSky335. All rights reserved.
//

#import "BSKSwitch.h"
#import "UIColor+BSKUtils.h"

@interface BSKSwitch ()

@property (strong, nonatomic) UILabel * onTextLabel;
@property (strong, nonatomic) UILabel * offTextLabel;
@property (strong, nonatomic) UILabel * buttonTextLabel;
@property (strong, nonatomic) UIView * boardView;
@property (strong, nonatomic) UIView * onView;
@property (strong, nonatomic) UIView * offView;
@property (strong, nonatomic) UIView * ButtonView;

@end

@implementation BSKSwitch

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.on=YES;
        [self initialize];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, 70, 30);
//        self.on=YES;
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
        [self initialize];
//        self.on=YES;
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self layoutMyViews];
}

-(void)layoutMyViews{
    [self setCornerRadius:self.CornerRadius];
    self.boardView.frame = self.bounds;
    self.offView.transform = CGAffineTransformIdentity;
    self.offView.frame = CGRectMake(1, 1, self.bounds.size.width-2, self.bounds.size.height-2);
    if (self.isOn) {
        self.offView.transform = CGAffineTransformMakeScale(0.5, 0.5);
        self.ButtonView.frame = CGRectMake(self.bounds.size.width-(self.bounds.size.height-2)-1, 1, self.bounds.size.height-2, self.bounds.size.height-2);
    }else{
        self.ButtonView.frame = CGRectMake(1, 1, self.bounds.size.height-2, self.bounds.size.height-2);
        
    }
    self.onView.frame = CGRectMake(1, 1, (self.ButtonView.frame.origin.x-1+self.ButtonView.bounds.size.width/2), self.bounds.size.height-2);
    
    CGFloat TextWidth = self.boardView.bounds.size.width-self.ButtonView.bounds.size.width-1-self.CornerRadius/2;
    if (_onTextLabel) {
        _onTextLabel.frame = CGRectMake(self.onView.bounds.size.width-self.ButtonView.bounds.size.width/2-TextWidth,0, TextWidth, self.onView.bounds.size.height);
    }
    if (_offTextLabel) {
        _offTextLabel.frame = CGRectMake(self.bounds.size.height-1, 0, TextWidth, self.offView.bounds.size.height);
    }
    if (_buttonTextLabel) {
        _buttonTextLabel.frame = self.ButtonView.bounds;
    }
}

-(void)setColors{
    if (self.isOn) {
        self.boardView.backgroundColor = self.onColor;
        self.onView.backgroundColor = self.onColor;
        self.offView.backgroundColor = self.offColor;
        self.ButtonView.backgroundColor = self.onButtonColor;
        if (_buttonTextLabel) {
             _buttonTextLabel.textColor = self.onButtonTextColor?:self.onColor;
            if (self.buttonText) {
                _buttonTextLabel.text = self.buttonText;
            }
        }
    }else{
        self.boardView.backgroundColor = self.offBorderColor;
        self.onView.backgroundColor = self.offBorderColor;
        self.offView.backgroundColor = self.offColor;
        self.ButtonView.backgroundColor = self.offButtonColor;
        if (_buttonTextLabel) {
            _buttonTextLabel.textColor = self.offButtonTextColor?:self.offBorderColor;
            if (self.buttonText) {
                _buttonTextLabel.text = self.buttonText;
            }
        }
    }
    if (_offTextLabel) {
        _offTextLabel.textColor = self.offTextColor?:self.offBorderColor;
        if (self.offText) {
            _offTextLabel.text = self.offText;
        }
    }
    if (_onTextLabel) {
        _onTextLabel.textColor = self.onTextColor?:self.offColor;
        if (self.onText) {
            _onTextLabel.text = self.onText;
        }
    }
}

-(void)initialize{
    
    self.onColor = [UIColor bsk_ColorWithHex:0x77D672];
    self.offColor = [UIColor whiteColor];
    self.offBorderColor = [UIColor bsk_ColorWithHex:0xE6E6E6];
    self.offButtonColor = [UIColor whiteColor];
    self.onButtonColor = [UIColor whiteColor];
    self.offButtonTextColor = [UIColor lightGrayColor];
    
    [self addSubview:self.boardView];
    [self.boardView addSubview:self.offView];
    [self.boardView addSubview:self.onView];
    [self addSubview:self.ButtonView];
    self.CornerRadius = 15;
    self.buttonText = @"";
    self.onText = @"";
    self.offText = @"";
    
    self.boardView.backgroundColor = self.offBorderColor;
    self.offView.backgroundColor = self.offColor;
    self.onView.backgroundColor = self.offBorderColor;
    self.ButtonView.backgroundColor = self.onButtonColor;
    
    self.ButtonView.layer.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5].CGColor;
    self.ButtonView.layer.shadowOffset = CGSizeMake(0, 0);
    self.ButtonView.layer.shadowRadius = 2;
    self.ButtonView.layer.shadowOpacity = 1;
    
//    self.offView.frame = CGRectMake(1, 1, self.bounds.size.width-2, self.bounds.size.height-2);
    [self layoutMyViews];
    
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tapGesture];
    
    UIPanGestureRecognizer * panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.ButtonView addGestureRecognizer:panGesture];
}


#pragma mark - ● GestureAction

-(void)tapAction:(UITapGestureRecognizer *)gesture{
       self.on = !self.isOn;
}

-(void)panAction:(UIPanGestureRecognizer *)gesture{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        CGPoint center = self.ButtonView.center;
        center.x = [gesture locationInView:self].x;
        if (center.x<self.ButtonView.bounds.size.width/2+1) {
            center.x = self.ButtonView.bounds.size.width/2+1;
        }
        if (center.x>self.bounds.size.width-1-self.ButtonView.bounds.size.width/2) {
            center.x = self.bounds.size.width-1-self.ButtonView.bounds.size.width/2;
        }
        [UIView animateWithDuration:0.25 animations:^{
            self.ButtonView.center = center;
            self.offView.transform = CGAffineTransformIdentity;
            self.onView.frame = CGRectMake(1, 1, (self.ButtonView.frame.origin.x-1+self.ButtonView.bounds.size.width/2), self.bounds.size.height-2);
            CGFloat TextWidth = self.boardView.bounds.size.width-self.ButtonView.bounds.size.width-1-self.CornerRadius/2;
            if (_onTextLabel) {
                _onTextLabel.frame = CGRectMake(self.onView.bounds.size.width-self.ButtonView.bounds.size.width/2-TextWidth,0, TextWidth, self.onView.bounds.size.height);
            }
        }];
    }else if (gesture.state == UIGestureRecognizerStateChanged) {
        CGPoint center = self.ButtonView.center;
        center.x = [gesture locationInView:self].x;
        if (center.x<self.ButtonView.bounds.size.width/2+1) {
            center.x = self.ButtonView.bounds.size.width/2+1;
        }
        if (center.x>self.bounds.size.width-1-self.ButtonView.bounds.size.width/2) {
            center.x = self.bounds.size.width-1-self.ButtonView.bounds.size.width/2;
        }
        self.ButtonView.center = center;
        self.onView.frame = CGRectMake(1, 1, (self.ButtonView.frame.origin.x-1+self.ButtonView.bounds.size.width/2), self.bounds.size.height-2);
        CGFloat TextWidth = self.boardView.bounds.size.width-self.ButtonView.bounds.size.width-1-self.CornerRadius/2;
        if (_onTextLabel) {
            _onTextLabel.frame = CGRectMake(self.onView.bounds.size.width-self.ButtonView.bounds.size.width/2-TextWidth,0, TextWidth, self.onView.bounds.size.height);
        }
    }else {
        self.on = [gesture locationInView:self].x >self.bounds.size.width/2;
    }
}

#pragma mark - ● setter

-(void)setCornerRadius:(CGFloat)CornerRadius{
    _CornerRadius = CornerRadius;
    CGFloat sR = CornerRadius-1>0?CornerRadius-1:0;
    self.boardView.layer.cornerRadius = CornerRadius;
        self.boardView.layer.masksToBounds = YES;
//    self.onView.layer.cornerRadius = sR;
    //    self.onView.layer.masksToBounds = YES;
    self.offView.layer.cornerRadius =sR;
    //    self.offView.layer.masksToBounds = YES;
    self.ButtonView.layer.cornerRadius = CornerRadius;
}



-(void)setOn:(BOOL)on{
    _on = on;
    
#if TARGET_INTERFACE_BUILDER
    [self layoutMyViews];
    [self setColors];
#else
    [UIView animateWithDuration:0.3 animations:^{
        [self layoutMyViews];
        [self setColors];
    }];
#endif
    
}

#pragma mark - ● getter

-(UIView *)boardView{
    if (!_boardView) {
        _boardView = [[UIView alloc] init];
        _boardView.tag = 10001;
    }
    return _boardView;
}

-(UIView *)offView{
    if (!_offView) {
        _offView = [[UIView alloc] init];
        _offView.tag = 10002;
    }
    return _offView;
}

-(UIView *)onView{
    if (!_onView) {
        _onView = [[UIView alloc] init];
        _onView.tag = 10003;
    }
    return _onView;
}
-(UIView *)ButtonView{
    if (!_ButtonView) {
        _ButtonView = [[UIView alloc] init];
        _ButtonView.tag = 10004;
    }
    return _ButtonView;
}

-(UILabel *)onTextLabel{
    if (!_onTextLabel) {
        _onTextLabel = [[UILabel alloc] init];
        [_onView addSubview:_onTextLabel];
        _onTextLabel.font = [UIFont systemFontOfSize:11 weight:UIFontWeightThin];
        _onTextLabel.textAlignment = NSTextAlignmentCenter;
        _onTextLabel.textColor = self.onTextColor?:self.offColor;
    }
    return _onTextLabel;
}

-(UILabel *)offTextLabel{
    if (!_offTextLabel) {
        _offTextLabel = [[UILabel alloc] init];
        [_offView addSubview:_offTextLabel];
        _offTextLabel.font = [UIFont systemFontOfSize:11 weight:UIFontWeightThin];
        _offTextLabel.textAlignment = NSTextAlignmentCenter;
        _offTextLabel.textColor = self.offTextColor?:self.offBorderColor;
    }
    return _offTextLabel;
}

-(UILabel *)buttonTextLabel{
    if (!_buttonTextLabel) {
        _buttonTextLabel = [[UILabel alloc] init];
        [_ButtonView addSubview:_buttonTextLabel];
        _buttonTextLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightThin];
        _buttonTextLabel.textAlignment = NSTextAlignmentCenter;
        if (self.isOn) {
            _buttonTextLabel.textColor = self.onButtonTextColor?:self.onColor;
        }else{
            _buttonTextLabel.textColor = self.offButtonTextColor?:self.offBorderColor;
        }
    }
    return _buttonTextLabel;
}

- (void)setOnText:(NSString *)onText {
    _onText = onText;
    self.onTextLabel.text = onText;
}

- (void)setOffText:(NSString *)offText {
    _offText = offText;
    self.offTextLabel.text = offText;
}

- (void)setButtonText:(NSString *)buttonText {
    _buttonText = buttonText;
    self.buttonTextLabel.text = buttonText;
}

#pragma mark - ● ColorSetter
-(void)setOnColor:(UIColor *)onColor{
    _onColor = onColor;
    [self setColors];
}
-(void)setOffColor:(UIColor *)offColor{
    _offColor = offColor;
    [self setColors];
}
-(void)setOnTextColor:(UIColor *)onTextColor {
    _onTextColor = onTextColor;
    [self setColors];
}
-(void)setOffTextColor:(UIColor *)offTextColor {
    _offTextColor = offTextColor;
    [self setColors];
}
-(void)setOffBorderColor:(UIColor *)offBorderColor{
    _offBorderColor = offBorderColor;
    [self setColors];
}
-(void)setOnButtonColor:(UIColor *)onButtonColor{
    _onButtonColor = onButtonColor;
    [self setColors];
}
-(void)setOffButtonColor:(UIColor *)offButtonColor{
    _offButtonColor = offButtonColor;
    [self setColors];
}
-(void)setOnButtonTextColor:(UIColor *)onButtonTextColor {
    _onButtonTextColor = onButtonTextColor;
    [self setColors];
}
-(void)setOffButtonTextColor:(UIColor *)offButtonTextColor {
    _offButtonTextColor = offButtonTextColor;
    [self setColors];
}
@end
