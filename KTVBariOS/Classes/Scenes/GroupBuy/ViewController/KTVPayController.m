//
//  KTVPayController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/31.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVPayController.h"
#import "KTVPaySuccessController.h"

#import "KTVPayCell.h"
#import "KTVTableHeaderView.h"

@interface KTVPayController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *bankPayBtn;
@property (weak, nonatomic) IBOutlet UILabel *hideActivityAnsLabel; // 隐藏本次活动说明

@end

@implementation KTVPayController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付订单";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor ktvBG];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 事件

- (IBAction)bankPayAction:(UIButton *)sender {
    CLog(@"-->> 银联支付");
    [sender setSelected:!sender.isSelected];
    if (sender.isSelected) {
        [sender setImage:[UIImage imageNamed:@"app_radius_gou"] forState:UIControlStateNormal];
    } else {
        [sender setImage:[UIImage imageNamed:@"app_radius_unselect"] forState:UIControlStateNormal];
    }
}

- (IBAction)alipayAction:(UIButton *)sender {
    
    [sender setSelected:!sender.isSelected];
    if (sender.isSelected) {
        [sender setImage:[UIImage imageNamed:@"app_radius_gou"] forState:UIControlStateNormal];
    } else {
        [sender setImage:[UIImage imageNamed:@"app_radius_unselect"] forState:UIControlStateNormal];
    }
    CLog(@"-->> 支付宝支付");
}

- (IBAction)wechatPayAction:(UIButton *)sender {
    CLog(@"-->> 微信支付");
    [sender setSelected:!sender.isSelected];
    if (sender.isSelected) {
        [sender setImage:[UIImage imageNamed:@"app_radius_gou"] forState:UIControlStateNormal];
    } else {
        [sender setImage:[UIImage imageNamed:@"app_radius_unselect"] forState:UIControlStateNormal];
    }
}

- (IBAction)confirmPayAction:(UIButton *)sender {
    CLog(@"-->> 确认支付出去");
    
    KTVPaySuccessController *vc = (KTVPaySuccessController *)[UIViewController storyboardName:@"MainPage" storyboardId:@"KTVPaySuccessController"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)hideActivityAction:(UIButton *)sender {
    CLog(@"-->> 隐藏本次活动");
    [sender setSelected:!sender.isSelected];
    if (sender.isSelected) {
        [sender setImage:[UIImage imageNamed:@"app_gou_red"] forState:UIControlStateNormal];
    } else {
        [sender setImage:[UIImage imageNamed:@"app_selected_kuang"] forState:UIControlStateNormal];
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 29.0f;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:@"app_order_dianpu" title:@"商家服务号" remark:nil];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110.0f;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        KTVPayCell *cell = (KTVPayCell *)[tableView dequeueReusableCellWithIdentifier:@"KTVPayCell"];
        return cell;
    }
    return nil;
}

@end
