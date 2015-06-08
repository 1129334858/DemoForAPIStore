//
//  NewDetailViewController.m
//  PracticeDemo
//
//  Created by 123 on 15-6-5.
//  Copyright (c) 2015年 杨魏. All rights reserved.
//

#import "NewDetailViewController.h"
#import "NewDetailInfoModel.h"
#import "TitleCell.h"
#import "ContentCell.h"
#import "BottomCell.h"

@interface NewDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NewDetailInfoModel *_newInfoModel;
}
@end

@implementation NewDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigationTitle:_model.title];
    [self getData:_model.id];
    // Do any additional setup after loading the view.
}

- (void)getData:(NSString*)Newid{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://apis.baidu.com/yi18/news/detail?id=%@",Newid]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    [request addValue:@"84bc9cdd16d30a0b96a80c459be1ddb9" forHTTPHeaderField:@"apikey"];
    [request setHTTPMethod:@"GET"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSLog(@"返回数据:%@",dic);
        if (dic) {
            _newInfoModel = [[NewDetailInfoModel alloc] initWithDictionary:dic[@"yi18"] error:nil];
            [self setUpUi];
        }
    }];
}

- (void)setUpUi{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, KScreenWidth, KScreenHeight-64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[TitleCell class] forCellReuseIdentifier:@"title"];
    [_tableView registerClass:[ContentCell class] forCellReuseIdentifier:@"content"];
    [_tableView registerClass:[BottomCell class] forCellReuseIdentifier:@"bottom"];
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        CGSize size = [_newInfoModel.title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20.0f]}];
        if (size.width>KScreenWidth-40) {
            return 90;
        }else{
            return 60;
        }
    }else if(indexPath.row==1){
        CGSize size = [_newInfoModel.message sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0f]}];
        return (size.width/(KScreenWidth-30))*90;
    }else{
        return 60;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    if (indexPath.row==0) {
        TitleCell *titleCell = [tableView dequeueReusableCellWithIdentifier:@"title" forIndexPath:indexPath];
        [titleCell insertDataWithModel:_newInfoModel.title time:_newInfoModel.time author:_newInfoModel.author];
        titleCell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell = titleCell;
    }else if (indexPath.row==1){
        ContentCell *contentCell = [tableView dequeueReusableCellWithIdentifier:@"content" forIndexPath:indexPath];
        [contentCell insertDataWithContent:_newInfoModel.message];
        contentCell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell = contentCell;
    }else{
        BottomCell *bottomCell = [tableView dequeueReusableCellWithIdentifier:@"bottom" forIndexPath:indexPath];
        bottomCell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell = bottomCell;
    }
    return cell;
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
