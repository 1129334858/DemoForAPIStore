//
//  SecondCell.h
//  PracticeDemo
//
//  Created by 123 on 15-6-2.
//  Copyright (c) 2015年 杨魏. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^Swit)(BOOL isOn);
@interface SecondCell : UITableViewCell

@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UISwitch *switchOn;
@property (nonatomic,strong) Swit switOn;
@end
