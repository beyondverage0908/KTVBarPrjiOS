//
//  KTVBarKtvDetailController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/12.
//  Copyright © 2017年 Lin. All rights reserved.
//
//  酒吧，KTV店铺详情

#import "KTVBarKtvDetailController.h"

#import "KTVBarKtvDetailHeaderCell.h"
#import "KTTimeFilterCell.h"
#import "KTVPositionFilterCell.h"
#import "KTVPackageCell.h"
#import "KTVBarKtvReserveCell.h"
#import "KTVBarKtvBeautyCell.h"
#import "KTVCommentCell.h"
#import "KTVTableHeaderView.h"
#import "KTVDoBusinessCell.h"
#import "KTVOtherDianpuCell.h"

#import "KTVPackageController.h"

@interface KTVBarKtvDetailController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation KTVBarKtvDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self customRightBarItems];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self hideNavigationBar:NO];
    
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self hideNavigationBar:YES];

    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
}

- (void)navigationBackAction:(id)action {
    [self hideNavigationBar:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)customRightBarItems {
    UIBarButtonItem *firstItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"app_order_share"]
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(firstRightBarItemAction:)];
    UIBarButtonItem *secondItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"app_order_shouchang"]
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(secondRightBarItemAction:)];
    self.navigationItem.rightBarButtonItems = @[firstItem, secondItem];
}

- (void)firstRightBarItemAction:(id)sender {
    CLog(@"-->> 订单分享");
}

- (void)secondRightBarItemAction:(id)sender {
    CLog(@"-->> 订单分享");
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 225;
    } else if (indexPath.section == 1) {
        return 50;
    } else if (indexPath.section == 2) {
        return 50;
    } else if (indexPath.section == 3) {
        return 145;
    } else if (indexPath.section == 4) {
        return 185;
    } else if (indexPath.section == 5) {
        return 40;
    }else {
        return 50;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:@"app_order_ding" title:@"预定" remark:@"2946人订过"];
        return headerView;
    } else if (section == 2) {
        KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:@"app_order_tuan" title:@"团购(2)" remark:nil];
        return headerView;
    } else if (section == 3) {
        KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:nil title:@"活动详情" remark:nil];
        return headerView;
    } else if (section == 4) {
        KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:nil title:@"点评" remark:@"2445条评论"];
        return headerView;
    } else if (section == 5) {
        KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:nil title:@"商家详情" remark:nil];
        return headerView;
    } else {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1 || section == 2 || section == 3 || section == 4 || section == 5) {
        return 28;
    } else {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 4) {
        return [self commentFooterView];
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 4) {
        return 44;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {    
    if (indexPath.section == 2) {
        KTVPackageController *vc = (KTVPackageController *)[UIViewController storyboardName:@"MainPage" storyboardId:@"KTVPackageController"];
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
    } else if (section == 1) {
        return 4;
    } else if (section == 2) {
        return 4;
    } else if (section == 3) {
        return 1;
    } else if (section == 4) {
        return 3;
    } else if (section == 5) {
        return 2;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        KTVBarKtvDetailHeaderCell *cell = (KTVBarKtvDetailHeaderCell *)[tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVBarKtvDetailHeaderCell)];
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
        } else if (indexPath.row == 1) {
            NSString *KTVPositionFilterCellIdentifier = @"KTVPositionFilterCell";
            KTVPositionFilterCell *cell = [tableView dequeueReusableCellWithIdentifier:KTVPositionFilterCellIdentifier];
            if (!cell) {
                cell = [[KTVPositionFilterCell alloc] initWithPositionFilterItems:@[@"卡座(4-6人)",
                                                                                    @"VIP位置(8-10人)",
                                                                                    @"吧台¥(4-6人)",
                                                                                    @"包厢(15-20人)",
                                                                                    @"阳台(1-2人)",
                                                                                    @"沙发(2-3人)",
                                                                                    @"床上(2人)",]
                                                                  reuseIdentifier:KTVPositionFilterCellIdentifier];
            }
            return cell;
        } else {
            KTVBarKtvReserveCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KTVBarKtvReserveCell"];
            return cell;
        }
        
    } else if (indexPath.section == 2) {
        KTVPackageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KTVPackageCell"];
        return cell;
    } else if (indexPath.section == 3) {
        KTVBarKtvBeautyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KTVBarKtvBeautyCell"];
        return cell;
    } else if (indexPath.section == 4) {
        KTVCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KTVCommentCell"];
        return cell;
    } else if (indexPath.section == 5) {
        if (indexPath.row == 0) {
            KTVDoBusinessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KTVDoBusinessCell"];
            return cell;
        } else {
            KTVOtherDianpuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KTVOtherDianpuCell"];
            return cell;
        }
    } else {
        return nil;
    }
    
}

#pragma mark - 自定义方法

- (UIView *)commentFooterView {
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor ktvSeparateBG];
    
    UIView *topView = [[UIView alloc] init];
    [bgView addSubview:topView];
    bgView.backgroundColor = [UIColor ktvBG];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.and.right.equalTo(bgView);
        make.height.equalTo(@(38));
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [topView addSubview:titleLabel];
    titleLabel.text = @"查看全部评论";
    titleLabel.font = [UIFont boldSystemFontOfSize:14];
    titleLabel.textColor = [UIColor ktvRed];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView).offset(10);
        make.centerY.equalTo(topView);
    }];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_arrow_right_hui"]];
    [topView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topView);
        make.right.equalTo(topView).offset(-10);
    }];
    
    UIView *bottomLine = [[UIView alloc] init];
    [bgView addSubview:bottomLine];
    bottomLine.backgroundColor = [UIColor ktvSeparateBG];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.and.right.equalTo(bgView);
        make.height.equalTo(@7);
    }];
    
    return bgView;
}

@end
