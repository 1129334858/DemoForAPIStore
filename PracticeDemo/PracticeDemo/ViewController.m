//
//  ViewController.m
//  PracticeDemo
//
//  Created by 123 on 15-6-1.
//  Copyright (c) 2015年 杨魏. All rights reserved.
//

#import "ViewController.h"
#import "Constant.h"
#import "UIViewController+specialNav.h"
#import "NextOneViewController.h"
#import "ShareViewController.h"

@interface ViewController ()
{
    UILabel *_label;
    BOOL upOrdown;
    NSInteger num;
    NSTimer *timer;
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigationTitle:@"网易新闻"];
    [self createNavigationRightButton:@"next" imageName:nil selector:@selector(nextController)];
    [self createNavigationLeftButton:@"other" imageName:nil selector:@selector(shareController)];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _label = [[UILabel alloc] initWithFrame:CGRectMake(KScreenWidth/2-200/2, 100, 200, 1)];
    _label.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_label];
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
    [self setUpUi];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)shareController{
    ShareViewController *shareVc = [[ShareViewController alloc] init];
    [self.navigationController pushViewController:shareVc animated:YES];
}

- (void)nextController{
    NextOneViewController *nextOneVc = [[NextOneViewController alloc] init];
    [self.navigationController pushViewController:nextOneVc animated:YES];
}

- (void)animation1{
    if (upOrdown == NO) {
        num ++;
        NSInteger h = 200;
        if (KScreenWidth>320) {
            _label.frame = CGRectMake(KScreenWidth/2-300/2, 120+2*num, 300, 1);
            h=200;
        }
        _label.frame = CGRectMake(KScreenWidth/2-200/2, 65+2*num, 200, 1);
        if (2*num == h) {
            upOrdown = YES;
        }
    }else {
        num --;
        if (KScreenWidth>320) {
            _label.frame = CGRectMake(KScreenWidth/2-300/2, 120+2*num, 300, 1);
        }
        _label.frame = CGRectMake(KScreenWidth/2-200/2, 65+2*num, 200, 1);
        if (num == 0) {
            upOrdown = NO;
        }
    }
}

- (void)setUpUi{
    _dataArray = [NSMutableArray arrayWithObjects:@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1", nil];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, KScreenWidth, KScreenHeight - 64.0)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

#pragma mark - tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [_dataArray objectAtIndex:indexPath.row];
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        [_dataArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
