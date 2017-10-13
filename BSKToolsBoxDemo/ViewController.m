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
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,BSKViewPagerDelegate>
@property (weak, nonatomic) IBOutlet BSKViewPager *viewPager;

@property (weak, nonatomic) IBOutlet BSKSwitch *testSwitch;
@property (weak, nonatomic) IBOutlet UITableView *testTableView;
@property (strong, nonatomic) NSMutableArray<NSString *> * array;
@end

@implementation ViewController
- (IBAction)buttonAction:(id)sender {
    [self bsk_MakeToast:@"提示消息！！" WithTime:2];
    self.viewPager.selectedIndex = 10;
}
- (IBAction)anotherButtonAction:(id)sender {
    [self.array removeAllObjects];
    [self.array addObjectsFromArray:@[@"1234",@"qwer",@"asdf"]];
    self.viewPager.itemAlignMode = BSKViewPagerItemAlignModeCenter;
    [self.viewPager reload];
    [self bsk_MakeToast:@"按可来的设计费垃圾开始的法律" WithTime:2];
}
- (IBAction)getBattery:(id)sender {
    NSLog(@"%@",@([UIDevice currentDevice].batteryLevel));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    self.array = [NSMutableArray arrayWithArray:@[@"qwert",@"erty",@"卡视角电"]];
    self.viewPager.titles = self.array;
    self.viewPager.autoScrollToCenter = NO;
    self.viewPager.selectedIndex = 5;
    self.viewPager.delegate = self;
    BSKSwitch * sw = [[BSKSwitch alloc] initWithFrame:CGRectMake(0, 0, 70, 30)];
    sw.onText = @"ON";
    sw.offText = @"OFF";
    sw.buttonText = @"弹";
    sw.center = self.view.center;
    [self.view addSubview:sw];
    
//    ================
    
    self.testTableView.delegate = self;
    self.testTableView.dataSource = self;
    [self.testTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.testTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
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

-(BOOL)ViewPager:(BSKViewPager *)viewPager canChangeStatusAtIndex:(NSInteger)index{
    return YES;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = BSKString(@(indexPath.row),nil);
    cell.detailTextLabel.text =BSKString(indexPath,nil);
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BSKLog(@"选中了%@",@(indexPath.row));
}

@end
