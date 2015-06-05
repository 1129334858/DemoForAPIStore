//
//  NWGetNews.m
//  PracticeDemo
//
//  Created by 123 on 15-6-4.
//  Copyright (c) 2015年 杨魏. All rights reserved.
//

#import "NWGetNews.h"

@implementation NWGetNews

- (void)startRequestForNew{
    
    _path = @"http://apis.baidu.com/news/list";
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"84bc9cdd16d30a0b96a80c459be1ddb9" forKey:@"apikey"];
    _parmas = dic;
    [self startPost];
}


@end
