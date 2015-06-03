//
//  UILabel+ContextSize.m
//  PracticeDemo
//
//  Created by 123 on 15-6-3.
//  Copyright (c) 2015年 杨魏. All rights reserved.
//

#import "UILabel+ContextSize.h"

@implementation UILabel (ContextSize)

- (CGSize)contentSizeForWidth{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = self.lineBreakMode;
    paragraphStyle.alignment = self.textAlignment;
    
    NSDictionary *dictionary = @{NSFontAttributeName:self.font,NSParagraphStyleAttributeName:paragraphStyle};
    CGSize size = [self.text boundingRectWithSize:CGSizeMake(MAXFLOAT, self.frame.size.height) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dictionary context:nil].size;
    return size;
}

- (CGSize)contentSizeForHeight{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = self.lineBreakMode;
    paragraphStyle.alignment = self.textAlignment;
    
    NSDictionary *dictionary = @{NSFontAttributeName:self.font,NSParagraphStyleAttributeName:paragraphStyle};
    CGSize size = [self.text boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dictionary context:nil].size;
    return size;
}

@end
