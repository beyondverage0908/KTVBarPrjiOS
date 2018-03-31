//
//  KTVMyInvitationController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2018/1/20.
//  Copyright © 2018年 Lin. All rights reserved.
//

#import "KTVMyInvitationController.h"

#import "KTVInvitatingCell.h"
#import "KTVInvitationAcceptCell.h"
#import "KTVChooseParttimeView.h"

#import "KTVMainService.h"
#import "KTVWarmerOrder.h"

@interface KTVMyInvitationController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;

@property (nonatomic, strong) NSMutableArray *invitatingList; // 邀约中
@property (nonatomic, strong) NSMutableArray *invitatedList; // 已经接受邀约的

@end

@implementation KTVMyInvitationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor ktvBG];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.view.backgroundColor = [UIColor ktvBG];
    
    // default -
    [self loadInvitatingService];
    [self queryWarmerUserOrder];
}

#pragma mark - getter or setter

- (NSMutableArray *)invitatedList {
    if (!_invitatedList) {
        _invitatedList = [NSMutableArray array];
    }
    return _invitatedList;
}

- (NSMutableArray *)invitatingList {
    if (!_invitatingList) {
        _invitatingList = [NSMutableArray array];
    }
    return _invitatingList;
}

#pragma mark - 事件

- (IBAction)changeSegment:(id)sender {
    UISegmentedControl *segment = (UISegmentedControl *)sender;
    CLog(@"-->> %@", @(segment.selectedSegmentIndex));
    
    if (segment.selectedSegmentIndex == 0) {
        // 加载邀约的酒吧
        [self loadInvitatingService];
    } else {
        // 加载已经接受邀约的酒吧
        [self loadInvitatedService];
    }
}


- (IBAction)setPartTimeJobAction:(UIButton *)sender {
    CLog(@"-->> 设置我的兼职时间");
    
    KTVChooseParttimeView *parttimeView = [[[NSBundle mainBundle] loadNibNamed:@"KTVChooseParttimeView" owner:self options:nil] lastObject];
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:parttimeView];
    parttimeView.frame = keyWindow.frame;
    
    @WeakObj(self);
    parttimeView.confirmBackBack = ^(NSDictionary *params) {
        CLog(@"兼职时间-->> %@", params);
        NSMutableArray *parttimeArr = [NSMutableArray arrayWithCapacity:7];
        for (NSInteger i = 0; i < params.allKeys.count; i++) {
            NSString *key = params.allKeys[i];
            if ([params[key] boolValue]) {
                [parttimeArr addObject:key];
            }
        }
        [weakself upgradeParttime:parttimeArr];
    };
}

#pragma mark - 网络

- (void)queryWarmerUserOrder {
    NSString *phone = [KTVCommon userInfo].phone;
    phone = @"18939865771";
    if (phone.length) {
        if (self.invitatingList.count) {
            [self.tableView reloadData];
            return;
        } else {
            [KTVMainService postWarmerUserOrder:@{@"username" : phone} result:^(NSDictionary *result) {
                if ([result[@"code"] isEqualToString:ktvCode]) {
                    [self.invitatingList removeAllObjects];
                    for (NSDictionary *dic in result[@"data"]) {
                        KTVWarmerOrder *waittingOrder = [KTVWarmerOrder yy_modelWithDictionary:dic];
                        [self.invitatingList addObject:waittingOrder];
                    }
                    [self.tableView reloadData];
                }
            }];
        }
    }
}
// actionType  2接受 1拒绝
// 暖场人同意-拒绝
- (void)updateWarmerAcceptStatus:(NSDictionary *)params {
    [KTVMainService postUpdateRejectRecordOrder:params result:^(NSDictionary *result) {
        if ([result[@"code"] isEqualToString:ktvSuccess]) {
            
        }
    }];
}

// 获取查询兼职暖场人的拒绝和接受订单
// actionType  2接受 1拒绝
- (void)queryWarmerActionOrder:(NSString *)actionType {
    NSString *username = [KTVCommon userInfo].phone;
    if (username.length) {
        NSDictionary *params = @{@"username" : username, @"actionType" : actionType};
        [KTVMainService postQueryRejectRecordOrderUrl:params result:^(NSDictionary *result) {
            if ([result[@"code"] isEqualToString:ktvSuccess]) {
                
            }
        }];
    }
}

- (void)upgradeParttime:(NSArray *)parttimeArr {
    NSString *parttimeStr = [parttimeArr componentsJoinedByString:@","];
    
    NSDictionary *params = @{@"username" : [KTVCommon userInfo].username, @"time" : parttimeStr};
    [KTVMainService postUpdateWarmerWorkTime:params result:^(NSDictionary *result) {
        if ([result[@"code"] isEqualToString:ktvCode]) {
            [KTVToast toast:@"修改成功"];
        } else {
            [KTVToast toast:@"暂时无法修改兼职时间"];
        }
    }];
}

#pragma mark - 逻辑

- (void)loadInvitatedService {
    [self.tableView reloadData];
}

- (void)loadInvitatingService {
    // 待接受 - 订单
    [self queryWarmerUserOrder];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.segment.selectedSegmentIndex == 0) {
        return self.invitatingList.count;
    } else {
        return self.invitatedList.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.segment.selectedSegmentIndex == 0) {
        KTVInvitatingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KTVInvitatingCell"];
        KTVWarmerOrder *waittingOrder = self.invitatingList[indexPath.row];
        cell.warmerOrder = waittingOrder;
        @WeakObj(self);
        // actionType  2接受 1拒绝
        cell.agreeCallback = ^(KTVWarmerOrder *order) {
            NSDictionary *params = @{@"actionType" : @"2", @"subOrderId" : @"970178577125343232"};
            [weakself updateWarmerAcceptStatus:params];
        };
        cell.denyCallback = ^(KTVWarmerOrder *order) {
            NSDictionary *params = @{@"actionType" : @"2", @"subOrderId" : @"970178577125343232"};
            [weakself updateWarmerAcceptStatus:params];
        };
        return cell;
    } else {
        KTVInvitationAcceptCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KTVInvitationAcceptCell"];
        KTVWarmerOrder *warmerOrder = self.invitatedList[indexPath.row];
        cell.warmerOrder = warmerOrder;
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 136;
}

@end
