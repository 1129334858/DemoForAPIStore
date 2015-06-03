//
//  NextTwoViewController.m
//  PracticeDemo
//
//  Created by 123 on 15-6-2.
//  Copyright (c) 2015年 杨魏. All rights reserved.
//

#import "NextTwoViewController.h"
#import "UIViewController+specialNav.h"
//#import "Constant.h"
#import "FirstCell.h"
#import "SecondCell.h"
#import "SelectCell.h"
#import "SelectViewController.h"

@interface NextTwoViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    BOOL _isOn;
    BOOL _threeIsOn;
}
@end

@implementation NextTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _isOn = true;
    _threeIsOn = true;
    [self setUpUi];
    [self createNavigationTitle:@"2015届毕业状况信息采集"];
    [self createNavigationLeftButton:@"返回" imageName:nil selector:@selector(back)];
    _dataArray = [NSMutableArray arrayWithObjects:@[@"姓名",@"籍贯",@"政治面貌",@"英语水平",@"专业"],@[@"是否毕业",@"毕业院校"],@[@"是否就业",@"实习",@"转正"],@[@"就业城市"], nil];
    // Do any additional setup after loading the view.
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setUpUi{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, KScreenWidth, KScreenHeight-64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[FirstCell class] forCellReuseIdentifier:@"firCell"];
    [_tableView registerClass:[SecondCell class] forCellReuseIdentifier:@"secCell"];
    [_tableView registerClass:[SelectCell class] forCellReuseIdentifier:@"selectCell"];
    
    [self.view addSubview:_tableView];
}

#pragma mark - tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==1) {
        if (_isOn) {
            return [[_dataArray objectAtIndex:section] count];
        }else{
            return 1;
        }
    }else if (section==2){
        if (_threeIsOn) {
            return [[_dataArray objectAtIndex:section] count];
        }else{
            return 1;
        }
    }else{
        return [[_dataArray objectAtIndex:section] count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==3) {
        return 40;
    }else{
        return 20;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    if (indexPath.section==0) {
        FirstCell *firCell = [tableView dequeueReusableCellWithIdentifier:@"firCell" forIndexPath:indexPath];
        firCell.label.text = [[_dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        firCell.selectionStyle = UITableViewCellSelectionStyleNone;
        firCell.textField.delegate = self;
        cell = firCell;
    }else if (indexPath.section==1){
        if (indexPath.row==0) {
            SecondCell *secCell = [tableView dequeueReusableCellWithIdentifier:@"secCell" forIndexPath:indexPath];
            secCell.label.text = [[_dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            secCell.selectionStyle = UITableViewCellSelectionStyleNone;
            secCell.switOn = ^(BOOL isOn){
                _isOn = isOn;
                [self switchOnOrOff];
            };
            cell = secCell;
        }else{
            FirstCell *firCell = [tableView dequeueReusableCellWithIdentifier:@"firCell" forIndexPath:indexPath];
            firCell.label.text = [[_dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            firCell.selectionStyle = UITableViewCellSelectionStyleNone;
            firCell.textField.delegate = self;
            cell = firCell;
        }
    }else if (indexPath.section==2){
        if (indexPath.row==0) {
            SecondCell *secCell = [tableView dequeueReusableCellWithIdentifier:@"secCell" forIndexPath:indexPath];
            secCell.label.text = [[_dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            secCell.selectionStyle = UITableViewCellSelectionStyleNone;
            secCell.switOn = ^(BOOL isOn){
                _threeIsOn = isOn;
                [self switchOnOrOff];
            };
            cell = secCell;
        }else{
            FirstCell *firCell = [tableView dequeueReusableCellWithIdentifier:@"firCell" forIndexPath:indexPath];
            firCell.label.text = [[_dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            firCell.selectionStyle = UITableViewCellSelectionStyleNone;
            firCell.textField.delegate = self;
            cell = firCell;
        }
    }else{
        SelectCell *firCell = [tableView dequeueReusableCellWithIdentifier:@"selectCell" forIndexPath:indexPath];
        firCell.label.text = [[_dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        firCell.selectionStyle = UITableViewCellSelectionStyleNone;
        firCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell = firCell;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==3) {
        if (indexPath.row==0) {
            SelectViewController *selectVc = [[SelectViewController alloc] init];
            selectVc.selectBlock = ^(NSString *text){
                SelectCell *cell = (SelectCell*)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:3]];
                cell.addLabel.text = text;
            };
            [self.navigationController pushViewController:selectVc animated:YES];
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIButton *btn;
    if (section==3) {
        btn = [[UIButton alloc] initWithFrame:CGRectMake(30, 0.0, KScreenWidth-60, 40)];
        [btn setTitle:@"提交" forState:UIControlStateNormal];
        [btn setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
        [btn setBackgroundColor:RGB(100, 100, 100)];
        btn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    }
    return btn;

}

- (void)switchOnOrOff{
    [_tableView reloadData];
}

#pragma mark - textField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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
