//
//  NewsCell.m
//  PracticeDemo
//
//  Created by 123 on 15-6-5.
//  Copyright (c) 2015年 杨魏. All rights reserved.
//

#import "NewsCell.h"

@implementation NewsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 75, 60)];
        [self.contentView addSubview:_imgView];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [self.contentView addSubview:_titleLabel];
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(KScreenWidth - 150, 65, 140, 10)];
        _timeLabel.font = [UIFont systemFontOfSize:12.0f];
        _timeLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_timeLabel];
        
    }
    return self;
}

- (void)insertDataWithModel:(NewDetailModel *)model{
    if (model) {
        [Constant setImageWithURL:model.img imageView:_imgView placeholder:@"ni" autoSize:NO];
        _titleLabel.text = model.title;
        CGSize sizeForWidth = [_titleLabel contentSizeForWidth];
        CGSize sizeForHeight = [_titleLabel contentSizeForHeight];
        if (sizeForWidth.width<KScreenWidth-CGRectGetMaxX(_imgView.frame)-20) {
            _titleLabel.frame = CGRectMake(CGRectGetMaxX(_imgView.frame)+10, 10, sizeForWidth.width, sizeForHeight.height);
        }else{
            _titleLabel.frame = CGRectMake(CGRectGetMaxX(_imgView.frame)+10, 10, KScreenWidth-CGRectGetMaxX(_imgView.frame)-20, sizeForHeight.height*2);
        }
        _timeLabel.text = model.time;
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
