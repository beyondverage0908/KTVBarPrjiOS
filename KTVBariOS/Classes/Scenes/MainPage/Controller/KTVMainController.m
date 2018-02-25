//
//  KTVMainController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/7/13.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVMainController.h"
#import "KTVLoginGuideController.h"
#import "KTVBannerCell.h"
#import "KTVBarEnterMenuCell.h"
#import "KTVGuessLikeCell.h"
#import "KTVRecommendCell.h"

#import "KTVBarKtvDetailController.h"

#import "KTVMainService.h"
#import "KTVLoginService.h"

#import "KTVActivity.h"
#import "KTVBanner.h"

#import "KTVPaySuccessController.h"
#import "KTVSelectedBeautyController.h"

@interface KTVMainController ()<UITableViewDelegate, UITableViewDataSource, SDCycleScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *locationBtn;
@property (weak, nonatomic) IBOutlet UIImageView *locationImageView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIButton *scanQRbtn;

@property (strong, nonatomic) NSMutableArray<KTVStore *> *storeLikeList;
@property (strong, nonatomic) NSMutableArray<KTVActivity *> *activityList;
@property (strong, nonatomic) NSMutableArray<KTVBanner *> *bannerList;

@end

@implementation KTVMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
    [self initData];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor ktvBG];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    // 利用订单查询，获取是否为登陆状态
    //[self loadSearchOrderToJudgeLoginStatus];
    // 获取暖场人
    [self loadStoreLike];
    [self loadNearActivity];
    [self loadMianBanner];
    [self loadAppVersion];
    
    [self testCode];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self hideNavigationBar:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

// 初始化试图
- (void)setupView {
    self.searchBar.backgroundImage = [UIImage new];
}

// 初始化
- (void)initData {
    self.storeLikeList = [NSMutableArray array];
    self.activityList = [NSMutableArray array];
    self.bannerList = [NSMutableArray array];
}

#pragma mark - 网络

/// 查询订单 - 用来判断当前状态是否是登陆状态
/// 查询订单
- (void)loadSearchOrderToJudgeLoginStatus {
    NSString *phone = [KTVCommon userInfo].phone;
    if ([KTVUtil isNullString:phone]) {
        return;
    }
    NSDictionary *params = @{@"username" : phone, @"orderStatus" : @"1"};
    [KTVMainService postSearchOrder:params result:^(NSDictionary *result) {}];
}

/// 猜你喜欢
- (void)loadStoreLike {
    NSString *username = [KTVCommon userInfo].phone;
    safetyString(username);
    NSDictionary *params = @{@"storeType" : @(0),
                             @"username" : username};
    [KTVMainService postStoreLike:params result:^(NSDictionary *result) {
        if ([result[@"code"] isEqualToString:ktvCode]) {
            for (NSDictionary *dic in result[@"data"]) {
                KTVStore *store = [KTVStore yy_modelWithDictionary:dic];
                [self.storeLikeList addObject:store];
            }
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
        }
    }];
}

- (void)loadNearActivity {
    KTVAddress *address = [KTVCommon getUserLocation];
    NSDictionary *params = @{@"storeType" : @0,
                             @"latitude" : @(address.latitude),
                             @"longitude" : @(address.longitude)};
//    NSDictionary *params = @{@"storeType" : @0,
//                             @"latitude" : @(121.48789949),
//                             @"longitude" : @(31.24916171)};
    [KTVMainService postStoreNearActivity:params result:^(NSDictionary *result) {
        if ([result[@"code"] isEqualToString:ktvCode]) {
            for (NSDictionary *dic in result[@"data"]) {
                KTVActivity *activity = [KTVActivity yy_modelWithDictionary:dic];
                [self.activityList addObject:activity];
            }
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationNone];
        }
    }];
}

- (void)loadMianBanner {
    [KTVMainService getMainBanner:nil result:^(NSDictionary *result) {
        if ([result[@"code"] isEqualToString:ktvCode]) {
            for (NSDictionary *dic in result[@"data"]) {
                KTVBanner *banner = [KTVBanner yy_modelWithDictionary:dic];
                [self.bannerList addObject:banner];
            }
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
        }
    }];
}

- (void)loadAppVersion {
    NSDictionary *params = @{@"version" : [KTVUtil appVersion]};
    
    [KTVMainService getAppVersion:params result:^(NSDictionary *result) {
        if (![result[@"code"] isEqualToString:ktvCode]) {
            return;
        }
        BOOL needUpdate = [result[@"data"][@"needUpdate"] boolValue];
        if (needUpdate) {
            [KTVToast toast:@"Alert提示框，需要更新"];
        }
    }];
}

#pragma mark - 事件

- (void)tableHeaderAction:(UIButton *)btn {
    if (btn.tag == 2) {
        CLog(@"--->> 猜你喜欢");
    } else if (btn.tag == 3) {
        CLog(@"--->> 附近活动");
    }
}

#pragma mark - Section Header 封装方法

- (UIView *)tableViewHeader:(NSString *)title tableSection:(NSInteger)section {
    
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor ktvBG];
    
    UIButton *bgImgView = [[UIButton alloc] init];
    [bgView addSubview:bgImgView];
    [bgImgView setBackgroundImage:[UIImage imageNamed:@"mainpage_all_bg_line"] forState:UIControlStateNormal];
    [bgImgView addTarget:self action:@selector(tableHeaderAction:) forControlEvents:UIControlEventTouchUpInside];
    bgImgView.tag = section;
    [bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(bgView);
    }];
    
    UIView *leftLine = [[UIView alloc] init];
    [bgView addSubview:leftLine];
    leftLine.backgroundColor = [UIColor ktvRed];
    [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView);
        make.height.equalTo(bgView).multipliedBy(0.5f);
        make.width.mas_equalTo(2.0f);
        make.centerY.equalTo(bgView);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [bgView addSubview:titleLabel];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    titleLabel.text = title;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftLine.mas_right).offset(7.0f);
        make.centerY.equalTo(bgView);
    }];
    
    UIImageView *arrowImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_arrow_right_hui"]];
    [bgView addSubview:arrowImgView];
    [arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bgView);
        make.left.mas_equalTo(titleLabel.mas_right).offset(7.0f);
    }];
    
    return bgView;
}

#pragma mark - UITableViewDelegate 

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            return 145.0f;
        }
            break;
        case 1:
        {
            return 70.0f;
        }
            break;
        case 2:
        {
            return 115.0f;
        }
            break;
        case 3:
        {
            return 145.0f;
        }
            break;
        default:
        {
            return 0.0f;
        }
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 2 || section == 3) {
        return 40.0f;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 2) {
        return [self tableViewHeader:@"猜你喜欢" tableSection:section];
    } else if (section == 3) {
        return [self tableViewHeader:@"附近活动" tableSection:section];
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        CLog(@"-- 酒吧详情");
        KTVBarKtvDetailController *vc = (KTVBarKtvDetailController *)[UIViewController storyboardName:@"MainPage" storyboardId:@"KTVBarKtvDetailController"];
        KTVStore *store = self.storeLikeList[indexPath.row];
        vc.store = store;;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
        {
            if ([self.bannerList count]) {
                return 1;
            } else {
                return 0;
            }
        }
            break;
        case 1:
        {
            return 1;
        }
            break;
        case 2:
        {
            return [self.storeLikeList count];
        }
            break;
        case 3:
        {
            return [self.activityList count];
        }
        default:
        {
            return 0;
        }
            break;
    }
}
//KTVBarEnterMenuCell
//KTVGuessLikeCell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            NSArray *imgUrls = @[@"https://4.bp.blogspot.com/-cSkCJRk_MXM/U5yaVSt2JJI/AAAAAAAA-S0/KSLqYLNoiyw/s0/Girl+fashion+beauty.jpg",
                                 @"https://s10.favim.com/orig/160322/beauty-girl-hair-makeup-Favim.com-4104900.jpg",
                                 @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1501749823122&di=b250a8c94d39c217440391f9e6696af2&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F15%2F24%2F50%2F43Q58PICkj4_1024.jpg"];
            
            NSMutableArray *imgurlList = [NSMutableArray array];
            for (KTVBanner *banner in self.bannerList) {
                [imgurlList addObject:banner.picture.pictureUrl];
            }
            
            KTVBannerCell *cell = (KTVBannerCell *)[tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVBannerCell)];
            cell.sdBannerView.delegate = self;
            cell.sdBannerView.imageURLStringsGroup = imgurlList;
            return cell;
        }
            break;
        case 1:
        {
            KTVBarEnterMenuCell *cell = (KTVBarEnterMenuCell *)[tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVBarEnterMenuCell)];
            return cell;
        }
            break;
        case 2:
        {
            KTVGuessLikeCell *cell = (KTVGuessLikeCell *)[tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVGuessLikeCell)];
            KTVStore *store = self.storeLikeList[indexPath.row];
            cell.storee = store;
            return cell;
        }
            break;
        case 3:
        {
            KTVRecommendCell *cell = (KTVRecommendCell *)[tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVRecommendCell)];
            KTVActivity *activity = self.activityList[indexPath.row];
            cell.activity = activity;
            return cell;
        }
        default:
        {
            return [[UITableViewCell alloc] init];
        }
            break;
    }
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    CLog(@"--%@--main page banner click", @(index));
//    KTVLoginGuideController *guideVC = [[KTVLoginGuideController alloc] init];
//    KTVBaseNavigationViewController *nav = [[KTVBaseNavigationViewController alloc] initWithRootViewController:guideVC];
//    [self presentViewController:nav animated:YES completion:nil];
    
    [MBProgressHUD showMessage:@"加载中..."];
}

- (void)testCode {
//    KTVPaySuccessController *vc = (KTVPaySuccessController *)[UIViewController storyboardName:@"MainPage" storyboardId:@"KTVPaySuccessController"];
//    [self.navigationController pushViewController:vc animated:YES];
    
//    KTVSelectedBeautyController *vc = (KTVSelectedBeautyController *)[UIViewController storyboardName:@"MainPage" storyboardId:@"KTVSelectedBeautyController"];
//    [self.navigationController pushViewController:vc animated:YES];
}

@end
