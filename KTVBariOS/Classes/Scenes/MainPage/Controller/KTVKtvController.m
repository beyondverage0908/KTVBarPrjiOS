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

@interface KTVKtvController ()<UITableViewDelegate, UITableViewDataSource, SDCycleScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation KTVKtvController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
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

- (IBAction)backBtnAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIView *)sectionFooterView:(NSString *)tip {
    UIView *allBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 35)];
    allBgView.backgroundColor = [UIColor ktvSeparateBG];
    
    UIButton *topBgView = [[UIButton alloc] init];
    topBgView.backgroundColor = [UIColor ktvBG];
    [allBgView addSubview:topBgView];
    [topBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.and.top.equalTo(allBgView);
        make.height.mas_equalTo(30);
    }];
    [topBgView addTarget:self action:@selector(loadMoreInfoAction:) forControlEvents:UIControlEventTouchUpInside];
    
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

- (void)loadMoreInfoAction:(UIButton *)btn {
    CLog(@"--->>> 查看其他2个团购");
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
    return [self sectionFooterView:@"2"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 40;
    }
    return 35;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section != 0) {
        if (indexPath.row == 0) {
            CLog(@"-- 酒吧KTV店铺详情");
            KTVBarKtvDetailController *vc = (KTVBarKtvDetailController *)[UIViewController storyboardName:@"MainPage" storyboardId:@"KTVBarKtvDetailController"];
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            CLog(@"-- 套餐页面");
            KTVPackageController *vc = (KTVPackageController *)[UIViewController storyboardName:@"MainPage" storyboardId:@"KTVPackageController"];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
        default:
            return 3;
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
            if (indexPath.row == 0) {
                KTVGuessLikeCell *cell = (KTVGuessLikeCell *)[tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVGuessLikeCell)];
                return cell;
            } else {
                KTVPackageCell *cell = (KTVPackageCell *)[tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVPackageCell)];
                return cell;
            }
        }
            break;
    }
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    CLog(@"--%@--酒吧首页--", @(index));
}

@end
