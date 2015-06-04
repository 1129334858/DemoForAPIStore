//
//  GlobalModel.h
//  PracticeDemo
//
//  Created by 123 on 15-6-4.
//  Copyright (c) 2015年 杨魏. All rights reserved.
//

#import "JSONModel.h"

@interface GlobalModel : JSONModel

@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *sessionUniqueCode;

@end
