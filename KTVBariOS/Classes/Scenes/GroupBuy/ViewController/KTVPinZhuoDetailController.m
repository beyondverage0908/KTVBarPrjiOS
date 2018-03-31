//
//  KTVPinZhuoDetailController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/3.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVPinZhuoDetailController.h"
#import "KTVMineFriendController.h"

#import "KTVPZUserHeaderCell.h"
#import "KTVPZStoreCell.h"

#import "KTVMainService.h"
#import "KTVLoginService.h"

#import "KTVPinZhuoDetail.h"

@interface KTVPinZhuoDetailController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonnull) KTVUser *user;
@property (strong, nonatomic) NSMutableArray *pzDetailList;

@end

@implementation KTVPinZhuoDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"拼桌详情";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor ktvBG];
    
    [self initData];
    
    [self loadPinZhuoUserInfo];
    [self loadShareTableDetail];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 初始化

- (void)initData {
    self.pzDetailList = [NSMutableArray array];
}

#pragma mark - 网络

/// 获取拼桌详情
- (void)loadShareTableDetail {
    [KTVMainService getShareTableDetail:self.phone result:^(NSDictionary *result) {
        if ([result[@"code"] isEqualToString:ktvCode]) {
            for (NSDictionary *dict in result[@"data"]) {
                KTVPinZhuoDetail *detail = [KTVPinZhuoDetail yy_modelWithDictionary:dict];
                [self.pzDetailList addObject:detail];
            }
            [self.tableView reloadData];
        } else {
            [KTVToast toast:TOAST_CANT_PINZHUO_DETAIL];
        }
    }];
}

// 获取用户信息
- (void)loadPinZhuoUserInfo {
    [KTVLoginService getUserInfo:self.phone result:^(NSDictionary *result) {
        if (![result[@"code"] isEqualToString:ktvCode]) {
            return;
        }
        
        self.user = [KTVUser yy_modelWithDictionary:result[@"data"]];
        [self.tableView reloadData];
    }];
}

- (void)loadEnrollShareTableWith:(NSString *)shareTableId {
    NSString *username = [KTVCommon userInfo].phone;
    if (!username) {
        return;
    }
    NSDictionary *param = @{@"shareTableId" : shareTableId,
                            @"username" : username};
    [KTVMainService postShareTableEnroll:param result:^(NSDictionary *result) {
        if ([result[@"code"] isEqualToString:ktvCode]) {
            [KTVToast toast:TOAST_ENTER_PINZHUO_SUCCESS];
        } else {
            [KTVToast toast:result[@"detail"]];
        }
    }];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 100.0f;
    } else if (indexPath.section == 1) {
        return 163.0f;
    }
    return 0;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return [self.pzDetailList count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        KTVPZUserHeaderCell *cell = (KTVPZUserHeaderCell *)[tableView dequeueReusableCellWithIdentifier:@"KTVPZUserHeaderCell"];
        cell.user = self.user;
        return cell;
    } else if (indexPath.section == 1) {
        KTVPZStoreCell *cell = (KTVPZStoreCell *)[tableView dequeueReusableCellWithIdentifier:@"KTVPZStoreCell"];
        KTVPinZhuoDetail *detail = self.pzDetailList[indexPath.row];
        cell.pzDetail = detail;
        cell.reportCallback = ^(KTVPinZhuoDetail *pzDetail) {
            CLog(@"-->> 点击了去报名");
            [self loadEnrollShareTableWith:pzDetail.pinZhuoId];
        };
        cell.enrollCallback = ^(KTVPinZhuoDetail *pzDetail) {
            // 去用户列表页
            KTVMineFriendController *vc = (KTVMineFriendController *)[UIViewController storyboardName:@"MePage" storyboardId:@"KTVMineFriendController"];
            vc.userList = pzDetail.userList;
            [self.navigationController pushViewController:vc animated:YES];
        };
        return cell;
    }
    return nil;
}


@end
