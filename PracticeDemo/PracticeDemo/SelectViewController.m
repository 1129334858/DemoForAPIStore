//
//  SelectViewController.m
//  PracticeDemo
//
//  Created by 123 on 15-6-2.
//  Copyright (c) 2015年 杨魏. All rights reserved.
//

#import "SelectViewController.h"
#import "Constant.h"

@interface SelectViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
}
@end

@implementation SelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)setUpUi{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, KScreenWidth, KScreenHeight-64)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
