//
//  Constant.m
//  PracticeDemo
//
//  Created by 123 on 15-6-1.
//  Copyright (c) 2015年 杨魏. All rights reserved.
//

#import "Constant.h"
#import "UIImageView+WebCache.h"

@implementation Constant

/**
 *  显示远程图片
 *
 *  @param url   图片地址
 *  @param frame 图片frame
 *  @param view  父视图
 *
 *  @return UIImageView
 */
+ (UIImageView *)loadImageViewWithURL:(NSString *)url imageViewFrame:(CGRect)frame superView:(UIView *)view
{
    UIImageView *imageView = [self loadImageViewWithURL:url imageViewFrame:frame superView:view contentMode:UIViewContentModeScaleAspectFill];
    return imageView;
}

+ (UIImageView *)loadImageViewWithURL:(NSString *)url imageViewFrame:(CGRect)frame superView:(UIView *)view contentMode:(UIViewContentMode)contentMode
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.contentMode = contentMode;
    imageView.clipsToBounds = YES;
    
    [self setImageWithURL:url imageView:imageView];
    
    [view addSubview:imageView];
    return imageView;
}

+ (void)setImageWithURL:(NSString *)url imageView:(UIImageView *)imageView contentMode:(UIViewContentMode)contentMode
{
    imageView.contentMode = contentMode;
    imageView.clipsToBounds = YES;
    
    [self setImageWithURL:url imageView:imageView];
}

+ (void)setImageWithURL:(NSString *)url imageView:(UIImageView *)imageView
{
    [self setImageWithURL:url imageView:imageView placeholder:@"placeholder"];
}

+ (void)setImageWithURL:(NSString *)url imageView:(UIImageView *)imageView placeholder:(NSString *)placeholder
{
    [self setImageWithURL:url imageView:imageView placeholder:placeholder autoSize:YES];
}

+ (void)setImageWithURL:(NSString *)url imageView:(UIImageView *)imageView placeholder:(NSString *)placeholder autoSize:(BOOL)autoSize
{
    NSString *imageURL;
    if (url && url.length > 0) {
        // 设置尺寸
        NSArray *sizeArray = @[@64, @128, @256, @512, @768, @1024];
        NSUInteger realWidth = (NSUInteger)CGRectGetWidth(imageView.frame) * 2;
        NSUInteger fitWidth = 0;
        for (NSNumber *number in sizeArray) {
            NSUInteger width = [number unsignedIntegerValue];
            if (width >= realWidth) {
                fitWidth = width;
                break;
            }
        }
        
        NSString *fileName = [url stringByDeletingPathExtension];
        NSString *fileExtension = [url pathExtension];
        if (fitWidth == 0 || !autoSize) {
            imageURL = [NSString stringWithFormat:@"%@%@.%@", kImageURL, fileName, fileExtension];
        } else {
            imageURL = [NSString stringWithFormat:@"%@%@_%lu.%@", kImageURL, fileName, (unsigned long)fitWidth, fileExtension];
        }
    }
    //    NSLog(@"%@", imageURL);
    //    [imageView sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:placeholder]];
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:placeholder] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
}


@end
