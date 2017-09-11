//
//  KTVMineController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/7/31.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVMineController.h"
#import "KTVLoginGuideController.h"
#import "KTVUserInfoController.h"
#import "KTVMineFriendController.h"
#import "KTVOrderStatusListController.h"

#import "KTVUserHeaderCell.h"
#import "KTVUserInfoCell.h"


@interface KTVMineController ()<UITableViewDelegate, UITableViewDataSource, KTVUserHeaderCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *userInfoArray;

@end

@implementation KTVMineController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    
    [self setupData];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor ktvBG];
}

- (void)setupData {
    self.userInfoArray = @[@"我的消息", @"我的订单", @"发起拼桌活动", @"我的好友", @"发布动态", @"我的收藏", @"申请入驻成为商家", @"设置"];
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 140;
    } else if (indexPath.section == 1) {
        return 40;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            KTVOrderStatusListController *vc = (KTVOrderStatusListController *)[UIViewController storyboardName:@"MePage" storyboardId:@"KTVOrderStatusListController"];
            [self.navigationController pushViewController:vc animated:YES];
        } else if (indexPath.row == 3) {
            CLog(@"-- 查看个人信息 下一页");
            KTVMineFriendController *vc = (KTVMineFriendController *)[UIViewController storyboardName:@"MePage" storyboardId:@"KTVMineFriendController"];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 40;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *bgView = [[UIView alloc] init];
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainpage_all_bg_line"]];
    [bgView addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(bgView);
    }];
    return bgView;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return self.userInfoArray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        KTVUserHeaderCell *cell = (KTVUserHeaderCell *)[tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVUserHeaderCell)];
        cell.delegate = self;
        return cell;
    } else if (indexPath.section == 1) {
        KTVUserInfoCell *cell = (KTVUserInfoCell *)[tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVUserInfoCell)];
        cell.info = self.userInfoArray[indexPath.row];
        return cell;
    }
    return nil;
}

#pragma mark - KTVUserHeaderCellDelegate

// login
- (void)gotoLogin {
    KTVLoginGuideController *guideVC = [[KTVLoginGuideController alloc] init];
    KTVBaseNavigationViewController *nav = [[KTVBaseNavigationViewController alloc] initWithRootViewController:guideVC];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)toseeMineInfo:(NSDictionary *)info {
    CLog(@"-- 查看个人信息");
    KTVUserInfoController *vc = (KTVUserInfoController *)[UIViewController storyboardName:@"MePage" storyboardId:@"KTVUserInfoController"];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
