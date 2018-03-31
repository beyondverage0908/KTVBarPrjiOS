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
#import "KTVMainService.h"
#import "KTVBuyService.h"
#import "KTVPayManager.h"

@interface KTVPaySuccessController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (assign, nonatomic) NSInteger activitorPage;
@property (strong, nonatomic) NSMutableArray *activitorList;
@property (strong, nonatomic) NSMutableArray *selectedActivitorList;

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
    
    self.activitorList = [NSMutableArray array];
    self.selectedActivitorList = [NSMutableArray array];
    
    [self loadPageStoreActivitors];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - 自定义方法

- (double)activitySelectedMoney {
    double money = 0;
    for (KTVUser *ur in self.selectedActivitorList) {
        money += ur.userDetail.price;
    }
    return money;
}

- (NSMutableDictionary *)configrationWarmerOrderInfo {
    NSMutableDictionary *orderDict = [NSMutableDictionary dictionary];
    
    [orderDict setObject:@(self.payType) forKey:@"payType"];
    [orderDict setObject:@"暖场人订单" forKey:@"description"];
    if (self.parentOrderNum) {
        [orderDict setObject:self.parentOrderNum forKey:@"parentOrderNum"];
    }
    
    NSMutableArray *userOrderDetails = [NSMutableArray array];
    for (KTVUser *user in self.selectedActivitorList) {
        NSDictionary *dict = @{@"sourceId" : @(user.userId.integerValue),
                               @"price" : @(user.userDetail.price),
                               @"orderType" : @(user.userDetail.type),
                               @"count" : @(1),
                               @"discount" : @(100)};
        [userOrderDetails addObject:dict];
    }
    [orderDict setObject:userOrderDetails forKey:@"userOrderDetails"];
    return orderDict;
}

// 创建暖场人订单
- (void)createWarmerOrder {
    NSDictionary *orderInfo = [self configrationWarmerOrderInfo];
    NSArray *userOrderDetails = orderInfo[@"userOrderDetails"];
    if (![userOrderDetails count]) {
        [KTVToast toast:@"请先选择小蜜蜂"];
        return;
    }
    [MBProgressHUD showMessage:MB_CREATE_ORDER];
    [KTVMainService postCreateWarmerOrder:orderInfo result:^(NSDictionary *result) {
        [MBProgressHUD hiddenHUD];
        if ([result[@"code"] isEqualToString:ktvCode]) {
            NSString *orderId = result[@"data"][@"orderId"];
            [self networkConfirmPay:orderId];
        } else {
            [KTVToast toast:result[@"detail"]];
        }
    }];
}

// 第三方支付
- (void)networkConfirmPay:(NSString *)orderNo {
    NSString *channel = @"alipay";
    if (self.payType == 3) {
        channel = @"unionpay";
    } else if (self.payType == 1) {
        channel = @"alipay";
    } else if (self.payType == 2) {
        channel = @"wx";
    }
    
    NSDictionary *payParams = @{@"channel" : channel,
                                @"amount" : @"1",
                                @"subject" : @"aaaa",
                                @"body" : @"bbbb",
                                @"orderNo" : orderNo};
    [MBProgressHUD showMessage:MB_ORDER_PAYING];
    [KTVBuyService postPayParams:payParams result:^(NSDictionary *result) {
        [MBProgressHUD hiddenHUD];
        if (![result[@"code"] isEqualToString:ktvCode]) {
            [KTVToast toast:result[@"detail"]];
            return;
        }
        NSDictionary *charge = result[@"data"];
        if ([channel isEqualToString:@"alipay"]) {
            [KTVPayManager ktvPay:AlipayType payment:charge contoller:nil completion:^(NSString *result) {
                if ([result isEqualToString:@"success"]) {
                    [KTVToast toast:@"支付成功"];
                    [self backToRootController];
                } else {
                    // 支付失败或取消
                    [KTVToast toast:TOAST_PAY_FAIL];
                }
            }];
        } else if ([channel isEqualToString:@"wx"]) {
            [KTVPayManager ktvPay:WeChatType payment:charge contoller:nil completion:^(NSString *result) {
                if ([result isEqualToString:@"success"]) {
                    [KTVToast toast:@"支付成功"];
                    [self backToRootController];
                } else {
                    // 支付失败或取消
                    [KTVToast toast:TOAST_PAY_FAIL];
                }
            }];
        } else if ([channel isEqualToString:@"unionpay"]) {
            [KTVPayManager ktvPay:UnionPayType payment:charge contoller:nil completion:^(NSString *result) {
                if ([result isEqualToString:@"success"]) {
                    [KTVToast toast:@"支付成功"];
                    [self backToRootController];
                } else {
                    // 支付失败或取消
                    [KTVToast toast:TOAST_PAY_FAIL];
                }
            }];
        }
    }];
}

- (void)backToRootController {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - 网络

/// 分页获取门店暖场人
- (void)loadPageStoreActivitors {
    NSDictionary *params = @{@"storeId" : self.store.storeId,
                             @"size" : @"8",
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
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
    }];
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
        @WeakObj(self);
        headerView.headerActionBlock = ^(KTVHeaderType type) {
            if (type == HeaderType) {
                CLog(@"--->>> 邀约TA暖床");
                [weakself loadPageStoreActivitors];
            }
        };
        headerView.bgActionBlock = ^(KTVHeaderType headerType) {
            if (headerType == BGType) {
                // 跳转邀约暖场人列表
                @WeakObj(self);
                KTVSelectedBeautyController *vc = (KTVSelectedBeautyController *)[UIViewController storyboardName:@"MainPage" storyboardId:@"KTVSelectedBeautyController"];
                vc.store = self.store;
                vc.selectedWarmerCallback = ^(NSArray *selActivitorList) {
                    for (KTVUser *selUser in selActivitorList) {
                        for (KTVUser *user in weakself.activitorList) {
                            if ([selUser.userId isEqualToString:user.userId]) {
                                user.isSelected = YES;
                            }
                        }
                    }
                    [weakself.tableView reloadData];
                };
                vc.selectedActivitorList = self.selectedActivitorList;
                [weakself.navigationController pushViewController:vc animated:YES];
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
        return [self.activitorList count];
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
        KTVUser *user = self.activitorList[indexPath.row];
        cell.user = user;
        @WeakObj(self);
        cell.callback = ^(KTVUser *user) {
            if (user.isSelected) {
                [weakself.selectedActivitorList addObject:user];
            } else {
                [weakself.selectedActivitorList removeObject:user];
            }
            [weakself.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
        };
        return cell;
    } else if (indexPath.section == 2) {
        KTVPayMoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KTVPayMoneyCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"KTVPayMoneyCell" owner:self options:nil] lastObject];
        }
        cell.money = [self activitySelectedMoney];
        @WeakObj(self);
        cell.payMoneyAction = ^(double money) {
            CLog(@"-- >> 付款");
            [weakself createWarmerOrder];
        };
        return cell;
    }
    return [UITableViewCell new];
}


@end

