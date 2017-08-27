//
//  KTVPackageDetailController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/24.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVPackageDetailController.h"

#import "KTVPackageDetailHeaderCell.h"
#import "KTVPackageDetailCareCell.h"
#import "KTVBuyNotesCell.h"
#import "KTVPackageUserSelectedCell.h"

#import "KTVTableHeaderView.h"

@interface KTVPackageDetailController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation KTVPackageDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"套餐详情";
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 220.0f;
    } else if (indexPath.section == 1) {
        return 145.0f;
    } else if (indexPath.section == 2) {
        return 95.0f;
    } else if (indexPath.section == 3) {
        return 133.0f;
    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1 || section == 2 || section == 3) {
        return 29;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:nil title:@"套餐" remark:@"234567订过"];
        return headerView;
    } else if (section == 2) {
        KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:nil title:@"注意事项" remark:nil];
        return headerView;
    } else if (section == 3) {
        KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:nil title:@"购买须知" remark:nil];
        return headerView;
    }
    return nil;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        KTVPackageDetailHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KTVPackageDetailHeaderCell"];
        return cell;
    } else if (indexPath.section == 1) {
        static NSString *identifier = @"KTVPackageUserSelectedCell";
        KTVPackageUserSelectedCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            NSMutableArray *goods = [NSMutableArray arrayWithCapacity:3];
            for (NSInteger i = 0; i < 3; i++) {
                NSDictionary *dic = @{@"goodsName" : @"皇家礼炮套餐",
                                      @"goodsNumber" : @"2瓶",
                                      @"goodsMoney" : @"2000"};
                [goods addObject:dic];
            }
            NSDictionary *dic = @{@"goodsNumber" : @"总价值",
                                  @"goodsMoney" : @"6000元"};
            [goods addObject:dic];
            NSDictionary *freedic = @{@"goodsNumber" : @"总价值",
                                  @"goodsMoney" : @"5000元"};
            [goods addObject:freedic];
            cell = [[KTVPackageUserSelectedCell alloc] initBuyGoods:goods reuseIdentifier:identifier];
        }
        return cell;
    } else if (indexPath.section == 2) {
        KTVPackageDetailCareCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KTVPackageDetailCareCell"];
        return cell;
    } else if (indexPath.section == 3) {
        KTVBuyNotesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KTVBuyNotesCell"];
        return cell;
    }
    return [UITableViewCell new];
}



@end
