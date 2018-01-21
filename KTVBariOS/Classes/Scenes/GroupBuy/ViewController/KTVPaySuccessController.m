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
#import "KTVBeeCateCell.h"
#import "KTVPaySuccessShowCell.h"
#import "KTVPayEndCell.h"
#import "KTVPayMoneyCell.h"
#import "KTVSelectedBeautyController.h"

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
    self.view.backgroundColor = [UIColor ktvBG];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"KTVBeeCateCell" bundle:nil] forCellReuseIdentifier:@"KTVBeeCateCell"];
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

- (IBAction)completedPayAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 29.0f;
    } else if (section == 1) {
        return 30.0f;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:@"app_order_dianpu" title:@"商家服务号" remark:nil];
        return headerView;
    } else if (section == 1) {
        KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:nil title:@"邀约TA暖场" headerImgUrl:@"app_change_batch" remarkUrl:@"app_arrow_right_hui" remark:nil];
        headerView.headerActionBlock = ^(KTVHeaderType type) {
            if (type == HeaderType) {
                CLog(@"--->>> 邀约TA暖床");
                //[self loadPageStoreActivitors];
            }
        };
        headerView.bgActionBlock = ^(KTVHeaderType headerType) {
            if (headerType == BGType) {
                // 跳转邀约暖场人列表
                KTVSelectedBeautyController *vc = (KTVSelectedBeautyController *)[UIViewController storyboardName:@"MainPage" storyboardId:@"KTVSelectedBeautyController"];
                vc.store = self.store;
                [self.navigationController pushViewController:vc animated:YES];
            }
        };
        return headerView;
    }
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 110.0f;
        } else if (indexPath.row == 1) {
            return 140.0f;
        } else if (indexPath.row == 2) {
            return 130;
        }
        return 0;
    } else if (indexPath.section == 1) {
        return 99.0f;
    } else if (indexPath.section == 2) {
        return 80.0f;
    }
    return 0;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    } else if (section == 1) {
        return 5;
    } else if (section == 2) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            KTVPayCell *cell = (KTVPayCell *)[tableView dequeueReusableCellWithIdentifier:@"KTVPayCell"];
            cell.allMoney = self.payedMoney;
            return cell;
        } else if (indexPath.row == 1) {
            KTVPaySuccessShowCell *cell = (KTVPaySuccessShowCell *)[tableView dequeueReusableCellWithIdentifier:@"KTVPaySuccessShowCell"];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"KTVPaySuccessShowCell" owner:self options:nil] lastObject];
            }
            return cell;
        } else {
            KTVPayEndCell *cell = (KTVPayEndCell *)[tableView dequeueReusableCellWithIdentifier:@"KTVPayEndCell"];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"KTVPayEndCell" owner:self options:nil] lastObject];
            }
            cell.completedCallback = ^{
                [self.navigationController popViewControllerAnimated:YES];
            };
            cell.startPinZhuoCallback = ^{
                KTVStartYueController *vc = (KTVStartYueController *)[UIViewController storyboardName:@"MainPage" storyboardId:@"KTVStartYueController"];
                [self.navigationController pushViewController:vc animated:YES];
            };
            return cell;
        }
    } else if (indexPath.section == 1) {
        KTVBeeCateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KTVBeeCateCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"KTVBeeCateCell" owner:self options:nil] lastObject];
        }
        return cell;
    } else if (indexPath.section == 2) {
        KTVPayMoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KTVPayMoneyCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"KTVPayMoneyCell" owner:self options:nil] lastObject];
        }
        cell.payMoneyAction = ^(double money) {
            CLog(@"-- >> 付款");
        };
        return cell;
    }
    return [UITableViewCell new];
}


@end

