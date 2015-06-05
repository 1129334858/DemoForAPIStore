//
//  Constant.h
//  PracticeDemo
//
//  Created by 123 on 15-6-1.
//  Copyright (c) 2015年 杨魏. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kMianAPI @"http://apis.baidu.com"
#define kSuccCode @"s"
#define kTimeOutCode @"timeOut"
#define userDatabaseVersion 0.1
#define IOS7 [[UIDevice currentDevice].systemVersion floatValue]>=7.0
#define RGB(R,G,B) [UIColor colorWithRed:(R)/255.0 green:(G)/255.0 blue:(B)/255.0 alpha:1]
#define KScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)
#define KScreenWidth CGRectGetWidth([UIScreen mainScreen].bounds)
#define ShareApp ((AppDelegate*)[UIApplication sharedApplication].delegate)

@interface Constant : NSObject



@end
