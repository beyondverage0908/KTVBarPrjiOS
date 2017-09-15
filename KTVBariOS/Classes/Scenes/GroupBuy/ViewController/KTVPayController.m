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

@end

@implementation KTVPayController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付订单";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor ktvBG];
    
    [self initData];
    
    [self.confirmPayBtn setTitle:[NSString stringWithFormat:@"确认支付 ¥%@", [self getOrderAllMoney]] forState:UIControlStateNormal];
}

- (void)initData {
    self.payChannelDict = [NSMutableDictionary dictionaryWithCapacity:3];
    [self.payChannelDict setObject:[NSNumber numberWithBool:NO] forKey:@"unionpay"];
    [self.payChannelDict setObject:[NSNumber numberWithBool:NO] forKey:@"alipay"];
    [self.payChannelDict setObject:[NSNumber numberWithBool:NO] forKey:@"wechatpay"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 封装

- (NSString *)getOrderAllMoney {
    NSInteger groupbuyTotalPrice = [self.orderUploadDictionary[@"groupbuyTotalPrice"] integerValue]; // 套餐基础价格
    NSArray *yueUserDetails = self.orderUploadDictionary[@"userOrderDetails"];
    NSInteger money = 0;
    for (NSDictionary *dict in yueUserDetails) {
        money += [dict[@"price"] integerValue];
    }
    money += groupbuyTotalPrice;
    
    return @(money).stringValue;
}

#pragma mark - 网络

- (void)networkConfirmPay {
    NSString *channel = [self getPayChannel];
    if (!channel) {
        [KTVToast toast:TOAST_SELECTED_PAYCHANNEL];
        return;
    }
    
    NSDictionary *payParams = @{@"channel" : channel,
                                @"amount" : @"1",
                                @"subject" : @"aaaa",
                                @"body" : @"bbbb",
                                @"orderNo" : @"1504017453722k9qadqq"};
    [KTVBuyService postPayParams:payParams result:^(NSDictionary *result) {
        NSDictionary *charge = result[@"data"];
        [KTVPayManager ktvPay:AlipayType payment:charge contoller:nil completion:^(NSString *result) {
            KTVPaySuccessController *vc = (KTVPaySuccessController *)[UIViewController storyboardName:@"MainPage" storyboardId:@"KTVPaySuccessController"];
            [self.navigationController pushViewController:vc animated:YES];
        }];
    }];
}

- (void)networkCreateOrder:(void (^)(NSDictionary *success))createSuccessBlock {
    [KTVBuyService postCreateOrder:self.orderUploadDictionary result:^(NSDictionary *result) {
        if ([result[@"code"] isEqualToString:ktvCode]) {
            if (createSuccessBlock){
                createSuccessBlock([NSDictionary new]);
            }
        }
        CLog(@"--->>> %@", result);
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
    [self toggle:sender channel:@"wechatpay"];
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
            } else if ([cl isEqualToString:@"wechatpay"]) {
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
    
    if ([paychannel isEqualToString:@"unionpay"]) {
        [self.orderUploadDictionary setObject:@(0) forKey:@"payType"];
    } else if ([paychannel isEqualToString:@"alipay"]) {
        [self.orderUploadDictionary setObject:@(1) forKey:@"payType"];
    } else if ([paychannel isEqualToString:@"wechatpay"]) {
        [self.orderUploadDictionary setObject:@(2) forKey:@"payType"];
    }
    
    return paychannel;
}

- (IBAction)confirmPayAction:(UIButton *)sender {
    CLog(@"-->> 确认支付出去");
    
    [self networkConfirmPay];
    
    [self networkCreateOrder:^(NSDictionary *success) {
        [self networkConfirmPay];
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
