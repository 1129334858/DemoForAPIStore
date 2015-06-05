//
//  TitleCell.m
//  PracticeDemo
//
//  Created by 123 on 15-6-5.
//  Copyright (c) 2015年 杨魏. All rights reserved.
//

#import "TitleCell.h"

@implementation TitleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:20.0f];
        _titleLabel.numberOfLines = 0;
        [self.contentView addSubview:_titleLabel];
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = [UIColor lightGrayColor];
        _timeLabel.font = [UIFont systemFontOfSize:12.0f];
        [self.contentView addSubview:_timeLabel];
        
        _authorLabel = [[UILabel alloc] init];
        _authorLabel.textColor = [UIColor lightGrayColor];
        _authorLabel.font = [UIFont systemFontOfSize:12.0f];
        [self.contentView addSubview:_authorLabel];
    }
    return self;
}

- (void)insertDataWithModel:(NSString *)title time:(NSString *)time author:(NSString *)author{
    _timeLabel.text = time;
    _authorLabel.text = author;
    _titleLabel.text = title;
    CGSize sizeForWidth = [_titleLabel contentSizeForWidth];
    CGSize sizeForHeight = [_titleLabel contentSizeForHeight];
    if (sizeForWidth.width<KScreenWidth-40) {
        _titleLabel.frame = CGRectMake(20, 10, sizeForWidth.width, sizeForHeight.height);
    }else{
        _titleLabel.frame = CGRectMake(20, 10, KScreenWidth-40, sizeForHeight.height*2);
    }
    _timeLabel.frame = CGRectMake(CGRectGetMinX(_titleLabel.frame), CGRectGetMaxY(_titleLabel.frame) + 15, 150, 10);
    _authorLabel.frame = CGRectMake(CGRectGetMaxX(_timeLabel.frame) + 20, CGRectGetMaxY(_titleLabel.frame) + 15, 100, 10);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
