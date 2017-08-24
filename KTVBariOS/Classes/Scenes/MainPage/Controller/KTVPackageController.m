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

@interface KTVPackageController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation KTVPackageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.tableFooterView = [self tableViewFooter];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self hideNavigationBar:NO];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
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
    
    UILabel *moneyLabel = [[UILabel alloc] init];
    [downImageview addSubview:moneyLabel];
    moneyLabel.text = @"¥1024";
    moneyLabel.textColor = [UIColor ktvGold];
    moneyLabel.font = [UIFont boldSystemFontOfSize:25];
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
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

#pragma mark - UIControl Event

- (void)payAction:(UIButton *)btn {
    CLog(@"--->>>支付");
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
        KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:nil title:@"邀请她暖场" remark:nil];
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
        return 3;
    } else if (section == 3) {
        return 3;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        KTVBarKtvDetailHeaderCell *cell = (KTVBarKtvDetailHeaderCell *)[tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVBarKtvDetailHeaderCell)];
        return cell;
    } else if (indexPath.section == 1) {
        KTVIntroduceCell *cell = (KTVIntroduceCell *)[tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVIntroduceCell)];
        return cell;
    } else if (indexPath.section == 2) {
        KTVPackageDetailCell *cell = (KTVPackageDetailCell *)[tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVPackageDetailCell)];
        return cell;
    } else if (indexPath.section == 3) {
        KTVYuePaoUserCell *cell = (KTVYuePaoUserCell *)[tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVYuePaoUserCell)];
        return cell;
    }
    return nil;
}


@end
