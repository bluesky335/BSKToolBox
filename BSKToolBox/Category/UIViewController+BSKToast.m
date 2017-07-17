//
//  UIViewController+BSKToast.m
//  MicroMemory
//
//  Created by rimi on 16/7/18.
//  Copyright © 2016年 BlueSky. All rights reserved.
//

#import "UIViewController+BSKToast.h"
#import "BSKToolBox.h"

@interface BSKToastTask ()
@property (strong, nonatomic) NSMutableArray<NSDictionary * > * task;
@property (strong, nonatomic) NSNotification * kbWillShowNotification;
@property (assign, nonatomic) CGSize keyBoardSize;
@property (assign, nonatomic) BOOL isKeyboardShowing;
@end

@implementation BSKToastTask

+(instancetype)shareTask{
    static BSKToastTask * roastTask = nil;
    if (!roastTask) {
        roastTask = [[BSKToastTask alloc] init];
        
    }
    return roastTask;
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
    [BSKToastTask shareTask].keyBoardSize =  [[aNotification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    self.isKeyboardShowing = YES;
}

-(void)keyboardWillHide:(NSNotification*)aNotification{
    self.isKeyboardShowing = NO;
}

-(NSDictionary*)getToask{
    if (self.task.count>0) {
        NSDictionary * dic =self.task.firstObject;
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
    [UIViewController bsk_MakeToast:text WithTime:seconds onView:[UIApplication sharedApplication].keyWindow error:nil];
}
-(void)bsk_MakeErrorToast:(NSString *)text WithTime:(double)seconds
{
    
    if ([BSKToastTask shareTask].task.count>0) {
        [[BSKToastTask shareTask] putTask:@{@"text":text,@"time":@(seconds),@"error":@"true"}];
        return;
    }
    [[BSKToastTask shareTask] putTask:@{@"text":text,@"time":@(seconds),@"error":@"true"}];
    [UIViewController bsk_MakeToast:text WithTime:seconds onView:[UIApplication sharedApplication].keyWindow error:@"true"];
}


+(void)bsk_MakeToast:(NSString *)text WithTime:(double)seconds
{
    if ([BSKToastTask shareTask].task.count>0) {
        [[BSKToastTask shareTask] putTask:@{@"text":text,@"time":@(seconds)}];
        return;
    }
    [[BSKToastTask shareTask] putTask:@{@"text":text,@"time":@(seconds)}];
    [UIViewController bsk_MakeToast:text WithTime:seconds onView:[UIApplication sharedApplication].keyWindow error:nil];
}


+(void)bsk_MakeErrorToast:(NSString *)text WithTime:(double)seconds
{
    if ([BSKToastTask shareTask].task.count>0) {
        [[BSKToastTask shareTask] putTask:@{@"text":text,@"time":@(seconds),@"error":@"true"}];
        return;
    }
    [[BSKToastTask shareTask] putTask:@{@"text":text,@"time":@(seconds),@"error":@"true"}];
    [UIViewController bsk_MakeToast:text WithTime:seconds onView:[UIApplication sharedApplication].keyWindow error:@"true"];
}

+(void)bsk_MakeToast:(NSString *)text
            WithTime:(double)seconds
              onView:(UIView *)view
               error:(id)iserror
{
    __block UIView * toastView = [[UIView alloc] init];
    UILabel * toast = [[UILabel alloc]init];
    UIFont * toastFont = [UIFont systemFontOfSize:15 weight:UIFontWeightThin];
    toastView.alpha=0;
    [toastView addSubview:toast];
    [view addSubview:toastView];
    toast.numberOfLines = 0;
    toast.font = toastFont;
    toast.text = text;
    [toast sizeToFit];
    
    if (toast.bounds.size.width+60>BSKScreenWidth) {
        CGRect bounds = toast.bounds;
        CGSize textSize = [text boundingRectWithSize:CGSizeMake(BSKScreenWidth-60, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:toastFont} context:nil].size;
        bounds.size = textSize;
        toast.bounds = bounds;
    }
    
    CGPoint toastCenter = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height-(toast.bounds.size.height+20)-50);
    if ([BSKToastTask shareTask].isKeyboardShowing) {
        CGSize keyBoardSize = [BSKToastTask shareTask].keyBoardSize;
        toastCenter.y=[UIScreen mainScreen].bounds.size.height-(toast.bounds.size.height+20)-10-keyBoardSize.height;
    }
    
    toastView.bounds = CGRectMake(0, 0, toast.bounds.size.width+20, toast.bounds.size.height+20);
    toastView.center = toastCenter;
    toast.center = CGPointMake(toastView.bounds.size.width/2, toastView.bounds.size.height/2);
    toast.textAlignment = NSTextAlignmentCenter;
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
    toast.textColor = [UIColor whiteColor];
    toastView.transform = CGAffineTransformMakeScale(1.5, 1.5);
    [UIView animateWithDuration:0.25 animations:^{
        toastView.alpha = 1;
        toastView.transform = CGAffineTransformMakeScale(1, 1);
    } completion:nil];
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [UIView animateWithDuration:0.25 animations:^{
            toastView.alpha = 0;
        } completion:^(BOOL finished) {
            [toastView removeFromSuperview];
            [[BSKToastTask shareTask] popTask];
            if ([BSKToastTask shareTask].task.count>0) {
                NSDictionary * dic = [[BSKToastTask shareTask] getToask];
                [UIViewController bsk_MakeToast:dic[@"text"] WithTime:[dic[@"time"] doubleValue] onView:[UIApplication sharedApplication].keyWindow error:dic[@"error"]];
            }
        }];
        
    });
}
@end


