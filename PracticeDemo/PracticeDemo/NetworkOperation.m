//
//  NetworkOperation.m
//  PracticeDemo
//
//  Created by 123 on 15-6-4.
//  Copyright (c) 2015年 杨魏. All rights reserved.
//

#import "NetworkOperation.h"

@implementation NetworkOperation

- (void)getData{
    [self startRequest:@"GET"];
}

- (void)postData{
    [self startRequest:@"POST"];
}

- (void)startRequest:(NSString*)method{
    if (_showLoading) {
        [[Singleton ShareInstance] startLoadingInView:_loadingView];
    }
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",kMianAPI,_path];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    if ([method isEqualToString:@"POST"]) {
        [manager POST:urlString parameters:_parmas constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            if (_fileArray && _fileArray.count>0) {
                for (NSDictionary *dic in _fileArray) {
                    NSError *error;
                    NSString *filePath = [dic objectForKey:@"path"];
                    NSURL *url = [NSURL URLWithString:filePath];
                    BOOL flag = [formData appendPartWithFileURL:url name:[dic objectForKey:@"name"] error:&error];
                    if (!flag) {
                        NSLog(@"%@",error);
                    }
                }
            }
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self requestComplete:operation];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSString *errorString = [NSString stringWithFormat:@"%@",error];
            NSString *theErrorString = @"the request timed out";
            if ([errorString isEqualToString:theErrorString]) {
                [[TKAlertCenter defaultCenter] postAlertWithMessage:@"连接超时，请检查网络设置"];
            }else{
                [self requestComplete:operation];
            }
        }];
    }else if ([method isEqualToString:@"GET"]){
        [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self requestComplete:operation];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSString *errorString = [NSString stringWithFormat:@"%@",error];
            NSString *theErrorString = @"the request timed out";
            if ([errorString isEqualToString:theErrorString]) {
                [[TKAlertCenter defaultCenter] postAlertWithMessage:@"连接超时，请检查网络设置"];
            }else{
                [self requestComplete:operation];
            }
        }];
    }
}

- (void)requestComplete:(AFHTTPRequestOperation*)operaton{
    [[Singleton ShareInstance] stopLoading];
    
    id result = operaton.responseObject;
    NSLog(@"返回数据:%@\n",result);
    if (operaton.response.statusCode==0) {
        NSString *errorDescription = [operaton.error.userInfo objectForKey:@""];
        [self showMessage:errorDescription ? [errorDescription substringFromIndex:errorDescription.length-1]:@"网络异常"];
    }else if (operaton.response.statusCode==200){
        if (result) {
            if (![[result objectForKey:@"result"] isEqualToString:kSuccCode]) {
                NSString *msg = [result objectForKey:@"message"];
                [self showMessage:msg.length>0 ? msg:@"操作失败"];
            }
        }else{
            [self showMessage:@"数据异常"];
        }
    }else{
        [self showMessage:@"未知错误"];
    }
    
    if (self.complete) {
        self.complete(result);
    }
}

- (void)showMessage:(NSString*)message{
    if (self.showAlert) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:message];
    }
}

@end
