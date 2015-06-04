//
//  NetworkItemBase.h
//  PracticeDemo
//
//  Created by 123 on 15-6-4.
//  Copyright (c) 2015年 杨魏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkOperation.h"

@interface NetworkItemBase : NSObject

{
    NWFlag _flag;
    
    NSString *_path;
    
    NSDictionary *_parmas;
    
    NSArray *_files;
    
    UIView *_loadingView;
    
    BOOL _showLoading;
    BOOL _showAlert;
}

@property (nonatomic,strong) void(^complete)(id result,BOOL flag);

- (void)startGet;
- (void)startPost;
- (void)startRequest;
- (void)requestComplete:(id)result succ:(BOOL)succ;

@end
