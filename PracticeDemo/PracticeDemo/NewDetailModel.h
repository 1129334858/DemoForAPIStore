//
//  NewDetailModel.h
//  PracticeDemo
//
//  Created by 123 on 15-6-5.
//  Copyright (c) 2015年 杨魏. All rights reserved.
//

#import "JSONModel.h"

@interface NewDetailModel : JSONModel

@property (nonatomic,strong) NSString <Optional>*author;
@property (nonatomic,strong) NSString <Optional>*count;
@property (nonatomic,strong) NSString <Optional>*fcount;
@property (nonatomic,strong) NSString <Optional>*focal;
@property (nonatomic,strong) NSString <Optional>*id;
@property (nonatomic,strong) NSString <Optional>*img;
@property (nonatomic,strong) NSString <Optional>*md;
@property (nonatomic,strong) NSString <Optional>*rcount;
@property (nonatomic,strong) NSString <Optional>*tag;
@property (nonatomic,strong) NSString <Optional>*time;
@property (nonatomic,strong) NSString <Optional>*title;

@end
