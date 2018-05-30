//
//  KTVPayController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/31.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVPayController.h"
#import "KTVPaySuccessController.h"

#import "KTVPayCell.h"
#import "KTVTableHeaderView.h"

#import "KTVBuyService.h"
#import "KTVPayManager.h"

@interface KTVPayController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *bankPayBtn;
@property (weak, nonatomic) IBOutlet UIButton *alipayBtn;
@property (weak, nonatomic) IBOutlet UIButton *wechatPayBtn;
@property (weak, nonatomic) IBOutlet UILabel *hideActivityAnsLabel; // 隐藏本次活动说明
@property (weak, nonatomic) IBOutlet UIButton *confirmPayBtn;

@property (strong, nonatomic) NSMutableDictionary *payChannelDict; // 支付渠道
@property (assign, nonatomic) BOOL isHiddenActivity;
@property (strong, nonatomic) NSMutableDictionary *orderUploadDictionary;
@property (assign, nonatomic) NSInteger payType;

@end

@implementation KTVPayController

- (void)mergeUploadParam {
    // 套餐价格
    if (self.groupbuy.totalPrice) {
        [self.orderUploadDictionary setObject:self.groupbuy.totalPrice forKey:@"groupbuyTotalPrice"];
    }
    [self.orderUploadDictionary setObject:@(self.store.storeId.integerValue) forKey:@"storeId"];
    [self.orderUploadDictionary setObject:@(self.store.user.userId.integerValue) forKey:@"userId"];
    if ([KTVCommon userInfo].userId) {
        [self.orderUploadDictionary setObject:@([KTVCommon userInfo].userId.integerValue) forKey:@"userId"];
    }
    // 1套餐，2酒吧位置价格 3包厢类型的价格 ,4暖场人，5 单点商品的价格如果是单点商品，会出现数量为2的情况），6普通邀约人（这个单价为0）7 团购 8 活动
    if (self.groupbuy) {
        [self.orderUploadDictionary setObject:@(7) forKey:@"orderType"];
    }

    // 套餐类型
    if (self.packageList && [self.packageList count]) {
        [self.orderUploadDictionary setObject:@(1) forKey:@"orderType"];
    }
    [self.orderUploadDictionary setObject:@(0) forKey:@"userHide"];
    // 订单时间
    NSString *currentDate = [NSDate dateStringWithDate:[NSDate date] andFormatString:@"yyyy-MM-dd HH:mm"];
    [self.orderUploadDictionary setObject:currentDate forKey:@"startDate"];
    
    // 订单结束时间
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:[NSDate date]];
    components.minute = components.minute + 15;
    NSDate *endDate = [calendar dateFromComponents:components];
    NSString *endTime = [NSDate dateStringWithDate:endDate andFormatString:@"yyyy-MM-dd HH:mm"];
    [self.orderUploadDictionary setObject:endTime forKey:@"endDate"];
    
    NSMutableArray *userOrderDetails = [NSMutableArray array];
    for (KTVUser *user in self.selectedActivitorList) {
        NSDictionary *dict = @{@"sourceId" : @(user.userId.integerValue),
                               @"price" : @(user.userDetail.price),
                               @"orderType" : @(user.userDetail.type),
                               @"count" : @(1),
                               @"discount" : @(100)};
        [userOrderDetails addObject:dict];
    }
    [self.orderUploadDictionary setObject:userOrderDetails forKey:@"userOrderDetails"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付订单";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor ktvBG];
    
    [self initData];
    
    [self.confirmPayBtn setTitle:[NSString stringWithFormat:@"确认支付 ¥%@", [self getOrderAllMoney]] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 初始化

- (void)initData {
    self.payChannelDict = [NSMutableDictionary dictionaryWithCapacity:3];
    [self.payChannelDict setObject:[NSNumber numberWithBool:NO] forKey:@"unionpay"];
    [self.payChannelDict setObject:[NSNumber numberWithBool:NO] forKey:@"alipay"];
    [self.payChannelDict setObject:[NSNumber numberWithBool:NO] forKey:@"wx"];
    
    self.orderUploadDictionary = [NSMutableDictionary dictionary];
}

#pragma mark - 封装

- (NSString *)getOrderAllMoney {
    NSInteger totalPrice = 0; // 套餐基础价格
    if (self.groupbuy) {
        totalPrice = self.groupbuy.totalPrice.floatValue;
    }
    if (self.packageList) {
        for (KTVPackage *pk in self.packageList) {
            totalPrice += pk.price.floatValue;
        }
    }
    NSInteger money = 0;
    for (KTVUser *user in self.selectedActivitorList) {
        money += user.userDetail.price;
    }
    money += totalPrice;
    
    return @(money).stringValue;
}

#pragma mark - 网络

// 订单支付流程
// 获取订单需要参数 -> 创建订单(获取到订单号) -> 获取支付的charge -> 调用支付接口

// 第三方支付
- (void)networkConfirmPay:(NSString *)orderNo {
    NSString *channel = [self getPayChannel];
    if (!channel) {
        [KTVToast toast:TOAST_SELECTED_PAYCHANNEL];
        return;
    }
    NSDictionary *payParams = @{@"channel" : channel,
                                @"amount" : @"2",
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
                    [self paySuccessWithPayType:self.payType andParentOrderNo:orderNo];
                } else {
                    // 支付失败或取消
                    [KTVToast toast:TOAST_PAY_FAIL];
                }
            }];
        } else if ([channel isEqualToString:@"wx"]) {
            [KTVPayManager ktvPay:WeChatType payment:charge contoller:nil completion:^(NSString *result) {
                if ([result isEqualToString:@"success"]) {
                    // 支付成功
                    [self paySuccessWithPayType:self.payType andParentOrderNo:orderNo];
                } else {
                    // 支付失败或取消
                    [KTVToast toast:TOAST_PAY_FAIL];
                }
            }];
        } else if ([channel isEqualToString:@"unionpay"]) {
            [KTVPayManager ktvPay:UnionPayType payment:charge contoller:nil completion:^(NSString *result) {
                if ([result isEqualToString:@"success"]) {
                    // 支付成功
                    [self paySuccessWithPayType:self.payType andParentOrderNo:orderNo];
                } else {
                    // 支付失败或取消
                    [KTVToast toast:TOAST_PAY_FAIL];
                }
            }];
        }
    }];
}

- (void)paySuccessWithPayType:(NSInteger)paytype andParentOrderNo:(NSString *)parentOrderNo {
    // 支付成功
    KTVPaySuccessController *vc = (KTVPaySuccessController *)[UIViewController storyboardName:@"MainPage" storyboardId:@"KTVPaySuccessController"];
    vc.payedMoney = [self getOrderAllMoney];
    vc.store = self.store;
    vc.payType = self.payType;
    vc.isHiddenActivity = self.isHiddenActivity;
    vc.parentOrderNum = parentOrderNo;
    [self.navigationController pushViewController:vc animated:YES];
}

// 创建基础订单
- (void)networkCreateOrder:(void (^)(NSDictionary *success))createSuccessBlock {
    NSString *channel = [self getPayChannel];
    if (!channel) {
        [KTVToast toast:TOAST_SELECTED_PAYCHANNEL];
        return;
    }
    
    [MBProgressHUD showMessage:MB_CREATE_ORDER];
    [KTVBuyService postCreateOrder:self.orderUploadDictionary result:^(NSDictionary *result) {
        [MBProgressHUD hiddenHUD];
        if ([result[@"code"] isEqualToString:ktvCode]) {
            if (createSuccessBlock){
                createSuccessBlock(result[@"data"]);
            }
        } else {
            [KTVToast toast:result[@"detail"]];
        }
    }];
}

#pragma mark - 事件

- (IBAction)bankPayAction:(UIButton *)sender {
    [self toggle:sender channel:@"unionpay"];
    CLog(@"-->> 银联支付");
}

- (IBAction)alipayAction:(UIButton *)sender {
    [self toggle:sender channel:@"alipay"];
    CLog(@"-->> 支付宝支付");
}

- (IBAction)wechatPayAction:(UIButton *)sender {
    [self toggle:sender channel:@"wx"];
    CLog(@"-->> 微信支付");
}

- (void)toggle:(UIButton *)sender channel:(NSString *)channel {
    [sender setSelected:!sender.isSelected];
    
    for (NSString *cl in self.payChannelDict.allKeys) {
        if (![cl isEqualToString:channel]) {
            [self.payChannelDict setObject:[NSNumber numberWithBool:NO] forKey:cl];
            
            if ([cl isEqualToString:@"unionpay"]) {
                [self.bankPayBtn setImage:[UIImage imageNamed:@"app_radius_unselect"] forState:UIControlStateNormal];
            } else if ([cl isEqualToString:@"alipay"]) {
                [self.alipayBtn setImage:[UIImage imageNamed:@"app_radius_unselect"] forState:UIControlStateNormal];
            } else if ([cl isEqualToString:@"wx"]) {
                [self.wechatPayBtn setImage:[UIImage imageNamed:@"app_radius_unselect"] forState:UIControlStateNormal];
            }
        } else {
            [self.payChannelDict setObject:[NSNumber numberWithBool:![[self.payChannelDict objectForKey:channel] boolValue]] forKey:channel];
            BOOL vl = [[self.payChannelDict objectForKey:channel] boolValue];
            
            if (vl) {
                [sender setImage:[UIImage imageNamed:@"app_radius_gou"] forState:UIControlStateNormal];
            } else {
                [sender setImage:[UIImage imageNamed:@"app_radius_unselect"] forState:UIControlStateNormal];
            }
        }
    }
}

- (NSString *)getPayChannel {
    NSString *paychannel = nil;
    for (NSString *channel in self.payChannelDict.allKeys) {
        BOOL va = [self.payChannelDict[channel] boolValue];
        if (va) {
            paychannel = channel;
            break;
        }
    }
    return paychannel;
}

- (IBAction)confirmPayAction:(UIButton *)sender {
    CLog(@"-->> 确认支付出去");
    
    [self mergeUploadParam];
    
    NSString *paychannel = [self getPayChannel];
    NSInteger payType = 1;
    if ([paychannel isEqualToString:@"unionpay"]) {
        payType = 3;
    } else if ([paychannel isEqualToString:@"alipay"]) {
        payType = 1;
    } else if ([paychannel isEqualToString:@"wx"]) {
        payType = 2;
    }
    self.payType = payType;
    [self.orderUploadDictionary setObject:@(payType) forKey:@"payType"];
    
    // 创建订单
    [self networkCreateOrder:^(NSDictionary *orderDict) {
        NSString *orderNo = orderDict[@"orderId"];
        [self networkConfirmPay:orderNo];
    }];
}

- (IBAction)hideActivityAction:(UIButton *)sender {
    CLog(@"-->> 隐藏本次活动");
    [sender setSelected:!sender.isSelected];
    if (sender.isSelected) {
        [sender setImage:[UIImage imageNamed:@"app_gou_red"] forState:UIControlStateNormal];
    } else {
        [sender setImage:[UIImage imageNamed:@"app_selected_kuang"] forState:UIControlStateNormal];
    }
    
    // 保存变量
    self.isHiddenActivity = sender.isSelected;
    if (sender.isSelected) {
        [self.orderUploadDictionary setObject:@(1) forKey:@"userHide"];
    } else {
        [self.orderUploadDictionary setObject:@(0) forKey:@"userHide"];
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 29.0f;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:@"app_order_dianpu" title:@"商家服务号" remark:nil];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110.0f;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        KTVPayCell *cell = (KTVPayCell *)[tableView dequeueReusableCellWithIdentifier:@"KTVPayCell"];
        cell.allMoney = [self getOrderAllMoney];
        return cell;
    }
    return nil;
}

@end
