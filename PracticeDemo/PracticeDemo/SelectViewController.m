//
//  SelectViewController.m
//  PracticeDemo
//
//  Created by 123 on 15-6-2.
//  Copyright (c) 2015年 杨魏. All rights reserved.
//

#import "SelectViewController.h"
#import "UIViewController+specialNav.h"
#import "Constant.h"
#import "NewDetailModel.h"

@interface SelectViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
}
@end

#define dataArray @[@"广东省",@"北京市",@"天津市",@"河北省",@"黑龙江",@"上海市",@"江苏省",@"浙江省",@"安徽省",@"江西省",@"湖北省",@"湖南省",@"广西省",@"四川省",@"云南省",@"藏",@"陕",@"甘",@"青",@"宁",@"新",@"港",@"澳",@"台"]

@implementation SelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUi];
    [self getData];
    [self createNavigationTitle:@"就业城市"];
    [self createNavigationLeftButton:@"返回" imageName:nil selector:@selector(back)];
    // Do any additional setup after loading the view.
}

- (void)getData{
    NSURL *url = [NSURL URLWithString:@"http://apis.baidu.com/yi18/news/list?page=1&limit=20&type=id&id=null"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"84bc9cdd16d30a0b96a80c459be1ddb9" forHTTPHeaderField:@"apikey"];
    
   [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//       NSString *jsonData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
       
       NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
       NSLog(@"\n返回数据:%@",dic);
       [self parseJsonData:dic];
    }];
}

- (void)parseJsonData:(NSDictionary*)result{
    NSArray *array = [NewDetailModel arrayOfModelsFromDictionaries:result[@"yi18"] error:nil];
    if (array) {
        for (NewDetailModel *model in array) {
            NSLog(@"\n标题:%@",model.title);
        }
    }
    NSLog(@"array count:%lu",(unsigned long)array.count);
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setUpUi{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, KScreenWidth, KScreenHeight-64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

#pragma mark - tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [dataArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_selectBlock) {
        _selectBlock([dataArray objectAtIndex:indexPath.row]);
        [self.navigationController popViewControllerAnimated:YES];
    }
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
