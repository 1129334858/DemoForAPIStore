//
//  CommonNavViewController.m
//  PracticeDemo
//
//  Created by 123 on 15-6-1.
//  Copyright (c) 2015年 杨魏. All rights reserved.
//

#import "CommonNavViewController.h"
#import "Constant.h"

@interface CommonNavViewController ()

@end

@implementation CommonNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(255, 255, 255);
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.navigationController.navigationBar.translucent = NO;
    if (IOS7) {
        self.navigationController.navigationBar.tintColor = RGB(9, 158, 255);
    }else{
        self.navigationController.navigationBar.barTintColor = RGB(9, 158, 255);
    }
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
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
