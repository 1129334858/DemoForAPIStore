//
//  UIViewController+specialNav.m
//  PracticeDemo
//
//  Created by 123 on 15-6-1.
//  Copyright (c) 2015年 杨魏. All rights reserved.
//

#import "UIViewController+specialNav.h"
#import "Constant.h"

@implementation UIViewController (specialNav)

- (void)createNavigationTitle:(NSString*)title{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(KScreenWidth/2-150/2, 0, 150, 44)];
    view.backgroundColor = [UIColor clearColor];
    UILabel *label = [[UILabel alloc] initWithFrame:view.bounds];
    label.textColor = RGB(255, 255, 255);
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    self.navigationItem.titleView = view;
}

- (void)createNavigationLeftButton:(NSString *)title imageName:(NSString *)imageName selector:(SEL)selector{
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 50, 30)];
    leftBtn.backgroundColor = [UIColor clearColor];
    [leftBtn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    if (title && [title length]>0) {
        [leftBtn setTitle:title forState:UIControlStateNormal];
        [leftBtn setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
        leftBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    }
    if (imageName && [imageName length]>0) {
        [leftBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarBtn;
}

- (void)createNavigationRightButton:(NSString *)title imageName:(NSString *)imageName selector:(SEL)selector{
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 70, 30)];
    rightBtn.backgroundColor = [UIColor clearColor];
    [rightBtn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    if (title && [title length]>0) {
        [rightBtn setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
        [rightBtn setTitle:title forState:UIControlStateNormal];
        rightBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    }
    if (imageName && [imageName length]>0) {
        [rightBtn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
}

@end
