//
//  KTVKtvController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/12.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVKtvController.h"
#import "KTVBannerCell.h"
#import "KTVGuessLikeCell.h"
#import "KTVPackageCell.h"
#import "KTVFilterView.h"

#import "KTVBarKtvDetailController.h"
#import "KTVPackageController.h"
#import "KTVGroupBuyDetailController.h"

#import "KTVMainService.h"
#import "KTVBanner.h"

#import "KSPhotoBrowser.h"

@interface KTVKtvController ()<UITableViewDelegate, UITableViewDataSource, SDCycleScrollViewDelegate, KSPhotoBrowserDelegate>{
    NSInteger _tapSectionIndex;
}

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableDictionary *mainParams;
@property (strong, nonatomic) NSMutableArray *storeContainerList;
@property (nonatomic, strong) NSMutableArray<KTVBanner *> *bannerList;

@end

@implementation KTVKtvController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor ktvBG];
    
    // 数据初始化
    [self initData];
    // 获取酒吧/ktv主页数据
    [self loadMainData];
    [self loadMianBanner];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self hideNavigationBar:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 事件

- (IBAction)backBtnAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadMoreInfoAction:(UIButton *)btn {
    CLog(@"--->>> %@", @(btn.tag));
    _tapSectionIndex = btn.tag;
    KTVStoreContainer *storeContainer = self.storeContainerList[_tapSectionIndex - 1];
    storeContainer.store.showGroupbuy = YES;
    [self.tableView reloadData];
}

#pragma mark - 封装

- (UIView *)sectionFooterView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 5.0f)];
    view.backgroundColor = [UIColor ktvSeparateBG];
    return view;
}

- (UIView *)section:(NSInteger)section footerView:(NSString *)tip {
    UIView *allBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 35)];
    allBgView.backgroundColor = [UIColor ktvSeparateBG];
    
    UIButton *topBgView = [[UIButton alloc] init];
    topBgView.backgroundColor = [UIColor ktvBG];
    [allBgView addSubview:topBgView];
    [topBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.and.top.equalTo(allBgView);
        make.height.mas_equalTo(30);
    }];
    topBgView.tag = section;
    [topBgView addTarget:self action:@selector(loadMoreInfoAction:)
        forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *leftLabel = [[UILabel alloc] init];
    leftLabel.text = [NSString stringWithFormat:@"查看其他%@个团购", tip];
    leftLabel.textColor = [UIColor ktvRed];
    [topBgView addSubview:leftLabel];
    leftLabel.font = [UIFont boldSystemFontOfSize:12];
    [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(topBgView);
    }];
    
    UIImageView *downArrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_turn_down"]];
    [topBgView addSubview:downArrowImageView];
    [downArrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftLabel.mas_right).offset(5);
        make.centerY.equalTo(leftLabel);
    }];
    
    return allBgView;
}

#pragma mark - 初始化

- (void)initData {
    self.mainParams = [NSMutableDictionary dictionary];
    self.storeContainerList = [NSMutableArray array];
    self.bannerList = [NSMutableArray array];
}

#pragma mark - 方法

- (NSArray<NSString *> *)getBannerImageUrlList {
    NSMutableArray *list = [NSMutableArray arrayWithCapacity:[self.bannerList count]];
    for (KTVBanner *banner in self.bannerList) {
        [list addObject:banner.picture.pictureUrl];
    }
    return [list copy];
}

#pragma mark - 网络

- (void)loadMainData {
    KTVAddress *address = [KTVCommon getUserLocation];
    
    // storeType: 0 酒吧   storeType: 1 KTV
    [self.mainParams setObject:@"1" forKey:@"storeType"];
    [self.mainParams setObject:@"1500.0" forKey:@"distance"];
    [self.mainParams setObject:@(address.latitude) forKey:@"latitude"];
    [self.mainParams setObject:@(address.longitude) forKey:@"longitude"];
    [self.mainParams setObject:[NSNumber numberWithBool:YES] forKey:@"sortByDistance"];
    [self.mainParams setObject:[NSNumber numberWithBool:NO] forKey:@"sortByStar"];
    
    [KTVMainService postMainPage:self.mainParams result:^(NSDictionary *result) {
        if ([result[@"code"] isEqualToString:ktvCode] && [result[@"data"] count]) {
            for (NSDictionary *dict in result[@"data"]) {
                KTVStoreContainer *storeContainer = [KTVStoreContainer yy_modelWithDictionary:dict];
                [self.storeContainerList addObject:storeContainer];
            }
            
            [self.tableView reloadData];
        } else {
            [KTVToast toast:@"附近暂无商家入驻"];
            CLog(@"-- >> filure");
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
//            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            return 145.0f;
        }
            break;
        default:
        {
            if (indexPath.row == 0) {
                return 115.0f;
            } else {
                return 50.0f;
            }
        }
            break;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 0) {
        NSArray *dataS = @[@{@"酒吧" : @[@"酒吧", @"KTV"]},
                           @{@"附近" : @[@"200m", @"500m", @"1000m", @"5km", @"10km"]},
                           @{@"性别": @[@"男", @"女", @"不限"]},
                           @{@"智能排序": @[@"男", @"女", @"不限"]}];
        KTVFilterView *filterView = [[KTVFilterView alloc] initWithFilter:dataS];
        filterView.filterCallback = ^(NSDictionary *filterMap) {
            NSInteger idx = [dataS indexOfObject:filterMap];
            CLog(@"--->>> %@", @(idx));
        };
        return filterView;
    }
    
    // 是否显示团购
    NSInteger idx = section - 1;
    KTVStoreContainer *storeContainer = self.storeContainerList[idx];
    NSInteger groupbuyCount = [storeContainer.store.groupBuyList count];
    if (_tapSectionIndex == section) {
        return [self sectionFooterView];
    }
    if (groupbuyCount) {
        // 查看其他几个团购
        NSString *tip = [NSString stringWithFormat:@"%@", @(groupbuyCount)];
        return [self section:section footerView:tip];
    } else {
        return [self sectionFooterView];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 40;
    }
    // 是否显示团购
    NSInteger idx = section - 1;
    KTVStoreContainer *storeContainer = self.storeContainerList[idx];
    NSInteger groupbuyCount = [storeContainer.store.groupBuyList count];
    
    if (_tapSectionIndex == section) {
        return 5.0f;
    }
    return groupbuyCount ? 35.0f : 5.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        // banner
    } else {
        
        // 获取店铺对象
        NSInteger idx = indexPath.section - 1;
        KTVStoreContainer *storeContainer = self.storeContainerList[idx];
        
        if (indexPath.row == 0) {
            // 店面cell
            // 店铺详情(酒吧选座)
            KTVBarKtvDetailController *vc = (KTVBarKtvDetailController *)[UIViewController storyboardName:@"MainPage" storyboardId:@"KTVBarKtvDetailController"];
            vc.store = storeContainer.store;
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            if (indexPath.row > 0 && indexPath.row < (1 + storeContainer.store.packageList.count)) {
                KTVPackage *package = storeContainer.store.packageList[indexPath.row - 1];
                // 店铺详情(酒吧选座)
                KTVBarKtvDetailController *vc = (KTVBarKtvDetailController *)[UIViewController storyboardName:@"MainPage" storyboardId:@"KTVBarKtvDetailController"];
                vc.package = package;
                vc.store = storeContainer.store;
                [self.navigationController pushViewController:vc animated:YES];
            } else if (indexPath.row > [storeContainer.store.packageList count]) {
                KTVGroupbuy *groupbuy = storeContainer.store.groupBuyList[indexPath.row - [storeContainer.store.packageList count] - 1];
                // 进入团购详情页面
                KTVGroupBuyDetailController *vc = (KTVGroupBuyDetailController *)[UIViewController storyboardName:@"MainPage" storyboardId:@"KTVGroupBuyDetailController"];
                vc.groupbuy = groupbuy;
                vc.store = storeContainer.store;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1 + [self.storeContainerList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
        {
            if ([self.bannerList count]) {
                return 1;
            }
            return 0;
        }
            break;
        default:
        {
            NSInteger index = section - 1;
            KTVStoreContainer *storeContainer = self.storeContainerList[index];
            if (storeContainer.store.showGroupbuy) {
                return 1 + storeContainer.store.packageList.count + storeContainer.store.groupBuyList.count;
            }
            return 1 + storeContainer.store.packageList.count;
        }
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            NSArray *imgUrls = [self getBannerImageUrlList];
            KTVBannerCell *cell = (KTVBannerCell *)[tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVBannerCell)];
            cell.sdBannerView.delegate = self;
            cell.sdBannerView.imageURLStringsGroup = imgUrls;
            return cell;
        }
            break;
        default:
        {
            NSInteger idx = indexPath.section - 1;
            KTVStoreContainer *storeContainer = self.storeContainerList[idx];
            if (indexPath.row == 0) {
                KTVGuessLikeCell *cell = (KTVGuessLikeCell *)[tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVGuessLikeCell)];
                cell.storeContainer = storeContainer;
                return cell;
            }
            KTVPackageCell *cell = (KTVPackageCell *)[tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVPackageCell)];
            if (indexPath.row > 0 && indexPath.row < (1 + storeContainer.store.packageList.count)) {
                // 套餐对象
                KTVPackage *package = storeContainer.store.packageList[indexPath.row - 1];
                cell.package = package;
            } else if (indexPath.row > [storeContainer.store.packageList count]) {
                // 团购对象
                KTVGroupbuy *groupbuy = storeContainer.store.groupBuyList[indexPath.row - [storeContainer.store.packageList count] - 1];
                cell.groupbuy = groupbuy;
            }
            
            return cell;
        }
            break;
    }
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSArray *imgUrls = [self getBannerImageUrlList];
    NSMutableArray *urlItems = @[].mutableCopy;
    for (NSString *url in imgUrls) {
        KSPhotoItem *item = [KSPhotoItem itemWithSourceView:[UIImageView new] imageUrl:[NSURL URLWithString:url]];
        [urlItems addObject:item];
    }
    
    KSPhotoBrowser *browser = [KSPhotoBrowser browserWithPhotoItems:urlItems selectedIndex:index];
    browser.delegate = self;
    browser.dismissalStyle = KSPhotoBrowserInteractiveDismissalStyleRotation;
    browser.backgroundStyle = KSPhotoBrowserBackgroundStyleBlur;
    browser.loadingStyle = KSPhotoBrowserImageLoadingStyleIndeterminate;
    browser.pageindicatorStyle = KSPhotoBrowserPageIndicatorStyleText;
    browser.bounces = NO;
    [browser showFromViewController:self];
}

// MARK: - KSPhotoBrowserDelegate

- (void)ks_photoBrowser:(KSPhotoBrowser *)browser didSelectItem:(KSPhotoItem *)item atIndex:(NSUInteger)index {
    NSLog(@"selected index: %ld", index);
}

@end
