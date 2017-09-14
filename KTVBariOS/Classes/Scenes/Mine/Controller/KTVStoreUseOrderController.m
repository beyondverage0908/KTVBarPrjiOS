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

@interface KTVStoreUseOrderController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation KTVStoreUseOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"待使用订单";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor ktvBG];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
        return 2;
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
        return cell;
    }
    return [UITableViewCell new];
}

@end
