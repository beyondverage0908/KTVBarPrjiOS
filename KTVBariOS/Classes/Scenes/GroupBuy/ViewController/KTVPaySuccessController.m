//
//  KTVPaySuccessController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/31.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVPaySuccessController.h"
#import "KTVStartYueController.h"

#import "KTVPayCell.h"
#import "KTVTableHeaderView.h"

@interface KTVPaySuccessController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation KTVPaySuccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付完成";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor ktvBG];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - 事件

- (IBAction)startPingZhuoAction:(UIButton *)sender {
    CLog(@"-->> 发起拼桌活动");
    
    KTVStartYueController *vc = (KTVStartYueController *)[UIViewController storyboardName:@"MainPage" storyboardId:@"KTVStartYueController"];
    [self.navigationController pushViewController:vc animated:YES];
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
        cell.allMoney = self.payedMoney;
        return cell;
    }
    return nil;
}


@end
