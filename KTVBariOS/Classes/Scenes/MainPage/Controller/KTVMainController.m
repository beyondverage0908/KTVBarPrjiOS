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

@interface KTVMainController ()<UITableViewDelegate, UITableViewDataSource, SDCycleScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *locationBtn;
@property (weak, nonatomic) IBOutlet UIImageView *locationImageView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIButton *scanQRbtn;

@property (strong, nonatomic) KTVStore *store;

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
    
    // 获取暖场人
    [self loadStoreActivitors];
    [self loadStoreGoods];
    [self loadStore];
    [self loadStoreInvitators];
    [self loadUserInfo];
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
    
}

#pragma mark - 网络

// 获取门店暖场人
- (void)loadStoreActivitors {
    [KTVMainService getStoreActivitors:@"4" result:^(NSDictionary *result) {
        //CLog(@"-->> %@", result);
    }];
}

- (void)loadStoreGoods {
    [KTVMainService getStoreGoods:@"4" result:^(NSDictionary *result) {
        //CLog(@"-->> %@", result);
    }];
}

// 获取门店
- (void)loadStore {
    [KTVMainService getStore:@"4" result:^(NSDictionary *result) {
        if ([result[@"code"] isEqualToString:ktvCode]) {
            KTVStore *store = [KTVStore yy_modelWithDictionary:result[@"data"]];
            self.store = store;
            
            [self.tableView reloadData];
        }
    }];
}

- (void)loadStoreInvitators {
    [KTVMainService getStoreInvitators:@"4" result:^(NSDictionary *result) {
        //CLog(@"-->> %@", result);
    }];
}

- (void)loadUserInfo {
    KTVUser *user = [KTVCommon userInfo];
    [KTVLoginService getUserInfo:user.phone result:^(NSDictionary *result) {
        if ([result[@"code"] isEqualToString:ktvCode]) {
            NSDictionary *userinfo = result[@"data"];
            
            for (NSString *key in userinfo.allKeys) {
                NSString *value = [NSString stringWithFormat:@"%@", userinfo[key]];
                if (value && value.length) {
                    [KTVCommon setUserInfoKey:key infoValue:value];
                }
            }
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
        vc.store = self.store;
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
            return 1;
        }
            break;
        case 1:
        {
            return 1;
        }
            break;
        case 2:
        {
            return 1;
        }
            break;
        case 3:
        {
            return 1;
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
            KTVBannerCell *cell = (KTVBannerCell *)[tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVBannerCell)];
            cell.sdBannerView.delegate = self;
            cell.sdBannerView.imageURLStringsGroup = imgUrls;
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
            return cell;
        }
            break;
        case 3:
        {
            KTVRecommendCell *cell = (KTVRecommendCell *)[tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVRecommendCell)];
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
    KTVLoginGuideController *guideVC = [[KTVLoginGuideController alloc] init];
    KTVBaseNavigationViewController *nav = [[KTVBaseNavigationViewController alloc] initWithRootViewController:guideVC];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
