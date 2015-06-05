//
//  NetworkItemBase.m
//  PracticeDemo
//
//  Created by 123 on 15-6-4.
//  Copyright (c) 2015年 杨魏. All rights reserved.
//

#import "NetworkItemBase.h"

#define kHttpRetryCount 1

typedef enum {
    post = 1,
    get = 2
}httpMethodType;

@interface NetworkItemBase (){
    httpMethodType _methodType;
    NSUInteger _retryCount;
}

@end

@implementation NetworkItemBase

- (instancetype)init{
    self = [super init];
    if (self) {
        _retryCount = 0;
        _showAlert = YES;
        _showLoading = YES;
        _loadingView = [[UIApplication sharedApplication].delegate window];
    }
    return self;
}

#pragma mark - get method

- (void)startGet{
    if (_flag!=NWTokenFlag && [Singleton ShareInstance].globalModel.sessionUniqueCode) {
        if ([_path rangeOfString:@"?"].location == NSNotFound) {
            _path = [NSString stringWithFormat:@"%@?sessionUniqueCode=%@",_path,[Singleton ShareInstance].globalModel.sessionUniqueCode];
        }else{
            _path = [NSString stringWithFormat:@"%@&sessionUniqueCode=%@",_path,[Singleton ShareInstance].globalModel.sessionUniqueCode];
        }
    }
    [self sendRequest:get];
}

#pragma mark - post method
- (void)startPost{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_parmas];
    if (_flag!=NWTokenFlag && [Singleton ShareInstance].globalModel.sessionUniqueCode) {
        [dic setObject:[Singleton ShareInstance].globalModel.sessionUniqueCode forKey:@"sessionUniqueCode"];
    }
    _parmas = dic;
    
    NSMutableArray *fileArray;
    if (_files && _files.count>0) {
        fileArray = [[NSMutableArray alloc] init];
        for (unsigned int i = 0; i<_files.count; i++) {
            NSDictionary *dic = [_files objectAtIndex:i];
            UIImage *image = [dic objectForKey:@"image"];
            
            NSData *data;
            if (UIImagePNGRepresentation(image)==nil) {
                data = UIImageJPEGRepresentation(image, 0.6);
            }else{
                data = UIImagePNGRepresentation(image);
            }
            
            //向沙盒中写入文件(将图片缓存到沙盒文件中)
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentPath = [paths firstObject];
            NSString *filePath = [documentPath stringByAppendingFormat:@"/upload_file%d.jpg",i];
            
            NSFileManager *filemanager = [NSFileManager defaultManager];
            [filemanager createFileAtPath:filePath contents:data attributes:nil];
            
            NSMutableDictionary *newDic = [NSMutableDictionary dictionaryWithDictionary:dic];
            [newDic setObject:filePath forKey:@"path"];
            [fileArray addObject:newDic];
        }
        _files = fileArray;
    }
    [self sendRequest:post];
}

- (void)sendRequest:(httpMethodType)type{
    _retryCount++;
    _methodType = type;
    BOOL alert = _retryCount < kHttpRetryCount ? NO:_showAlert;
    
    NetworkOperation *operation = [[NetworkOperation alloc] init];
    operation.flag = _flag;
    operation.path = [_path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    operation.parmas = _parmas;
    operation.fileArray = _files;
    operation.loadingView = _loadingView;
    operation.showAlert = alert;
    operation.showLoading = _showLoading;
    operation.complete = ^(id result){
        [self privateComplete:result];
    };
    if (type==get) {
        [operation getData];
    }else{
        [operation postData];
    }
    
}

- (void)privateComplete:(id)result{
    BOOL flag = NO;
    if ([result isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = (NSDictionary*)result;
        NSArray *allKeys = [dic allKeys];
        if ([allKeys containsObject:@"result"]) {
            NSString *code = [dic objectForKey:@"result"];
            NSString *timeOutCode = [dic objectForKey:@"messageCode"];
            if ([code isEqualToString:kSuccCode]) {
                flag = YES;
            }
            if ([timeOutCode isEqualToString:kTimeOutCode]) {
                flag = NO;
            }
        }
    }
    [self requestComplete:result succ:flag];
}

- (void)requestComplete:(id)result succ:(BOOL)succ{
    if (!succ) {
        if (_retryCount<kHttpRetryCount) {
            [self sendRequest:_methodType];
            return;
        }
    }
    if (_complete) {
        self.complete(result,succ);
    }
}

//虚函数
- (void)startRequest{
    
}

@end
