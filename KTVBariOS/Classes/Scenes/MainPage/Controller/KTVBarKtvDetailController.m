//
//  KTVBarKtvDetailController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/12.
//  Copyright © 2017年 Lin. All rights reserved.
//
//  酒吧，KTV店铺详情

#import "KTVBarKtvDetailController.h"
#import "KTVFriendDetailController.h"

#import "KTVBarKtvDetailHeaderCell.h"
#import "KTTimeFilterCell.h"
#import "KTVPositionFilterCell.h"
#import "KTVPackageCell.h"
#import "KTVBarKtvReserveCell.h"
#import "KTVBarKtvBeautyCell.h"
#import "KTVCommentCell.h"
#import "KTVTableHeaderView.h"
#import "KTVDoBusinessCell.h"
#import "KTVOtherDianpuCell.h"
#import "KTVPackageController.h"
#import "KTVGroupBuyDetailController.h"
#import "KTVMainService.h"

#import "KSPhotoBrowser.h"

@interface KTVBarKtvDetailController ()<UITableViewDelegate, UITableViewDataSource, KSPhotoBrowserDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray<KTVUser *> *invitatorList;
@property (strong, nonatomic) UIBarButtonItem *userCollectionBtnItem;
@property (assign, nonatomic) BOOL isCollection; // 店铺是否被收藏 yes or no

@end

@implementation KTVBarKtvDetailController

// 店铺详情(酒吧选座)
- (void)viewDidLoad {
    [super viewDidLoad];
    CLog(@"-->> 店铺详情(酒吧选座)");
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor ktvBG];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self customRightBarItems];
    
    [self initData];
    
    [self loadStoreInvitators];
    [self getAlreadyUserCollection];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self clearNavigationbar:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self clearNavigationbar:NO];
}

#pragma mark - 事件

- (void)navigationBackAction:(id)action {
    [self hideNavigationBar:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)customRightBarItems {
    UIBarButtonItem *firstItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"app_order_share"]
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(firstRightBarItemAction:)];
    // store_collection
    self.userCollectionBtnItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"app_order_shouchang"]
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(secondRightBarItemAction:)];
    self.navigationItem.rightBarButtonItems = @[firstItem, self.userCollectionBtnItem];
}

// 分享
- (void)firstRightBarItemAction:(id)sender {
    CLog(@"-->> 订单分享");
}

// 收藏
- (void)secondRightBarItemAction:(id)sender {
    CLog(@"-->> 订单收藏");
    if (!self.isCollection) {
        [self userCollectionStore];
    } else {
        [self cancelUserCollectStore];
    }
}

#pragma mark - 初始化

- (void)initData {
//    self.activitorList = [NSMutableArray array];
    self.invitatorList = [NSMutableArray array];
//    self.selectedActivitorList = [NSMutableArray array];
}

#pragma mark - 网络

/// 获取门店在约人数
- (void)loadStoreInvitators {
    [KTVMainService getStoreInvitators:self.store.storeId result:^(NSDictionary *result) {
        if (![result[@"code"] isEqualToString:ktvCode]) {
            return;
        }
        
        for (NSDictionary *dict in result[@"data"]) {
            KTVUser *user = [KTVUser yy_modelWithDictionary:dict];
            [self.invitatorList addObject:user];
        }
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
    }];
}

// 用户收藏门店
- (void)userCollectionStore {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *phone = [KTVCommon userInfo].phone;
    if (phone && self.store.storeId) {
        [params setObject:phone forKey:@"username"];
        [params setObject:self.store.storeId forKey:@"storeId"];
    }
    @WeakObj(self);
    [KTVMainService postUserCollect:params result:^(NSDictionary *result) {
        if ([result[@"code"] isEqualToString:ktvCode]) {
            [KTVToast toast:TOAST_COLLECT_SUCCESS];
            weakself.isCollection = YES;
            [weakself.userCollectionBtnItem setImage:[UIImage imageNamed:@"store_collection"]];
        } else {
            [KTVToast toast:result[@"detail"]];
        }
    }];
}

// 获取店铺是否收藏
- (void)getAlreadyUserCollection {
    NSString *phone = [KTVCommon userInfo].phone;
    safetyString(phone);
    @WeakObj(self);
    [KTVMainService getUserCollect:phone result:^(NSDictionary *result) {
        if ([result[@"code"] isEqualToString:ktvCode]) {
            for (NSDictionary *dic in result[@"data"]) {
                if ([dic[@"storeModel"][@"id"] integerValue] == weakself.store.storeId.integerValue) {
                    weakself.isCollection = YES;
                    [weakself.userCollectionBtnItem setImage:[UIImage imageNamed:@"store_collection"]];
                    return;
                }
            }
        }
    }];
}

- (void)cancelUserCollectStore {
    NSString *phone = [KTVCommon userInfo].phone;
    safetyString(phone);
    NSDictionary *params = @{@"username" : phone, @"storeId" : self.store.storeId};
    @WeakObj(self);
    [KTVMainService postUserCollectCancel:params result:^(NSDictionary *result) {
        if ([result[@"code"] isEqualToString:ktvCode]) {
            [weakself.userCollectionBtnItem setImage:[UIImage imageNamed:@"app_order_shouchang"]];
            weakself.isCollection = NO;
            [KTVToast toast:@"已经取消收藏"];
        }
    }];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 225;
    } else if (indexPath.section == 1) {
        return 50;
    } else if (indexPath.section == 2) {
        return 50;
    } else if (indexPath.section == 3) {
        return 145;
    } else if (indexPath.section == 4) {
        return 185;
    } else if (indexPath.section == 5) {
        return 40;
    }else {
        return 50;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:@"app_order_ding" title:@"预定" remark:@"2946人订过"];
        return headerView;
    } else if (section == 2) {
        NSString *title = [NSString stringWithFormat:@"(团购%@)", @(self.store.groupBuyList.count)];
        KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:@"app_order_tuan" title:title remark:nil];
        return headerView;
    } else if (section == 3) {
        KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:nil title:@"活动详情" remark:nil];
        return headerView;
    } else if (section == 4) {
        KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:nil title:@"点评" remark:@"2445条评论"];
        return headerView;
    } else if (section == 5) {
        KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:nil title:@"商家详情" remark:nil];
        return headerView;
    } else {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1 || section == 3 || section == 4 || section == 5) {
        return 28;
    } else if (section == 2) {
        return self.store.groupBuyList.count ? 28 : 0;
    } else {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 4) {
        return [self commentFooterView];
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 4) {
        return 44;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        if (indexPath.row > 1) {
            // 选座->选择套餐页面
            KTVPackageController *vc = (KTVPackageController *)[UIViewController storyboardName:@"MainPage" storyboardId:@"KTVPackageController"];
            vc.store = self.store;
            vc.package = self.package;
            [self.navigationController pushViewController:vc animated:YES];
        }
    } else if (indexPath.section == 2) {
        KTVGroupbuy *groupbuy = self.store.groupBuyList[indexPath.row];
        KTVGroupBuyDetailController *vc = (KTVGroupBuyDetailController *)[UIViewController storyboardName:@"MainPage" storyboardId:@"KTVGroupBuyDetailController"];
        vc.store = self.store;
        vc.groupbuy = groupbuy;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 2 + [self.store.packageList count];
    } else if (section == 2) {
        return self.store.groupBuyList.count;
    } else if (section == 3) {
        return 1;
    } else if (section == 4) {
        return 3;
    } else if (section == 5) {
        return 2;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        KTVBarKtvDetailHeaderCell *cell = (KTVBarKtvDetailHeaderCell *)[tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVBarKtvDetailHeaderCell)];
        cell.store = self.store;
        cell.invitorList = self.invitatorList;
        @WeakObj(self);
        cell.callback = ^(KTVStore *store) {
            KTVFriendDetailController *vc = (KTVFriendDetailController *)[UIViewController storyboardName:@"MePage" storyboardId:KTVStringClass(KTVFriendDetailController)];
            vc.store = store;
            [weakself.navigationController pushViewController:vc animated:YES];
        };
        cell.purikuraCallBack = ^(KTVStore *store) {
            NSString *url = @"http://ww4.sinaimg.cn/large/a15bd3a5jw1f12r9ku6wjj20u00mhn22.jpg";
            NSMutableArray *urlItems = @[].mutableCopy;
            for (NSInteger i = 0; i < 10; i++) {
                KSPhotoItem *item = [KSPhotoItem itemWithSourceView:[UIImageView new] imageUrl:[NSURL URLWithString:url]];
                [urlItems addObject:item];
            }
            KSPhotoBrowser *browser = [KSPhotoBrowser browserWithPhotoItems:urlItems selectedIndex:0];
            browser.delegate = weakself;
            browser.dismissalStyle = KSPhotoBrowserInteractiveDismissalStyleRotation;
            browser.backgroundStyle = KSPhotoBrowserBackgroundStyleBlur;
            browser.loadingStyle = KSPhotoBrowserImageLoadingStyleIndeterminate;
            browser.pageindicatorStyle = KSPhotoBrowserPageIndicatorStyleText;
            browser.bounces = NO;
            [browser showFromViewController:weakself];
        };
        return cell;
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            NSString *KTTimeFilterCellIdentifer = @"KTTimeFilterCell";
            KTTimeFilterCell *cell = [tableView dequeueReusableCellWithIdentifier:KTTimeFilterCellIdentifer];
            if (!cell) {
                NSArray *timefilterItems = [KTVUtil getFiltertimeByDay:7];
                cell = [[KTTimeFilterCell alloc] initWithItems:timefilterItems
                                               reuseIdentifier:KTTimeFilterCellIdentifer];
                cell.filterCallback = ^(NSInteger idx) {
                    CLog(@"-->> %@", timefilterItems[idx]);
                };
            }
            return cell;
        } else if (indexPath.row == 1) {
            NSString *KTVPositionFilterCellIdentifier = @"KTVPositionFilterCell";
            KTVPositionFilterCell *cell = [tableView dequeueReusableCellWithIdentifier:KTVPositionFilterCellIdentifier];
            if (!cell) {
                cell = [[KTVPositionFilterCell alloc] initWithPositionFilterItems:@[@"卡座(4-6人)",
                                                                                    @"VIP位置(8-10人)",
                                                                                    @"吧台¥(4-6人)",
                                                                                    @"包厢(15-20人)",
                                                                                    @"阳台(1-2人)",
                                                                                    @"沙发(2-3人)",
                                                                                    @"床上(2人)",]
                                                                  reuseIdentifier:KTVPositionFilterCellIdentifier];
            }
            return cell;
        } else {
            KTVPackage *package = self.store.packageList[indexPath.row - 2];
            KTVBarKtvReserveCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KTVBarKtvReserveCell"];
            cell.package = package;
            return cell;
        }
        
    } else if (indexPath.section == 2) {
        KTVPackageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KTVPackageCell"];
        KTVGroupbuy *groupbuy = self.store.groupBuyList[indexPath.row];
        cell.groupbuy = groupbuy;
        return cell;
    } else if (indexPath.section == 3) {
        KTVBarKtvBeautyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KTVBarKtvBeautyCell"];
        return cell;
    } else if (indexPath.section == 4) {
        KTVCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KTVCommentCell"];
        return cell;
    } else if (indexPath.section == 5) {
        if (indexPath.row == 0) {
            KTVDoBusinessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KTVDoBusinessCell"];
            return cell;
        } else {
            KTVOtherDianpuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KTVOtherDianpuCell"];
            return cell;
        }
    } else {
        return nil;
    }
    
}

#pragma mark - 自定义方法

- (UIView *)commentFooterView {
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor ktvSeparateBG];
    
    UIView *topView = [[UIView alloc] init];
    [bgView addSubview:topView];
    bgView.backgroundColor = [UIColor ktvBG];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.and.right.equalTo(bgView);
        make.height.equalTo(@(38));
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [topView addSubview:titleLabel];
    titleLabel.text = @"查看全部评论";
    titleLabel.font = [UIFont boldSystemFontOfSize:14];
    titleLabel.textColor = [UIColor ktvRed];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView).offset(10);
        make.centerY.equalTo(topView);
    }];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_arrow_right_hui"]];
    [topView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topView);
        make.right.equalTo(topView).offset(-10);
    }];
    
    UIView *bottomLine = [[UIView alloc] init];
    [bgView addSubview:bottomLine];
    bottomLine.backgroundColor = [UIColor ktvSeparateBG];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.and.right.equalTo(bgView);
        make.height.equalTo(@7);
    }];
    
    return bgView;
}

// MARK: - KSPhotoBrowserDelegate

- (void)ks_photoBrowser:(KSPhotoBrowser *)browser didSelectItem:(KSPhotoItem *)item atIndex:(NSUInteger)index {
    NSLog(@"selected index: %ld", index);
}

@end
