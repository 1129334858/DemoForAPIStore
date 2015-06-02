//
//  Singleton.m
//  PracticeDemo
//
//  Created by 123 on 15-6-1.
//  Copyright (c) 2015年 杨魏. All rights reserved.
//

#import "Singleton.h"

@implementation Singleton

+ (instancetype)ShareInstance{
    static id instance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

- (instancetype)init{
    if (self) {
        
//        _globalModel = [[GlobalModel alloc] init];
    }
    return self;
}

- (void)startLoading{
    [self startLoadingInView:[[UIApplication sharedApplication].delegate window]];
}

- (void)startLoadingInView:(UIView*)view{
    loadingCount++;
    if (loadingCount==1) {
        loadingView = [[MBProgressHUD alloc] initWithView:view];
        loadingView.labelText = @"正在加载";
        [loadingView show:YES];
    }else{
        [loadingView removeFromSuperview];
    }
    [view addSubview:loadingView];
}

- (void)stopLoading{
    loadingCount--;
    if (loadingCount==0) {
        [loadingView removeFromSuperview];
        [loadingView hide:YES];
        loadingView = nil;
    }
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)forceToStopLoading{
    loadingCount = 0;
    [self stopLoading];
}

# pragma mark - SQL

- (void)checkUserDatabase{
    NSString *dbName = @"";
    [self checkDatabase:dbName targetName:dbName];
}

- (void)checkPublicDatabase{

}

- (void)checkDatabase:(NSString*)dbName targetName:(NSString*)targetName{
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray *filePaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [filePaths firstObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:dbName];
    
    success = [fileManager fileExistsAtPath:filePath];
    if (!success) {
        NSString *sandbox = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:dbName];
        success = [fileManager fileExistsAtPath:sandbox];
        if (!success) {
            NSLog(@"资源库中没有该数据库文件");
        }else{
            success = [fileManager copyItemAtPath:sandbox toPath:filePath error:nil];
            if (!success) {
                NSLog(@"faile to copy");
            }
        }
    }
    if (success) {
        _userDB = [[FMDatabase alloc] initWithPath:filePath];
        if (![_userDB open]) {
            NSLog(@"数据库打开失败");
        }
        [self checkDatabaseVersion:_userDB dbName:dbName targetName:targetName];
    }
}

- (void)checkDatabaseVersion:(FMDatabase*)database dbName:(NSString*)dbName targetName:(NSString*)targetName{
    BOOL success;
    FMResultSet *rs = [database executeQuery:@"select value from dbName where key = 'dataVersion'"];
    if ([rs next]) {
        NSDictionary *dic = [rs resultDictionary];
        float version = [[dic objectForKey:@"value"] floatValue];
        float newVersion = 0.1;
        
        if (version!=newVersion) {
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSArray *filePaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentPath = [filePaths firstObject];
            NSString *filePath = [documentPath stringByAppendingPathComponent:targetName];
            
            success = [fileManager fileExistsAtPath:filePath];
            if (success) {
                success = [fileManager removeItemAtPath:filePath error:nil];
                if (success) {
                    [self checkDatabase:dbName targetName:targetName];
                }
            }
        }
        
    }
    
}

@end
