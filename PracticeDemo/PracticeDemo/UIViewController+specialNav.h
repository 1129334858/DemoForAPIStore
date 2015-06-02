//
//  UIViewController+specialNav.h
//  PracticeDemo
//
//  Created by 123 on 15-6-1.
//  Copyright (c) 2015年 杨魏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (specialNav)

- (void)createNavigationTitle:(NSString*)title;

- (void)createNavigationLeftButton:(NSString*)title imageName:(NSString*)imageName selector:(SEL)selector;

- (void)createNavigationRightButton:(NSString *)title imageName:(NSString *)imageName selector:(SEL)selector;

@end
