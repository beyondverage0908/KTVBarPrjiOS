//
//  KTVOrderUploadController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/30.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVOrderUploadController.h"
#import "KTVShareFriendController.h"
#import "KTVPayController.h"

#import "KTVOrderUploadCell.h"


@interface KTVOrderUploadController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *allMoneyLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomBgView;

@end

@implementation KTVOrderUploadController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提交订单";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor ktvBG];
    self.bottomBgView.backgroundColor = [UIColor ktvBG];
    
    NSString *allMoney = [self getOrderAllMoney];
    
    self.allMoneyLabel.text = [NSString stringWithFormat:@"¥%@", allMoney];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 封装

- (NSString *)getOrderAllMoney {
    NSInteger groupbuyTotalPrice = [self.orderUploadDictionary[@"groupbuyTotalPrice"] integerValue]; // 套餐基础价格
    NSArray *yueUserDetails = self.orderUploadDictionary[@"userOrderDetails"];
    NSInteger money = 0;
    for (NSDictionary *dict in yueUserDetails) {
        money += [dict[@"price"] integerValue];
    }
    money += groupbuyTotalPrice;
    
    return @(money).stringValue;
}

#pragma mark - 事件

- (IBAction)endPayAction:(UIButton *)sender {
    CLog(@"-->> 结账");
    KTVPayController *vc = (KTVPayController *)[UIViewController storyboardName:@"MainPage" storyboardId:@"KTVPayController"];
    vc.orderUploadDictionary = self.orderUploadDictionary;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)shareAction:(UIButton *)sender {
    CLog(@"-->> 转发");
    KTVShareFriendController *vc = (KTVShareFriendController *)[UIViewController storyboardName:@"MainPage" storyboardId:@"KTVShareFriendController"];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 110.0f;
    }
    return 0;
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        KTVOrderUploadCell *cell = (KTVOrderUploadCell *)[tableView dequeueReusableCellWithIdentifier:@"KTVOrderUploadCell"];
        return cell;
    }
    return nil;
}

@end
