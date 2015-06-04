//
//  NetworkOperation.h
//  PracticeDemo
//
//  Created by 123 on 15-6-4.
//  Copyright (c) 2015年 杨魏. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    NWTokenFlag = 101,
}NWFlag;
@interface NetworkOperation : NSObject

@property (nonatomic,assign) NWFlag flag;
@property (nonatomic,strong) NSString *path;
@property (nonatomic,strong) NSDictionary *parmas;
@property (nonatomic,strong) NSArray *fileArray;

@property (nonatomic,strong) UIView *loadingView;

@property (nonatomic,assign) BOOL showLoading;
@property (nonatomic,assign) BOOL showAlert;

@property (nonatomic,strong) void(^complete)(id result);

- (void)getData;

- (void)postData;

@end
