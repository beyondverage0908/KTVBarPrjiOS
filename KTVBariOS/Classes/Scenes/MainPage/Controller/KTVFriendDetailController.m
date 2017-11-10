//
//  KTVFriendDetailController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/10/17.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVFriendDetailController.h"
#import "KTVPinZhuoDetailController.h"
#import "KTVFriendCell.h"

#import "KTVMainService.h"
#import "KTVUser.h"

@interface KTVFriendDetailController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *yueUserList;

@end

@implementation KTVFriendDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"伙伴详情";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor ktvBG];
    
    [self customRightNavigation];
    [self loadFriendDetailList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 重写

- (NSMutableArray *)yueUserList {
    if (!_yueUserList) {
        _yueUserList = [NSMutableArray array];
    }
    return _yueUserList;
}

#pragma mark - 定制

- (void)customRightNavigation {
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"筛选" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    rightBtn.frame = CGRectMake(0, 0, 44, 44);
    [bgView addSubview:rightBtn];
    
    UIImageView *filterView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_filter_sanjiao"]];
    filterView.frame = CGRectMake(CGRectGetMaxX(rightBtn.frame), (44 - 8) / 2, 8, 8);
    [bgView addSubview:filterView];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:bgView];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark - 网络

/// 获取门店在约人数
- (void)loadFriendDetailList {
    NSString *storeId = self.store.storeId ? self.store.storeId : @"4";
    if (!storeId) return;
    [KTVMainService getStoreInvitators:storeId result:^(NSDictionary *result) {
        if (![result[@"code"] isEqualToString:ktvCode]) {
            [KTVToast toast:TOAST_GET_DATA_FAIL];
            return;
        }
        NSArray *activityList = result[@"data"];
        if ([activityList count]) {
            for (NSDictionary *dic in result[@"data"]) {
                KTVUser *user = [KTVUser yy_modelWithDictionary:dic];
                [self.yueUserList addObject:user];
            }
            [self.tableView reloadData];
        } else {
            [KTVToast toast:TOAST_NOMORE_ACTIVITORS];
        }
    }];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 90;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        CLog(@"-- 查看好友信息");
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return [self.yueUserList count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        KTVFriendCell *cell = (KTVFriendCell *)[tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVFriendCell)];
        cell.friendType = FriendAddType;
        KTVUser *user = self.yueUserList[indexPath.row];
        cell.user = user;
        cell.pinzuoCallback = ^(KTVUser *user) {
            KTVPinZhuoDetailController *vc = (KTVPinZhuoDetailController *)[UIViewController storyboardName:@"MainPage" storyboardId:@"KTVPinZhuoDetailController"];
            vc.phone = user.phone;
            [self.navigationController pushViewController:vc animated:YES];
        };
        return cell;
    }
    return nil;
}

@end
