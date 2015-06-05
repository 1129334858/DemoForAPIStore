//
//  NewsCell.h
//  PracticeDemo
//
//  Created by 123 on 15-6-5.
//  Copyright (c) 2015年 杨魏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewDetailModel.h"

@interface NewsCell : UITableViewCell

@property (nonatomic,strong) UIImageView *imgView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *browserCountLabel;

- (void)insertDataWithModel:(NewDetailModel*)model;

@end
