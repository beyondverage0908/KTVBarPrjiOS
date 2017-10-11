//
//  KTVPackageController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/14.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVPackageController.h"
#import "KTVBarKtvDetailHeaderCell.h"
#import "KTVIntroduceCell.h"
#import "KTVPackageDetailCell.h"
#import "KTVYuePaoUserCell.h"

#import "KTVTableHeaderView.h"

#import "KTVPackageDetailController.h"
#import "KTVOrderConfirmController.h"
#import "KTVShareFriendController.h"
#import "KTVSelectedBeautyController.h"

#import "KTVMainService.h"

@interface KTVPackageController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UILabel *moneyLabel;

@property (strong, nonatomic) NSMutableArray<KTVUser *> *selectedActivitorList; // 选中的暖场人
@property (strong, nonatomic) NSMutableArray<KTVUser *> *activitorList; // 暖场人列表
@property (assign, nonatomic) NSInteger activitorPage;      // 分页获取暖场人

@end

@implementation KTVPackageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择套餐";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor ktvBG];
    
    self.tableView.tableFooterView = [self tableViewFooter];
    
    [self initData];
    [self initUI];
    // 下载暖场人
    [self loadPageStoreActivitors];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self hideNavigationBar:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark - 初始化

- (void)initUI {
    self.moneyLabel.text = [NSString stringWithFormat:@"¥%@", [self getOrderMoney]];
}

- (void)initData {
    self.selectedActivitorList = [NSMutableArray array];
    self.activitorList = [NSMutableArray array];
}

#pragma mark - 网络

/// 分页获取门店暖场人
- (void)loadPageStoreActivitors {
    NSDictionary *params = @{@"storeId" : self.store.storeId,
                             @"size" : @"4",
                             @"currentPage" : @(self.activitorPage)};
    [KTVMainService getStorePageActivitors:params result:^(NSDictionary *result) {
        if (![result[@"code"] isEqualToString:ktvCode]) {
            [KTVToast toast:result[@"detail"]];
            return;
        }
        NSArray *activitorList = result[@"data"][@"activitorList"];
        if ([activitorList count]) {
            [self.activitorList removeAllObjects];
            ++self.activitorPage;
        } else {
            [KTVToast toast:TOAST_NOMORE_ACTIVITORS];
        }
        for (NSDictionary *dict in activitorList) {
            KTVUser *user = [KTVUser yy_modelWithDictionary:dict];
            [self.activitorList addObject:user];
        }
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationNone];
    }];
}

#pragma mark - UITableView Header Footer

- (UIView *)tableViewFooter {
    UIView *allBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 128)];
    
    UIView *aheadView = [[UIView alloc] init];
    [allBgView addSubview:aheadView];
    aheadView.backgroundColor = [UIColor ktvSeparateBG];
    [aheadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.and.top.equalTo(allBgView);
        make.height.mas_equalTo(@35);
    }];
    
    UIImageView *aheadImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainpage_all_bg_line"]];
    [aheadView addSubview:aheadImageView];
    [aheadImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.and.bottom.equalTo(aheadView);
        make.height.mas_equalTo(@29);
    }];
    
    UIButton *alertBtn = [[UIButton alloc] init];
    [aheadImageView addSubview:alertBtn];
    [alertBtn setBackgroundColor:[UIColor redColor]];
    [alertBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(aheadImageView).offset(10);
        make.width.height.equalTo(@10);
        make.centerY.equalTo(aheadImageView);
    }];
    
    UILabel *alertTimeLabel = [[UILabel alloc] init];
    [aheadImageView addSubview:alertTimeLabel];
    alertTimeLabel.text = @"周日(07-02) 14:00";
    alertTimeLabel.textColor = [UIColor ktvPurple];
    alertTimeLabel.font = [UIFont boldSystemFontOfSize:13];
    [alertTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(alertBtn.mas_right).offset(10);
        make.centerY.equalTo(aheadImageView);
    }];
    
    UILabel *alertLabel = [[UILabel alloc] init];
    [aheadImageView addSubview:alertLabel];
    alertLabel.text = @"钱可随时退，逾期不可退款";
    alertLabel.textColor = [UIColor ktvGray];
    alertLabel.font = [UIFont boldSystemFontOfSize:13];
    [alertLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(alertTimeLabel.mas_right).offset(10);
        make.centerY.equalTo(aheadImageView);
    }];
    
    UIImageView *downImageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainpage_all_bg_line"]];
    [allBgView addSubview:downImageview];
    downImageview.userInteractionEnabled = YES;
    [downImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(aheadView.mas_bottom);
        make.left.and.right.equalTo(allBgView);
        make.height.equalTo(@93);
    }];
    
    self.moneyLabel = [[UILabel alloc] init];
    [downImageview addSubview:self.moneyLabel];
    self.moneyLabel.text = @"¥0";
    self.moneyLabel.textColor = [UIColor ktvGold];
    self.moneyLabel.font = [UIFont boldSystemFontOfSize:25];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(downImageview).offset(10);
        make.centerY.equalTo(downImageview);
    }];
    
    UIButton *payBtn = [[UIButton alloc] init];
    [downImageview addSubview:payBtn];
    [payBtn setImage:[UIImage imageNamed:@"app_pay"] forState:UIControlStateNormal];
    payBtn.layer.cornerRadius = 6;
    payBtn.layer.masksToBounds = YES;
    [payBtn addTarget:self action:@selector(payAction:) forControlEvents:UIControlEventTouchUpInside];
    [payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(downImageview).offset(-10);
        make.centerY.equalTo(downImageview);
    }];
    
    return allBgView;
}

#pragma mark - 事件

- (void)payAction:(UIButton *)btn {
    CLog(@"--->>>套餐-立即支付");
    // 跳转到订单确认
    KTVOrderConfirmController *vc = (KTVOrderConfirmController *)[UIViewController storyboardName:@"MainPage" storyboardId:@"KTVOrderConfirmController"];
    vc.store = self.store;
    vc.packageList = [self getSelectedPackageList];
    vc.selectedActivitorList = self.selectedActivitorList;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 封装

- (void)setPackage:(KTVPackage *)package {
    _package = package;
    
    for (KTVPackage *pv in self.store.packageList) {
        if ([pv isEqual:_package]) {
            pv.isSelected = YES;
        }
    }
}

/// 获取当前选择套餐和暖场人的总价
- (NSString *)getOrderMoney {
    float price = 0;
    // 套餐价格
    for (KTVPackage *pk in [self getSelectedPackageList]) {
        price += pk.price.floatValue;
    }
    // 暖场人价格
    for (KTVUser *user in self.selectedActivitorList) {
        price += user.userDetail.price;
    }
    return @(price).stringValue;
}

/// 获取已经选中的套餐
- (NSArray *)getSelectedPackageList {
    NSMutableArray *packageList = [NSMutableArray array];
    for (KTVPackage *pk in self.store.packageList) {
        if (pk.isSelected) {
            [packageList addObject:pk];
        }
    }
    return packageList;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 225;
    } else if (indexPath.section == 1) {
        return 70;
    } else if (indexPath.section == 2) {
        return 50;
    } else if (indexPath.section == 3) {
        return 90;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:@"app_order_ding" title:@"座位信息" remark:nil];
        return headerView;
    } else if (section == 2) {
        KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:nil title:@"套餐详情" remark:nil];
        return headerView;
    } else if (section == 3) {
        KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:nil title:@"邀约TA暖场" headerImgUrl:@"app_change_batch" remarkUrl:@"app_arrow_right_hui" remark:nil];
        headerView.headerActionBlock = ^(KTVHeaderType type) {
            if (type == HeaderType) {
                CLog(@"--->>> 邀约TA暖床");
                [self loadPageStoreActivitors];
            }
        };
        headerView.bgActionBlock = ^(KTVHeaderType headerType) {
            if (headerType == BGType) {
                // 跳转邀约暖场人列表
                KTVSelectedBeautyController *vc = (KTVSelectedBeautyController *)[UIViewController storyboardName:@"MainPage" storyboardId:@"KTVSelectedBeautyController"];
                vc.store = self.store;
                vc.selectedActivitorList = self.selectedActivitorList;
                [self.navigationController pushViewController:vc animated:YES];
            }
        };
        return headerView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1 || section == 2 || section == 3) {
        return 28;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        // 套餐详情
        KTVPackageDetailController *vc = (KTVPackageDetailController *)[UIViewController storyboardName:@"MainPage" storyboardId:@"KTVPackageDetailController"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 1;
    } else if (section == 2) {
        return [self.store.packageList count];
    } else if (section == 3) {
        return [self.activitorList count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        KTVBarKtvDetailHeaderCell *cell = (KTVBarKtvDetailHeaderCell *)[tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVBarKtvDetailHeaderCell)];
        cell.store = self.store;
        cell.callback = ^() {
            KTVShareFriendController *vc = (KTVShareFriendController *)[UIViewController storyboardName:@"MainPage" storyboardId:@"KTVShareFriendController"];
            [self.navigationController pushViewController:vc animated:YES];
        };
        return cell;
    } else if (indexPath.section == 1) {
        KTVIntroduceCell *cell = (KTVIntroduceCell *)[tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVIntroduceCell)];
        return cell;
    } else if (indexPath.section == 2) {
        KTVPackageDetailCell *cell = (KTVPackageDetailCell *)[tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVPackageDetailCell)];
        KTVPackage *package = self.store.packageList[indexPath.row];
        cell.package = package;
        cell.selectCallback = ^(KTVPackage *package, BOOL isSelected) {
            self.moneyLabel.text = [NSString stringWithFormat:@"¥%@", [self getOrderMoney]];
        };
        return cell;
    } else if (indexPath.section == 3) {
        KTVYuePaoUserCell *cell = (KTVYuePaoUserCell *)[tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVYuePaoUserCell)];
        KTVUser *user = self.activitorList[indexPath.row];
        cell.user = user;
        cell.yueCallback = ^(KTVUser *user, BOOL isSelected) {
            if (isSelected) {
                CLog(@"--->>> 约了%@", user.nickName);
                [self.selectedActivitorList addObject:user];
            } else {
                CLog(@"--->>> 不约%@", user.nickName);
                [self.selectedActivitorList removeObject:user];
            }
            self.moneyLabel.text = [NSString stringWithFormat:@"¥%@", [self getOrderMoney]];
        };
        return cell;
    }
    return nil;
}


@end
