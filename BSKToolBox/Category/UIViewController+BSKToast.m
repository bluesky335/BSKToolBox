//
//  UIViewController+BSKToast.m
//  MicroMemory
//
//  Created by rimi on 16/7/18.
//  Copyright © 2016年 BlueSky. All rights reserved.
//

#import "UIViewController+BSKToast.h"
#import "BSKToolBox.h"


@interface BSKToastConfig()
@property (strong, nonatomic) NSNotification * kbWillShowNotification;
@property (assign, nonatomic) CGSize keyBoardSize;
@property (assign, nonatomic) BOOL isKeyboardShowing;
@property (weak, nonatomic) UIView * ToastView;
@property (weak, nonatomic) UILabel * ToastLabel;
@end


@implementation BSKToastConfig

+(instancetype)shareInstance{
    static BSKToastConfig * Config = nil;
    if (!Config) {
        Config = [[BSKToastConfig alloc] init];
        
    }
    return Config;
}


-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

-(void)getKeyBoardNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}


-(void)keyboardWillShow:(NSNotification*)aNotification{
    self.kbWillShowNotification = aNotification;
    [BSKToastConfig shareInstance].keyBoardSize =  [[aNotification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    self.isKeyboardShowing = YES;
}

-(void)keyboardWillHide:(NSNotification*)aNotification{
    self.isKeyboardShowing = NO;
}


@end

//========================
@interface BSKToastTask : NSObject
@property (strong, nonatomic) NSMutableArray<NSDictionary * > * task;
+(instancetype)shareTask;
@end

//========================
@implementation BSKToastTask
+(instancetype)shareTask{
    static BSKToastTask * roastTask = nil;
    if (!roastTask) {
        roastTask = [[BSKToastTask alloc] init];
        
    }
    return roastTask;
}

-(NSDictionary*)getToask{
    if (self.task.count>0) {
        NSDictionary * dic =self.task.firstObject;
        return dic;
    }else{
        return nil;
    }
}
-(NSDictionary*)getNextToask{
    if (self.task.count>1) {
        NSDictionary * dic =self.task[1];
        return dic;
    }else{
        return nil;
    }
}

-(void)popTask{
    if (self.task.count>0) {
       [self.task removeObjectAtIndex:0];
    }
}

-(void)putTask:(NSDictionary * )dic{
    [self.task addObject:dic];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.task = [NSMutableArray array];
    }
    return self;
}

@end

@implementation UIViewController (BSKToast)
-(void)bsk_MakeToast:(NSString *)text WithTime:(double)seconds
{
    if ([BSKToastTask shareTask].task.count>0) {
        [[BSKToastTask shareTask] putTask:@{@"text":text,@"time":@(seconds)}];
        return;
    }
    [[BSKToastTask shareTask] putTask:@{@"text":text,@"time":@(seconds)}];
    [UIViewController bsk_MakeToast:text WithTime:seconds onView:[UIApplication sharedApplication].keyWindow error:nil Animate:YES];
}
-(void)bsk_MakeErrorToast:(NSString *)text WithTime:(double)seconds
{
    
    if ([BSKToastTask shareTask].task.count>0) {
        [[BSKToastTask shareTask] putTask:@{@"text":text,@"time":@(seconds),@"error":@"true"}];
        return;
    }
    [[BSKToastTask shareTask] putTask:@{@"text":text,@"time":@(seconds),@"error":@"true"}];
    [UIViewController bsk_MakeToast:text WithTime:seconds onView:[UIApplication sharedApplication].keyWindow error:@"true" Animate:YES];
}


+(void)bsk_MakeToast:(NSString *)text WithTime:(double)seconds
{
    if ([BSKToastTask shareTask].task.count>0) {
        [[BSKToastTask shareTask] putTask:@{@"text":text,@"time":@(seconds)}];
        return;
    }
    [[BSKToastTask shareTask] putTask:@{@"text":text,@"time":@(seconds)}];
    [UIViewController bsk_MakeToast:text WithTime:seconds onView:[UIApplication sharedApplication].keyWindow error:nil Animate:YES];
}


+(void)bsk_MakeErrorToast:(NSString *)text WithTime:(double)seconds
{
    if ([BSKToastTask shareTask].task.count>0) {
        [[BSKToastTask shareTask] putTask:@{@"text":text,@"time":@(seconds),@"error":@"true"}];
        return;
    }
    [[BSKToastTask shareTask] putTask:@{@"text":text,@"time":@(seconds),@"error":@"true"}];
    [UIViewController bsk_MakeToast:text WithTime:seconds onView:[UIApplication sharedApplication].keyWindow error:@"true" Animate:YES];
}

+(void)bsk_MakeToast:(NSString *)text
            WithTime:(double)seconds
              onView:(UIView *)view
               error:(id)iserror
             Animate:(BOOL) animate
{
    NSLog(@"执行了一次");
    UIView * toastView = [BSKToastConfig shareInstance].ToastView;
    if (!toastView) {
        toastView = [[UIView alloc] init];
        BSKLog(@"初始化一个View",nil);
        [BSKToastConfig shareInstance].ToastView = toastView;
    }
    
    UILabel * toastLabel = [BSKToastConfig shareInstance].ToastLabel;
    
    if (!toastLabel) {
        toastLabel = [[UILabel alloc]init];
        BSKLog(@"初始化一个Labe",nil);
        [BSKToastConfig shareInstance].ToastLabel = toastLabel;
    }
    
    UIFont * toastFont = [UIFont systemFontOfSize:15 weight:UIFontWeightThin];
    
    [toastView addSubview:toastLabel];
    [view addSubview:toastView];
    toastLabel.numberOfLines = 1;
    toastLabel.font = toastFont;
    toastLabel.text = text;
    [toastLabel sizeToFit];
    
    if (toastLabel.bounds.size.width+60>BSKScreenWidth) {
        CGRect bounds = toastLabel.bounds;
        CGSize textSize = [text boundingRectWithSize:CGSizeMake(BSKScreenWidth-60, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:toastFont} context:nil].size;
        bounds.size = textSize;
        toastLabel.numberOfLines = 0;
        toastLabel.bounds = bounds;
    }
    
    CGPoint toastCenter = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height-(toastLabel.bounds.size.height+20)-50);
    if ([BSKToastConfig shareInstance].isKeyboardShowing) {
        CGSize keyBoardSize = [BSKToastConfig shareInstance].keyBoardSize;
        toastCenter.y=[UIScreen mainScreen].bounds.size.height-(toastLabel.bounds.size.height+20)-10-keyBoardSize.height;
    }
    
    toastView.bounds = CGRectMake(0, 0, toastLabel.bounds.size.width+20, toastLabel.bounds.size.height+20);
    toastView.center = toastCenter;
    toastLabel.center = CGPointMake(toastView.bounds.size.width/2, toastView.bounds.size.height/2);
    toastLabel.textAlignment = NSTextAlignmentCenter;
    if (iserror) {
        toastView.backgroundColor = [UIColor colorWithRed:0xec/255 green:0x0f/255 blue:0x0e/255 alpha:1];
    }else{
       toastView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.7];
    }
    toastView.layer.shadowColor = [UIColor blackColor].CGColor;
    toastView.layer.shadowOffset = CGSizeMake(3, 3);
    toastView.layer.shadowRadius = 4;
    toastView.layer.shadowOpacity = 0.5;
    toastView.layer.cornerRadius = 5;
    toastLabel.textColor = [UIColor whiteColor];
    
    if (animate) {
        toastView.alpha=0;
        toastView.transform = CGAffineTransformMakeScale(1.5, 1.5);
        [UIView animateWithDuration:0.25 animations:^{
            toastView.alpha = 1;
            toastView.transform = CGAffineTransformMakeScale(1, 1);
        } completion:nil];
    }else{
        toastView.alpha=1;
    }
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [[BSKToastTask shareTask] popTask];
            BOOL hasNext = [BSKToastTask shareTask].task.count>0;
            if (hasNext) {
                NSDictionary * dic = [[BSKToastTask shareTask] getToask];
                BOOL animatedNext = ![dic[@"text"] isEqualToString:text];
                if (animatedNext) {
                    [UIView animateWithDuration:0.25 animations:^{
                        toastView.alpha = 0;
                    } completion:^(BOOL finished) {
                        [toastView removeFromSuperview];
                        [UIViewController bsk_MakeToast:dic[@"text"] WithTime:[dic[@"time"] doubleValue] onView:[UIApplication sharedApplication].keyWindow error:dic[@"error"] Animate:animatedNext];
                    }];
                }else{
                    [UIViewController bsk_MakeToast:dic[@"text"] WithTime:[dic[@"time"] doubleValue] onView:[UIApplication sharedApplication].keyWindow error:dic[@"error"] Animate:animatedNext];
                }
            }else{
                [UIView animateWithDuration:0.25 animations:^{
                    toastView.alpha = 0;
                } completion:^(BOOL finished) {
                    [toastView removeFromSuperview];
                }];
            }
           
        });
}
@end


