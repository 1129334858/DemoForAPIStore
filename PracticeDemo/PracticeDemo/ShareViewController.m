//
//  ShareViewController.m
//  PracticeDemo
//
//  Created by 123 on 15-6-3.
//  Copyright (c) 2015年 杨魏. All rights reserved.
//

#import "ShareViewController.h"
#import "UIViewController+specialNav.h"
#import "UMSocial.h"

@interface ShareViewController ()

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigationTitle:@"分享"];
    [self createNavigationRightButton:@"分享" imageName:nil selector:@selector(shareInfo)];
    [self createNavigationLeftButton:@"返回" imageName:nil selector:@selector(back)];

    // Do any additional setup after loading the view.
}

- (void)shareInfo{
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"" shareText:@"How are you?" shareImage:nil shareToSnsNames:[NSArray arrayWithObjects:UMShareToRenren,UMShareToSina,UMShareToQzone,UMShareToWechatTimeline, nil] delegate:nil];
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
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
