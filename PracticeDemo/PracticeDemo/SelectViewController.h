//
//  SelectViewController.h
//  PracticeDemo
//
//  Created by 123 on 15-6-2.
//  Copyright (c) 2015年 杨魏. All rights reserved.
//

#import "CommonNavViewController.h"

typedef void(^SelectBlock) (NSString *text);
@interface SelectViewController : CommonNavViewController

@property (nonatomic,strong) SelectBlock selectBlock;
@end
