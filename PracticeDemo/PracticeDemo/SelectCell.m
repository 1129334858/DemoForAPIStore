//
//  SelectCell.m
//  PracticeDemo
//
//  Created by 123 on 15-6-2.
//  Copyright (c) 2015年 杨魏. All rights reserved.
//

#import "SelectCell.h"
#import "Constant.h"

@implementation SelectCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 60, 40)];
        _label.backgroundColor = [UIColor clearColor];
        _label.font = [UIFont systemFontOfSize:15.0f];
        
        _addLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_label.frame)+15, 0, KScreenWidth-CGRectGetMaxX(_label.frame)-15, CGRectGetHeight(_label.frame))];
        _addLabel.backgroundColor = [UIColor clearColor];
        _addLabel.font = [UIFont systemFontOfSize:15.0f];
        
        [self.contentView addSubview:_label];
        [self.contentView addSubview:_addLabel];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
