//
//  ContentCell.m
//  PracticeDemo
//
//  Created by 123 on 15-6-5.
//  Copyright (c) 2015年 杨魏. All rights reserved.
//

#import "ContentCell.h"

@implementation ContentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont systemFontOfSize:15.0f];
        [self.contentView addSubview:_contentLabel];
    }
    return self;
}

- (void)insertDataWithContent:(NSString *)content{
    NSMutableAttributedString *contentString = [[NSMutableAttributedString alloc] initWithData:[content dataUsingEncoding:NSUTF32StringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    NSRange range = NSMakeRange(0, contentString.length-1);
    [contentString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0] range:range];
    _contentLabel.attributedText = contentString;
    CGSize sizeForWidth = [_contentLabel contentSizeForWidth];
    CGSize sizeForHeight = [_contentLabel contentSizeForHeight];
    _contentLabel.frame = CGRectMake(15, 10, KScreenWidth-30, sizeForWidth.width/(KScreenWidth-30)*90);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
