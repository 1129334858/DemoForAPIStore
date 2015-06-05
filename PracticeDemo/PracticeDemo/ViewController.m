//
//  ViewController.m
//  PracticeDemo
//
//  Created by 123 on 15-6-1.
//  Copyright (c) 2015年 杨魏. All rights reserved.
//

#import "ViewController.h"
#import "Constant.h"
#import "UIViewController+specialNav.h"
#import "NextOneViewController.h"
#import "ShareViewController.h"
#import "NWGetNews.h"
#import "NewDetailModel.h"
#import "NewsCell.h"
#import "NewDetailViewController.h"

@interface ViewController ()
{
    UILabel *_label;
    BOOL upOrdown;
    NSInteger num;
    NSTimer *timer;
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    NSOperationQueue *_getHttpData;
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigationTitle:@"网易新闻"];
    [self createNavigationRightButton:@"next" imageName:nil selector:@selector(nextController)];
    [self createNavigationLeftButton:@"other" imageName:nil selector:@selector(shareController)];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _label = [[UILabel alloc] initWithFrame:CGRectMake(KScreenWidth/2-200/2, 100, 200, 1)];
    _label.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_label];
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
    [self getData];
    
    NSLog(@"线程:%@",[NSThread currentThread]);
//    NSInvocationOperation *getdata = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(getData) object:nil];
//    _getHttpData = [[NSOperationQueue alloc] init];
//    [_getHttpData addOperation:getdata];
    
//    NWGetNews *list = [[NWGetNews alloc] init];
//    list.complete = ^(id result,BOOL succ){
//    };
//    [list startRequestForNew];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)shareController{
    ShareViewController *shareVc = [[ShareViewController alloc] init];
    [self.navigationController pushViewController:shareVc animated:YES];
}

- (void)nextController{
    NextOneViewController *nextOneVc = [[NextOneViewController alloc] init];
    [self.navigationController pushViewController:nextOneVc animated:YES];
}

- (void)animation1{
    if (upOrdown == NO) {
        num ++;
        NSInteger h = 200;
        if (KScreenWidth>320) {
            _label.frame = CGRectMake(KScreenWidth/2-300/2, 120+2*num, 300, 1);
            h=200;
        }
        _label.frame = CGRectMake(KScreenWidth/2-200/2, 65+2*num, 200, 1);
        if (2*num == h) {
            upOrdown = YES;
        }
    }else {
        num --;
        if (KScreenWidth>320) {
            _label.frame = CGRectMake(KScreenWidth/2-300/2, 120+2*num, 300, 1);
        }
        _label.frame = CGRectMake(KScreenWidth/2-200/2, 65+2*num, 200, 1);
        if (num == 0) {
            upOrdown = NO;
        }
    }
}

- (void)getData{
    NSURL *url = [NSURL URLWithString:@"http://apis.baidu.com/yi18/news/list?page=1&limit=20&type=id&id=null"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"84bc9cdd16d30a0b96a80c459be1ddb9" forHTTPHeaderField:@"apikey"];
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSLog(@"当前线程：%@",[NSThread currentThread]);
        
        _dataArray = [NewDetailModel arrayOfModelsFromDictionaries:dic[@"yi18"] error:nil];
        if (_dataArray) {
            [self setUpUi];
        }
//        [self performSelectorOnMainThread:@selector(setUpUi) withObject:nil waitUntilDone:YES];
        
    }];
}

- (void)setUpUi{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, KScreenWidth, KScreenHeight - 64.0)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[NewsCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
}

#pragma mark - tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NewDetailModel *model = [_dataArray objectAtIndex:indexPath.row];
    [cell insertDataWithModel:model];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewDetailViewController *newDetailVc = [[NewDetailViewController alloc] init];
    newDetailVc.model = [_dataArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:newDetailVc animated:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        [_dataArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
