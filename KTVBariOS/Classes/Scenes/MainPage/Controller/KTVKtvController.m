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

@interface KTVKtvController ()<UITableViewDelegate, UITableViewDataSource, SDCycleScrollViewDelegate>{
    NSInteger _tapSectionIndex;
}

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableDictionary *mainParams;
@property (strong, nonatomic) NSMutableArray *storeContainerList;

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
}

#pragma mark - 网络

- (void)loadMainData {
    
    [self.mainParams setObject:@"0" forKey:@"storeType"];
    [self.mainParams setObject:@"500.0" forKey:@"distance"];
    [self.mainParams setObject:@"121.48789949" forKey:@"latitude"];
    [self.mainParams setObject:@"31.24916171" forKey:@"longitude"];
    [self.mainParams setObject:[NSNumber numberWithBool:YES] forKey:@"sortByDistance"];
    [self.mainParams setObject:[NSNumber numberWithBool:NO] forKey:@"sortByStar"];
    
    [KTVMainService postMainPage:self.mainParams result:^(NSDictionary *result) {
        if ([result[@"code"] isEqualToString:ktvCode]) {
            for (NSDictionary *dict in result[@"data"]) {
                KTVStoreContainer *storeContainer = [KTVStoreContainer yy_modelWithDictionary:dict];
                [self.storeContainerList addObject:storeContainer];
            }
            
            [self.tableView reloadData];
        } else {
            CLog(@"-- >> filure");
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
        KTVFilterView *filterView = [[KTVFilterView alloc] initWithFilter:@[@"KTV", @"附近", @"智能排序", @"筛选"]];
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
            return 1;
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
            NSArray *imgUrls = @[@"https://4.bp.blogspot.com/-cSkCJRk_MXM/U5yaVSt2JJI/AAAAAAAA-S0/KSLqYLNoiyw/s0/Girl+fashion+beauty.jpg",
                                 @"https://s10.favim.com/orig/160322/beauty-girl-hair-makeup-Favim.com-4104900.jpg",
                                 @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1501749823122&di=b250a8c94d39c217440391f9e6696af2&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F15%2F24%2F50%2F43Q58PICkj4_1024.jpg"];
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
    CLog(@"--%@--酒吧首页--", @(index));
}

@end
