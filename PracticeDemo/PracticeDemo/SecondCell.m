//
//  SecondCell.m
//  PracticeDemo
//
//  Created by 123 on 15-6-2.
//  Copyright (c) 2015年 杨魏. All rights reserved.
//

#import "SecondCell.h"
#import "Constant.h"

@implementation SecondCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 60, 40)];
        _label.backgroundColor = [UIColor clearColor];
        _label.font = [UIFont systemFontOfSize:15.0f];
        
        _switchOn = [[UISwitch alloc] initWithFrame:CGRectMake(KScreenWidth-50-20, 5, 50, 30)];
        _switchOn.on = YES;
        [_switchOn addTarget:self action:@selector(isOnOrOff:) forControlEvents:UIControlEventValueChanged];
        [self.contentView addSubview:_switchOn];
        [self.contentView addSubview:_label];
    }
    return self;
}

- (void)isOnOrOff:(UISwitch*)switchOn{
    if (_switOn) {
        _switOn(switchOn.on);
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
