//
//  KTVGroupBuyDetailController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/21.
//  Copyright © 2017年 Lin. All rights reserved.
//
//  团购详情

#import "KTVGroupBuyDetailController.h"
#import "KTVGroupBuyHeaderCell.h"
#import "KTTimeFilterCell.h"
#import "KTVPositionFilterCell.h"
#import "KTVBarKtvBeautyCell.h"
#import "KTVYuePaoUserCell.h"
#import "KTVBuyNotesCell.h"
#import "KTVDoBusinessCell.h"
#import "KTVOtherDianpuCell.h"
#import "KTVTableHeaderView.h"

#import "KTVDandianController.h"


@interface KTVGroupBuyDetailController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation KTVGroupBuyDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - UITableViewDelegate


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 220.0f;
    } else if (indexPath.section == 1) {
        return 50.0f;
    } else if (indexPath.section == 2) {
        return 145.0f;
    } else if (indexPath.section == 3) {
        return 90.0f;
    } else if (indexPath.section == 4) {
        return 133.0f;
    } else if (indexPath.section == 5) {
        return 40.0f;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1 || section == 2 || section == 3 || section == 4 || section == 5) {
        return 29.0f;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:@"app_order_tuan" title:@"团购" remark:@"2946人订过"];
        return headerView;
    } else if (section == 2) {
        KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:nil title:@"活动详情" remark:nil];
        return headerView;
    } else if (section == 3) {
        KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:nil title:@"邀约TA暖场" headerImgUrl:@"app_change_batch" remark:nil];
        headerView.headerActionBlock = ^(UIButton *btn) {
            CLog(@"--->>> 邀约TA暖床");
        };
        return headerView;
    } else if (section == 4) {
        KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:nil title:@"购买须知" remark:nil];
        return headerView;
    } else if (section == 5) {
        KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:nil title:@"商家详情" remark:nil];
        return headerView;
    } else {
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        KTVDandianController *vc = (KTVDandianController *)[UIViewController storyboardName:@"MainPage" storyboardId:@"KTVDandianController"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1){
        return 2;
    } else if (section == 2) {
        return 1;
    } else if (section == 3) {
        return 4;
    } else if (section == 4) {
        return 1;
    } else if (section == 5) {
        return 2;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        KTVGroupBuyHeaderCell *cell = (KTVGroupBuyHeaderCell *)[tableView dequeueReusableCellWithIdentifier:@"KTVGroupBuyHeaderCell"];
        return cell;
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            NSString *KTTimeFilterCellIdentifer = @"KTTimeFilterCell";
            KTTimeFilterCell *cell = [tableView dequeueReusableCellWithIdentifier:KTTimeFilterCellIdentifer];
            if (!cell) {
                cell = [[KTTimeFilterCell alloc] initWithItems:@[@"今天;06-28",
                                                                 @"周四;06-29",
                                                                 @"周五;06-30",
                                                                 @"周六;07-01",
                                                                 @"周日;07-02",
                                                                 @"周一;07-03",
                                                                 @"周二;07-04",
                                                                 @"周三;07-05"]
                                               reuseIdentifier:KTTimeFilterCellIdentifer];
            }
            return cell;
        } else {
            NSString *KTVPositionFilterCellIdentifier = @"KTVPositionFilterCell";
            KTVPositionFilterCell *cell = [tableView dequeueReusableCellWithIdentifier:KTVPositionFilterCellIdentifier];
            if (!cell) {
                cell = [[KTVPositionFilterCell alloc] initWithPositionFilterItems:@[@"13:00~18:00",
                                                                                    @"18:00~20:00",
                                                                                    @"20:00~23:00",
                                                                                    @"23:00~01:00",
                                                                                    @"01:00~07:00",
                                                                                    @"07:00~13:00"]
                                                                  reuseIdentifier:KTVPositionFilterCellIdentifier];
            }
            return cell;
        }
    } else if (indexPath.section == 2) {
        KTVBarKtvBeautyCell *cell = (KTVBarKtvBeautyCell *)[tableView dequeueReusableCellWithIdentifier:@"KTVBarKtvBeautyCell"];
        return cell;
    } else if (indexPath.section == 3) {
        KTVYuePaoUserCell *cell = (KTVYuePaoUserCell *)[tableView dequeueReusableCellWithIdentifier:@"KTVYuePaoUserCell"];
        return cell;
    } else if (indexPath.section == 4) {
        KTVBuyNotesCell *cell = (KTVBuyNotesCell *)[tableView dequeueReusableCellWithIdentifier:@"KTVBuyNotesCell"];
        return cell;
    } else if (indexPath.section == 5) {
        if (indexPath.row == 0) {
            KTVDoBusinessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KTVDoBusinessCell"];
            return cell;
        } else {
            KTVOtherDianpuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KTVOtherDianpuCell"];
            return cell;
        }
    }
    return 0;
}

@end
