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

@interface KTVMainController ()<UITableViewDelegate, UITableViewDataSource, SDCycleScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *locationBtn;
@property (weak, nonatomic) IBOutlet UIImageView *locationImageView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIButton *scanQRbtn;

@property (strong, nonatomic) NSMutableDictionary *mainParams;

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
    
    [self loadMainData];
    [self loadStoreActivitors];
    [self loadStoreGoods];
    [self loadStore];
    [self loadStoreInvitators];
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
    self.mainParams = [NSMutableDictionary dictionary];
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
        CLog(@"--  main page data -- %@", result);
    }];
}

- (void)loadStoreActivitors {
    [KTVMainService getStoreActivitors:@"4" result:^(NSDictionary *result) {
        CLog(@"-->> %@", result);
    }];
}

- (void)loadStoreGoods {
    [KTVMainService getStoreGoods:@"4" result:^(NSDictionary *result) {
        CLog(@"-->> %@", result);
    }];
}

- (void)loadStore {
    [KTVMainService getStore:@"4" result:^(NSDictionary *result) {
        CLog(@"-->> %@", result);
    }];
}

- (void)loadStoreInvitators {
    [KTVMainService getStoreInvitators:@"4" result:^(NSDictionary *result) {
        CLog(@"-->> %@", result);
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
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40.0f)];
    bgView.backgroundColor = [UIColor ktvBG];
    
    UIImageView *bgImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainpage_all_bg_line"]];
    [bgView addSubview:bgImgView];
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
    titleLabel.text = @"猜你喜欢";
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        CLog(@"-- 酒吧详情");
        KTVBarKtvDetailController *vc = (KTVBarKtvDetailController *)[UIViewController storyboardName:@"MainPage" storyboardId:@"KTVBarKtvDetailController"];
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
