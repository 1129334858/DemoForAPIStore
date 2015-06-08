//
//  ContentCell.h
//  PracticeDemo
//
//  Created by 123 on 15-6-5.
//  Copyright (c) 2015年 杨魏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentCell : UITableViewCell

@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UITextView *textView;

- (void)insertDataWithContent:(NSString*)content;


@end
