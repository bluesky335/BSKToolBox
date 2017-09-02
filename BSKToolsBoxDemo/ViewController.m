//
//  ViewController.m
//  BSKToolsBoxDemo
//
//  Created by 刘万林 on 2017/7/15.
//  Copyright © 2017年 BlueSky335. All rights reserved.
//
#import "BSKToolBox.h"
#import "ViewController.h"
#import "BSKRadioButton.h"
#import "BSKViewPager.h"
#import "BSKSwitch.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet BSKViewPager *viewPager;

@property (weak, nonatomic) IBOutlet UIView *testView;
@property (weak, nonatomic) IBOutlet BSKSwitch *testSwitch;

@end

@implementation ViewController
- (IBAction)buttonAction:(id)sender {
    [self bsk_MakeToast:@"提示消息！！" WithTime:2];
    self.testView.transform = CGAffineTransformMakeScale(1, 1);
}
- (IBAction)anotherButtonAction:(id)sender {
    self.testView.transform = CGAffineTransformMakeScale(0.5, 0.5);
    [self bsk_MakeToast:@"另一条提示消息！！hhhh啊季后赛的发挥kdh hjsdkjhsdfk kajsdhf Kjhaksdhfkjh卡获得发 jskdkhasdkh khkj空间哈卡萨丁回复看货到付款卡萨丁和客户独守空房建行卡水电费看 傲世三国防守打法" WithTime:2];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewPager.titles = @[@"qwert",@"erty",@"卡视角电",@"爽肤水",@"了会计师",@"啦啦啦啦",@"斤斤计较",@"叩叩叩",@"开局号",@"考虑拍个",@"帮您补发",@"口口声声",@"，了，了",@"来咯哦",@"欧派的撒出"];
    
    BSKSwitch * sw = [[BSKSwitch alloc] initWithFrame:CGRectMake(0, 0, 70, 30)];
    sw.onText = @"ON";
    sw.offText = @"OFF";
    sw.buttonText = @"弹";
    sw.center = self.view.center;
    [self.view addSubview:sw];
    
    self.testView.transform = CGAffineTransformMakeScale(0.5, 0.5);
    self.testView.frame = CGRectMake(100, 200, 100, 100);
    
//    ================
    
    
    
//    ================
//    UIView * view1 = [[UIView alloc] initWithFrame:CGRectMake(10, 40, 120, 100)];
//    view1.backgroundColor = [UIColor bsk_ColorWithHex:0xf0f0f0];
//    
//    BSKRadioButton * button = [BSKRadioButton buttonWithType:UIButtonTypeSystem];
//    button.frame = CGRectMake(10, 10, 100, 40);
//    [button setTitle:@"1-选项1" forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(buttonAction1:) forControlEvents:UIControlEventTouchUpInside];
//    
//    BSKRadioButton * button2 = [BSKRadioButton buttonWithType:UIButtonTypeSystem];
//    button2.frame = CGRectMake(10, 60, 100, 40);
//    [button2 setTitle:@"1-选项2" forState:UIControlStateNormal];
//    [button2 addTarget:self action:@selector(buttonAction2:) forControlEvents:UIControlEventTouchUpInside];
//
//    [view1 addSubview:button];
//    [view1 addSubview:button2];
//    [self.view addSubview:view1];
//    
//    
//    
//    UIView * view2 = [[UIView alloc] initWithFrame:CGRectMake(10, 170, 120, 100)];
//    view2.backgroundColor = [UIColor bsk_ColorWithHex:0xfdfdfd];
//    
//    BSKRadioButton * button3 = [BSKRadioButton buttonWithType:UIButtonTypeSystem];
//    button3.frame = CGRectMake(10, 10, 100, 40);
//    [button3 setTitle:@"2-选项1" forState:UIControlStateNormal];
//    [button3 addTarget:self action:@selector(buttonAction1:) forControlEvents:UIControlEventTouchUpInside];
//    
//    BSKRadioButton * button4 = [BSKRadioButton buttonWithType:UIButtonTypeSystem];
//    button4.frame = CGRectMake(10, 60, 100, 40);
//    [button4 setTitle:@"2-选项2" forState:UIControlStateNormal];
//    [button4 addTarget:self action:@selector(buttonAction2:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [view2 addSubview:button3];
//    [view2 addSubview:button4];
//    [self.view addSubview:view2];
    // Do any additional setup after loading the view, typically from a nib.
}

//-(void)buttonAction1:(BSKRadioButton *)sender{
//    BSKLog(@"%@-组id:%ld",sender.currentTitle,sender.groupID);
//}
//
//-(void)buttonAction2:(BSKRadioButton *)sender{
//    BSKLog(@"%@-组id:%ld",sender.currentTitle,sender.groupID);
//}


@end
