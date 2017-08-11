//
//  BSKRadioButton.m
//  爱尚艺家
//
//  Created by 刘万林 on 2017/8/3.
//  Copyright © 2017年 Me. All rights reserved.
//

#import "BSKRadioButton.h"

@interface BSKRadioButton ()
@property (assign, nonatomic) SEL BSK_Action;
@property (weak, nonatomic) id target;
@end

@implementation BSKRadioButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [super addTarget:self action:@selector(BSK_buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [super addTarget:self action:@selector(BSK_buttonAction:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (self.selected) {
        for (UIView * view in self.superview.subviews) {
            if ([view isKindOfClass:[BSKRadioButton class]]) {
                BSKRadioButton * button = (BSKRadioButton *) view;
                if (button.groupID == self.groupID&&button != self) {
                    button.selected = NO;
                }
            }
        }
    }
}

-(void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    [super addTarget:self action:@selector(BSK_buttonAction:) forControlEvents:controlEvents];
    
    self.target = target;
    self.BSK_Action = action;
}

-(void)BSK_buttonAction:(BSKRadioButton *)sender{
    self.selected = YES;
    if (self.target&&[self.target respondsToSelector:self.BSK_Action]) {
        @try {
            [self.target performSelector:_BSK_Action withObject:self];
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
    }
}

@end
