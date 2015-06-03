//
//  NextOneViewController.m
//  PracticeDemo
//
//  Created by 123 on 15-6-2.
//  Copyright (c) 2015年 杨魏. All rights reserved.
//

#import "NextOneViewController.h"
#import "NextTwoViewController.h"
#import "UIViewController+specialNav.h"
#import "Constant.h"

@interface NextOneViewController ()<NSURLConnectionDataDelegate,NSURLConnectionDelegate>
{
    NSMutableData *_recviceData;
}
@end

@implementation NextOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigationRightButton:@"next" imageName:nil selector:@selector(nextViewController)];
    
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com/"]];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0.0, 0.0, KScreenWidth, KScreenHeight-64)];
    [webView loadRequest:req];
    webView.scalesPageToFit = YES;
    [self.view addSubview:webView];
    
    _recviceData = [[NSMutableData alloc] init];
    NSString *urlString = [NSString stringWithFormat:@"http://www.baidu.com"];
    if (![urlString length]>0) {
        NSLog(@"url不合法");
        return;
    }
    NSURLCache *urlCache = [NSURLCache sharedURLCache];
    //设置缓存的大小
    [urlCache setMemoryCapacity:1*1024*1024];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
    
    NSCachedURLResponse *response = [urlCache cachedResponseForRequest:request];
    if (response!=nil) {
        NSLog(@"有缓存数据，输出缓存数据！");
        [request setCachePolicy:NSURLRequestReturnCacheDataDontLoad];
    }
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    [connection start];
    
    // Do any additional setup after loading the view.
}

- (void)nextViewController{
    NextTwoViewController *nextViewController = [[NextTwoViewController alloc] init];
    [self.navigationController pushViewController:nextViewController animated:YES];
}

#pragma mark - NSUrlConnection delegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"即将接受输出");
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    NSString *dataSize= [NSString stringWithFormat:@"接收数据大小:%lu",(unsigned long)data.length];
    NSLog(@"%@",dataSize);
    [_recviceData appendData:data];
}

- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response{
    NSLog(@"即将发送请求");
    return request;
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse{
    NSLog(@"输出缓存");
    return cachedResponse;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSString *dataSize= [NSString stringWithFormat:@"总数据大小:%lu",(unsigned long)_recviceData.length];
    NSLog(@"%@",dataSize);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
