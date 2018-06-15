//
//  KTVStoreUseOrderController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/12.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVStoreUseOrderController.h"

#import "KTVStoreOrderUseCell.h"
#import "KTVOrderStatusCell.h"
#import "KTVMainService.h"

@interface KTVStoreUseOrderController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) KTVOrder *parentOrder;

@end

@implementation KTVStoreUseOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor ktvBG];
    
    if (self.order.parentOrderId && self.order.parentOrderId.length) {
        [self getOrderWithOrderId:self.order.parentOrderId];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 网络

- (void)getOrderWithOrderId:(NSString *)orderId {
    [KTVMainService getOrder:orderId result:^(NSDictionary *result) {
        if ([result[@"code"] isEqualToString:ktvCode]) {
            if ([result[@"data"] count]) {
                self.parentOrder = [KTVOrder yy_modelWithDictionary:result[@"data"][0]];
                [self.tableView reloadData];
            }
        }
    }];
}

#pragma mark - 事件

// 隐藏本次活动
- (IBAction)hideActivityAction:(UIButton *)sender {
    CLog(@"-- 隐藏本次活动");

    [sender setSelected:!sender.isSelected];
    if (sender.isSelected) {
        [sender setImage:[UIImage imageNamed:@"app_gou_red"] forState:UIControlStateNormal];
    } else {
        [sender setImage:[UIImage imageNamed:@"app_selected_kuang"] forState:UIControlStateNormal];
    }
}

- (IBAction)submitModifiedInfoAction:(UIButton *)sender {
    CLog(@"-- 提交修改");
}

#pragma mark - UITableViewDelegate


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 120.0f;
    } else if (indexPath.section == 1) {
        return 184.0f;
    }
    return 0;
}

#pragma mark -  UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        if (self.parentOrder) {
            return 2;
        } else {
            return 1;
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        KTVStoreOrderUseCell *cell = [tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVStoreOrderUseCell)
                                                                   forIndexPath:indexPath];
        return cell;
    } else if (indexPath.section == 1) {
        KTVOrderStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVOrderStatusCell)
                                                                   forIndexPath:indexPath];
        if (self.parentOrder) {
            if (indexPath.row == 0) {
                cell.order = self.parentOrder;
            } else {
                cell.order = self.order;
            }
        } else {
            cell.order = self.order;
        }
        return cell;
    }
    return [UITableViewCell new];
}

@end
