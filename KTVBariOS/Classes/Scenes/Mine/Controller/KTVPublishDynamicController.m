//
//  KTVPublishDynamicController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/10/19.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVPublishDynamicController.h"
#import "KTVDynamicHeaderCell.h"
#import "KTVDynamicPictureCell.h"
#import "KTVDynamicUserBaseCell.h"
#import "KTVAddMediaCell.h"

#import "KTVMainService.h"

#import "KTVTableHeaderView.h"

@interface KTVPublishDynamicController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableDictionary *userInfo;

@end

@implementation KTVPublishDynamicController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor ktvBG];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    [self initData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self clearNavigationbar:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self clearNavigationbar:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 初始化

- (void)initData {
    self.userInfo = [NSMutableDictionary dictionary];
    
    if ([KTVCommon userInfo].phone) {
        [self.userInfo setObject:[KTVCommon userInfo].phone forKey:@"username"];
    }
}

#pragma mark - 网络

- (void)submitUserDetail {
    [KTVMainService postSaveUserDetail:self.userInfo result:^(NSDictionary *result) {
        if ([result[@"code"] isEqualToString:ktvCode]) {
            [KTVToast toast:TOAST_SAVE_USERINFO_SUCCESS];
        } else {
            [KTVToast toast:result[@"detail"]];
        }
    }];
}

#pragma mark - 事件

- (IBAction)submitAction:(UIButton *)sender {
    CLog(@"-->> 提交");
    [self submitUserDetail];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        KTVDynamicHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVDynamicHeaderCell)];
        return cell;
    } else if (indexPath.section == 1) {
        KTVAddMediaCell *cell = [[KTVAddMediaCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"KTVAddMediaCell"];
        cell.photoList = [NSMutableArray arrayWithArray:@[@"1", @"2", @"3"]];
        return cell;
    } else if (indexPath.section == 2) {
        KTVAddMediaCell *cell = [[KTVAddMediaCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"KTVAddMediaCell"];
        return cell;
    } else if (indexPath.section == 3) {
        KTVDynamicPictureCell *cell = [tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVDynamicPictureCell)];
        return cell;
    } else if (indexPath.section == 4) {
        KTVDynamicUserBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVDynamicUserBaseCell)];
        cell.userInfoCallback = ^(NSDictionary *userInfo) {
            [self.userInfo setObject:userInfo forKey:@"userDetail"];
        };
        return cell;
    }
    return [UITableViewCell new];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 233;
    } else if (indexPath.section == 1) {
        return 90;
    } else if (indexPath.section == 2) {
        return 90;
    } else if (indexPath.section == 3) {
        return 222;
    } else if (indexPath.section == 4) {
        return 628;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:nil title:@"我的相册" remark:nil];
        return headerView;
    } else if (section == 2) {
        KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:nil title:@"我的视频" remark:nil];
        return headerView;
    } else if (section == 3) {
        KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:nil title:@"动态" remark:nil];
        return headerView;
    } else if (section == 4) {
        KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:nil title:@"关于我" remark:nil];
        return headerView;
    }
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1 || section == 2 || section == 3 || section == 4) {
        return 30;
    }
    return 0;
}

@end
