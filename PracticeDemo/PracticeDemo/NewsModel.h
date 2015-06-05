//
//  NewsModel.h
//  PracticeDemo
//
//  Created by 123 on 15-6-5.
//  Copyright (c) 2015年 杨魏. All rights reserved.
//

#import "JSONModel.h"

@interface NewsModel : JSONModel

@property (nonatomic,strong) NSString *success;
@property (nonatomic,strong) NSString *total;
@property (nonatomic,strong) NSArray *yi18;

@end
