//
//  Singleton.h
//  PracticeDemo
//
//  Created by 123 on 15-6-1.
//  Copyright (c) 2015年 杨魏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GlobalModel.h"
#import "MBProgressHUD.h"
#import "FMDatabase.h"

@interface Singleton : NSObject
{
    MBProgressHUD *loadingView;
    NSUInteger loadingCount;
}

@property (nonatomic,strong) GlobalModel *globalModel;
@property (nonatomic,strong) FMDatabase *userDB;

+ (instancetype)ShareInstance;
- (void)startLoading;
- (void)stopLoading;
- (void)forceToStopLoading;
- (void)startLoadingInView:(UIView*)view;

@end
