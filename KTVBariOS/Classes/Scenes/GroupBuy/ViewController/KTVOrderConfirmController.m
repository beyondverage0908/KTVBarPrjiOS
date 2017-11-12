//
//  KTVOrderConfirmController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/29.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVOrderConfirmController.h"
#import "KTVSelectedBeautyController.h"
#import "KTVOrderUploadController.h"

#import "KTVOrderConfirmCell.h"
#import "KTVYuePaoUserCell.h"

#import "KTVTableHeaderView.h"

#import "KTVMainService.h"

@interface KTVOrderConfirmController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *continuePayBgView;

@property (nonatomic, strong) NSMutableArray<KTVUser *>* userInviteList; // 附近邀约的用户
@property (nonatomic, assign) NSInteger currentPage; // 分页

@end

@implementation KTVOrderConfirmController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"订单确认";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor ktvBG];
    self.continuePayBgView.backgroundColor = [UIColor ktvBG];
    
    self.currentPage = 1; // 默认值
    [self loadCommonNearUser];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 方法重写

- (NSMutableArray<KTVUser *> *)userInviteList {
    if (!_userInviteList) {
        _userInviteList = [NSMutableArray array];
    }
    return _userInviteList;
}

#pragma mark - 网络

- (void)loadCommonNearUser {
    //?latitude=121.48789949&longitude=31.24916171&sex=0&distance=1000&currentPage=1&pageSize=5
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"121.48789949" forKey:@"latitude"];
    [params setObject:@"31.24916171" forKey:@"longitude"];
    [params setObject:@"1000" forKey:@"distance"];
    [params setObject:@(self.currentPage) forKey:@"currentPage"];
    [params setObject:@"5" forKey:@"pageSize"];
    [KTVMainService getCommonNearUser:params result:^(NSDictionary *result) {
        if ([result[@"code"] isEqualToString:ktvCode]) {
            if (![result[@"data"] count]) {
                if (self.currentPage > 1) {
                    [KTVToast toast:TOAST_NEAR_NO_INVITEER];
                }
            } else {
                [self.userInviteList removeAllObjects];
                for (NSDictionary *div in result[@"data"]) {
                    KTVUser *user = [KTVUser yy_modelWithDictionary:div];
                    [self.userInviteList addObject:user];
                }
                self.currentPage++;
                [self.tableView reloadData];
            }
        }
    }];
}

#pragma mark - 事件

- (IBAction)continuePayActon:(UIButton *)sender {
    CLog(@"确认订单-下一步");
    KTVOrderUploadController *vc = (KTVOrderUploadController *)[UIViewController storyboardName:@"MainPage" storyboardId:@"KTVOrderUploadController"];
    vc.store = self.store;
    vc.packageList = self.packageList;
    vc.selectedActivitorList = self.selectedActivitorList; // 已经选中的暖场人
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 110.0f;
    } else if (indexPath.section == 1) {
        return 90.0f;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 35.0f;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:nil title:@"附近的邀约" headerImgUrl:@"app_change_batch" remarkUrl:@"pay_to_yuepao" remark:nil];
        headerView.headerActionBlock = ^(KTVHeaderType headerType) {
            if (headerType == HeaderType) {
                CLog(@"--->>> 换一批泡");
                [self loadCommonNearUser];
            } else if (headerType == RemarkType) {
                CLog(@"--->>> 付费约");
                KTVSelectedBeautyController *vc = (KTVSelectedBeautyController *)[UIViewController storyboardName:@"MainPage" storyboardId:@"KTVSelectedBeautyController"];
                vc.store = self.store;
                [self.navigationController pushViewController:vc animated:YES];
            }
        };
        return headerView;
    }
    return nil;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self.userInviteList count] > 0) {
        return 2;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return self.userInviteList.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        KTVOrderConfirmCell *cell = (KTVOrderConfirmCell *)[tableView dequeueReusableCellWithIdentifier:@"KTVOrderConfirmCell"];
        cell.packageList = self.packageList;
        cell.selectedActivitorList = self.selectedActivitorList;
        return cell;
    } else if (indexPath.section == 1) {
        KTVYuePaoUserCell *cell = (KTVYuePaoUserCell *)[tableView dequeueReusableCellWithIdentifier:@"KTVYuePaoUserCell"];
        cell.userType = KTVUserCommon;
        KTVUser *user = self.userInviteList[indexPath.row];
        cell.user = user;
        return cell;
    }
    return nil;
}

@end
