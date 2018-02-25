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
#import "KTVStartYueController.h"
#import "KTVApplyStoreController.h"
#import "KTVPublishDynamicController.h"
#import "KTVSettingController.h"
#import "KTVDynamicController.h"
#import "KTVChatSessionController.h"
#import "KTVStoreCollectController.h"
#import "KTVMyInvitationController.h"
#import "KTVApplyWarmerPartOneController.h"

#import "KTVUserHeaderCell.h"
#import "KTVUserInfoCell.h"

#import "KTVMainService.h"
#import "KTVLoginService.h"
#import "KTVStore.h"
#import "KTVUser.h"
#import "KTVRongCloudManager.h"


@interface KTVMineController ()<UITableViewDelegate, UITableViewDataSource, KTVUserHeaderCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *userInfoArray;
@property (nonatomic, strong) NSMutableArray<KTVStore *> *storeList;
@property (nonatomic, strong) KTVUser *user;

@end

@implementation KTVMineController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    
    [self setupData];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor ktvBG];
    
    [KtvNotiCenter addObserver:self selector:@selector(loginedSucess) name:KNotLoginSuccess object:nil];
    [KtvNotiCenter addObserver:self selector:@selector(resignLogin) name:KNotLoginOutOf object:nil];
    
    if (![KTVCommon isLogin]) {
        [self gotoLogin];
    } else {
        [self loadUserInfo];
        [self loadSearchOrder]; // 查询订单，用于拼拼桌
    }
}

- (void)setupData {
//    self.userInfoArray = @[@"发起拼桌活动", @"暖场人邀约", @"发布动态", @"我的收藏", @"申请入驻成为商家", @"设置"];
    self.userInfoArray = @[@"我的拼桌活动", @"暖场人邀约", @"发布动态", @"我的收藏", @"申请入驻成为商家", @"申请成为暖场人", @"设置"];
}

- (NSMutableArray<KTVStore *> *)storeList {
    if (!_storeList) {
        _storeList = [NSMutableArray array];
    }
    return _storeList;
}

#pragma mark - 监听

- (void)loginedSucess {
    [self loadUserInfo];
    //[self loadSearchOrder];
    [self getRongCloudToken];
    [self updateUserLocation];
}

- (void)resignLogin {
    self.user = nil;
    [self.tableView reloadData];
    // 注销移除融云的token
    [KTVUtil removeUserDefaultForKey:@"rongCloudToken"];
}

// 更新用户地理位置
- (void)updateUserLocation {
    KTVAddress *userAddress = [KTVCommon getUserLocation];
    [KtvNotiCenter postNotificationName:KNotUserLocationUpdate object:userAddress];
}

#pragma mark - 网络

/// 查询订单
- (void)loadSearchOrder {
    NSString *phone = [KTVCommon userInfo].phone;
    if ([KTVUtil isNullString:phone]) {
        return;
    }
    NSDictionary *params = @{@"username" : phone, @"orderStatus" : @"1"};
    [KTVMainService postSearchOrder:params result:^(NSDictionary *result) {
        if (![result[@"code"] isEqualToString:ktvCode]) {
            return;
        }
        for (NSDictionary *dic in result[@"data"]) {
            NSDictionary *storeDic = dic[@"store"];
            KTVStore *store = [KTVStore yy_modelWithDictionary:storeDic];
            [self.storeList addObject:store];
        }
    }];
}

/// 获取用户信息
- (void)loadUserInfo {
    NSString *phone = [KTVCommon userInfo].phone;
    [KTVLoginService getUserInfo:phone result:^(NSDictionary *result) {
        if (![result[@"code"] isEqualToString:ktvCode]) {
            [KTVToast toast:TOAST_USERINFO_FAIL];
        } else {
            NSDictionary *userInfo = result[@"data"];
            if (userInfo.allKeys.count > 0) {
                [KTVCommon saveUserInfo:userInfo];
            }
            KTVUser *user = [KTVUser yy_modelWithDictionary:userInfo];
            self.user = user;
            
            [self.tableView reloadData];
        }
    }];
}

- (void)getRongCloudToken {
    NSString *username = [KTVCommon userInfo].phone;
    NSString *rcToken = [KTVUtil objectForKey:@"rongCloudToken"];
    if (username && !rcToken) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:username forKey:@"userId"];
        
        NSString *nickName = [KTVCommon userInfo].nickName;
        [params setObject:nickName ? nickName : @"" forKey:@"name"];
        
        KTVPicture *pic = [KTVCommon userInfo].pictureList.firstObject;
        [params setObject:pic.pictureUrl ? pic.pictureUrl : @"" forKey:@"portraitUri"];
        
        [KTVMainService getRongCloudToken:params result:^(NSDictionary *result) {
            if ([result[@"code"] isEqualToString:ktvCode]) {
                [KTVCommon setUserInfoKey:@"rongCloudToken" infoValue:result[@"data"][@"token"]];
                [[KTVRongCloudManager shareManager] rongInit];
            }
        }];
    }
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
    if (![KTVCommon isLogin]) {
        [self requestToLogin];
        return;
    }
    if (indexPath.section == 0) {
        KTVUserInfoController *vc = (KTVUserInfoController *)[UIViewController storyboardName:@"MePage" storyboardId:@"KTVUserInfoController"];
        vc.isMySelf = YES;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.section == 1) {
//        if (indexPath.row == 0) {
//            KTVChatSessionController *vc = [[KTVChatSessionController alloc] init];
//            vc.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:vc animated:YES];
//        } else if (indexPath.row == 1) {
//            KTVOrderStatusListController *vc = (KTVOrderStatusListController *)[UIViewController storyboardName:@"MePage" storyboardId:@"KTVOrderStatusListController"];
//            [self.navigationController pushViewController:vc animated:YES];
//        }
        // @[@"我的拼桌活动", @"暖场人邀约", @"发布动态", @"我的收藏", @"申请入驻成为商家", @"申请成为暖场人", @"设置"]
        if (indexPath.row == 0) {
            // 发起拼桌活动
            if (![self.storeList count]) {
                [KTVToast toast:TOAST_NO_USEING_ORDER];
                return;
            }
            KTVStartYueController *vc = (KTVStartYueController *)[UIViewController storyboardName:@"MainPage" storyboardId:@"KTVStartYueController"];
            [self.navigationController pushViewController:vc animated:YES];
        } else if (indexPath.row == 1) {
            CLog(@"-- 暖场人邀约");
            KTVMyInvitationController *vc = (KTVMyInvitationController *)[UIViewController storyboardName:@"MePage" storyboardId:@"KTVMyInvitationController"];
            [self.navigationController pushViewController:vc animated:YES];
        } else if (indexPath.row == 2) {
            // 发布动态
            KTVDynamicController *vc = (KTVDynamicController *)[UIViewController storyboardName:@"MePage" storyboardId:KTVStringClass(KTVDynamicController)];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (indexPath.row == 3) {
            // 我的收藏
            CLog(@"-->> 店铺收藏");
            KTVStoreCollectController *vc = (KTVStoreCollectController *)[UIViewController storyboardName:@"MainPage" storyboardId:@"KTVStoreCollectController"];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (indexPath.row == 4) {
            KTVApplyStoreController *vc = (KTVApplyStoreController *)[UIViewController storyboardName:@"MePage" storyboardId:KTVStringClass(KTVApplyStoreController)];
            [self.navigationController pushViewController:vc animated:YES];
        } else if (indexPath.row == 5) {
            // 申请成为暖场人
            KTVApplyWarmerPartOneController *vc = [[KTVApplyWarmerPartOneController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        } else if (indexPath.row == 6) {
            KTVSettingController *vc = (KTVSettingController *)[UIViewController storyboardName:@"MePage" storyboardId:KTVStringClass(KTVSettingController)];
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
        cell.user = self.user;
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
    [self login];
}

- (void)toseeMineInfo:(NSDictionary *)info {
    // 个人信息
    if ([KTVCommon isLogin]) {
        KTVPublishDynamicController *vc = (KTVPublishDynamicController *)[UIViewController storyboardName:@"MePage" storyboardId:KTVStringClass(KTVPublishDynamicController)];
        vc.user = self.user;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        [self requestToLogin];
    }
}

#pragma mark - Login

- (void)login {
    KTVLoginGuideController *guideVC = [[KTVLoginGuideController alloc] init];
    KTVBaseNavigationViewController *nav = [[KTVBaseNavigationViewController alloc] initWithRootViewController:guideVC];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
