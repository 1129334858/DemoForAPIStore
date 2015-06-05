//
//  TitleCell.h
//  PracticeDemo
//
//  Created by 123 on 15-6-5.
//  Copyright (c) 2015年 杨魏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleCell : UITableViewCell

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *authorLabel;

- (void)insertDataWithModel:(NSString*)title time:(NSString*)time author:(NSString*)author;

@end
