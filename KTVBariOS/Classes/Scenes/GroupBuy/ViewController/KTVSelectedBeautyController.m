//
//  KTVSelectedBeautyController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/30.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVSelectedBeautyController.h"
#import "KTVOrderUploadController.h"
#import "KTVBeautyGirlCollectionCell.h"
#import "KTVFilterView.h"
#import "KTVBeeCollectionHeaderView.h"
#import "KTVBeeCollectionFooterView.h"
#import "KTVMainService.h"
#import "KTVUser.h"
#import "KTVUserInfoController.h"

@interface KTVSelectedBeautyController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIButton *cityBtn;
@property (weak, nonatomic) IBOutlet UIView *collectionHeaderView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *yueTaBtn;
@property (strong, nonatomic) KTVFilterView *filterView;

@property (strong, nonatomic) NSMutableDictionary *typeActivitorDic;


@end

static NSInteger RowCount = 3;

@implementation KTVSelectedBeautyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"邀约暖场人";
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor ktvBG];
    self.collectionView.collectionViewLayout = [self setupFlowLayout];
    self.view.backgroundColor = [UIColor ktvBG];
    
    // 获取暖场人
    if (self.warmerType == MultipleWarmerType) {
        [self loadPayAfterWarmer];
        // 过滤
        NSArray *filterDatas = @[@{@"暖场人类型" : @[@"可爱", @"清纯"]},
                           @{@"性别": @[@"男", @"女", @"不限"]}];
        self.filterView = [[KTVFilterView alloc] initWithFilter:filterDatas];
    } else {
        [self.collectionView setContentOffset:CGPointZero animated:YES];
    }
    
    [self layoutCollectionHeader];
    [self initData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.filterView remove];
}

- (void)initData {
    self.typeActivitorDic = [NSMutableDictionary dictionary];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 网络

- (void)loadPayAfterWarmer {
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:7];
    [params setObject:@([KTVCommon getUserLocation].latitude) forKey:@"latitude"];
    [params setObject:@([KTVCommon getUserLocation].longitude) forKey:@"longitude"];
    [params setObject:self.store.storeId forKey:@"storeId"];
    [params setObject:@"" forKey:@"warmerName"];
    [params setObject:@1000 forKey:@"distance"];
    [params setObject:@"" forKey:@"sex"];
    [params setObject:@"" forKey:@"warmerUserType"];
    
    NSMutableArray *fixedActivitorList  = [NSMutableArray arrayWithCapacity:30];
    NSMutableArray *longtimeActivitorList  = [NSMutableArray arrayWithCapacity:30];
    NSMutableArray *parttimeActivitorList  = [NSMutableArray arrayWithCapacity:30];
    
    @WeakObj(self);
    [KTVMainService postPayAfterWarmer:params result:^(NSDictionary *result) {
        if ([result[@"code"] isEqualToString:ktvCode]) {
            for (NSDictionary *warmerDic in result[@"data"]) {
                KTVUser *warmer = [KTVUser yy_modelWithDictionary:warmerDic];
                if (warmer.userType == 3) {
                    [fixedActivitorList addObject:warmer];
                } else if (warmer.userType == 4) {
                    [longtimeActivitorList addObject:warmer];
                } else if (warmer.userType == 5) {
                    [parttimeActivitorList addObject:warmer];
                }
            }
            
            // 已经选中的重新赋值
            for (KTVUser *fixedUser in fixedActivitorList) {
                for (KTVUser *selectedUser in weakself.selectedActivitorList) {
                    if (selectedUser.userType == fixedUser.userType && [selectedUser.userId isEqualToString:fixedUser.userId] && selectedUser.isSelected ) {
                        fixedUser.isSelected = YES;
                    }
                }
            }
            
            for (KTVUser *longtimeUser in longtimeActivitorList) {
                for (KTVUser *selectedUser in weakself.selectedActivitorList) {
                    if (selectedUser.userType == longtimeUser.userType && [selectedUser.userId isEqualToString:longtimeUser.userId] && selectedUser.isSelected ) {
                        longtimeUser.isSelected = YES;
                    }
                }
            }
            
            for (KTVUser *parttimeUser in parttimeActivitorList) {
                for (KTVUser *selectedUser in weakself.selectedActivitorList) {
                    if (selectedUser.userType == parttimeUser.userType && [selectedUser.userId isEqualToString:parttimeUser.userId] && selectedUser.isSelected ) {
                        parttimeUser.isSelected = YES;
                    }
                }
            }
            
            [self.typeActivitorDic setObject:fixedActivitorList forKey:@"fixed"];
            [self.typeActivitorDic setObject:longtimeActivitorList forKey:@"longtime"];
            [self.typeActivitorDic setObject:parttimeActivitorList forKey:@"parttime"];
            
            [self.collectionView reloadData];
        }
    }];
}

#pragma mark - 布局

- (UICollectionViewFlowLayout *)setupFlowLayout {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    CGFloat iWith = (SCREENW / RowCount) - 0.1;
    flowLayout.itemSize = CGSizeMake(iWith, iWith * 1.33f);
    flowLayout.minimumLineSpacing = 0.0f;
    flowLayout.minimumInteritemSpacing = 0.0f;
    
    flowLayout.headerReferenceSize = CGSizeMake(self.collectionView.frame.size.width, 35);
    flowLayout.footerReferenceSize = CGSizeMake(self.collectionView.frame.size.width, 40);
    return flowLayout;
}

- (void)layoutCollectionHeader {
    if (self.warmerType == MultipleWarmerType) {
    
        [self.collectionHeaderView addSubview:self.filterView];
        
        [self.filterView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.collectionHeaderView);
        }];
        
        self.filterView.filterCallback = ^(NSDictionary *filterMap) {
            CLog(@"--->>> %@", filterMap);
        };
        self.filterView.filterDitailCallback = ^(NSString *filterDetailKey) {
            CLog(@"--->>> %@", filterDetailKey);
        };
    } else {
        self.collectionHeaderView.hidden = YES;
        UIView *superView = self.view;
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (@available(iOS 11.0, *)) {
                make.top.equalTo(superView.mas_safeAreaLayoutGuideTop).offset(64 + 40);
            } else {
                // Fallback on earlier versions
                make.top.equalTo(superView.mas_topMargin);
            }
            if (@available(iOS 11.0, *)) {
                make.top.equalTo(superView.mas_safeAreaLayoutGuideBottom);
            } else {
                // Fallback on earlier versions
                make.top.equalTo(superView.mas_bottomMargin);
            }
            make.left.and.right.equalTo(superView);
        }];
    }
}

#pragma mark - 事件
- (IBAction)selectionCityAction:(UIButton *)sender {
    CLog(@"选择城市");
}

- (IBAction)confirmSelectedAction:(id)sender {
    CLog(@"-- 确定");
    if (self.selectedWarmerCallback) {
        self.selectedWarmerCallback(self.selectedActivitorList);
    }
    if (self.warmerType == MultipleWarmerType) {
        
    } else {
        
    }
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 封装

- (void)resetBtnYueNumber:(NSInteger)yueNumber {
    NSString *yueStr = [NSString stringWithFormat:@"约TA(%@)", @(yueNumber)];
    [self.yueTaBtn setTitle:yueStr forState:UIControlStateNormal];
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    KTVUser *user = nil;
    if (self.warmerType == MultipleWarmerType) {
        if (indexPath.section == 0) {
            NSArray *fixedActivitorList = [self.typeActivitorDic objectForKey:@"fixed"];
            user = fixedActivitorList[indexPath.row];
        } else if (indexPath.section == 1) {
            NSArray *longtimeActivitorList = [self.typeActivitorDic objectForKey:@"longtime"];
            user = longtimeActivitorList[indexPath.row];
        } else if (indexPath.section == 2) {
            NSArray *parttimeActivitorList = [self.typeActivitorDic objectForKey:@"parttime"];
            user = parttimeActivitorList[indexPath.row];
        }
    } else {
        user = self.singleWarmerList[indexPath.row];
    }
    KTVUserInfoController *vc = (KTVUserInfoController *)[UIViewController storyboardName:@"MePage" storyboardId:@"KTVUserInfoController"];
    vc.isMySelf = NO;
    vc.user = user;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (self.warmerType == MultipleWarmerType) {
        return self.typeActivitorDic.allKeys.count;
    } else {
        return 1;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.warmerType == MultipleWarmerType) {
        if (section == 0) {
            NSArray *fixedActivitorList = [self.typeActivitorDic objectForKey:@"fixed"];
            return [fixedActivitorList count];
        } else if (section == 1) {
            NSArray *longtimeActivitorList = [self.typeActivitorDic objectForKey:@"longtime"];
            return [longtimeActivitorList count];
        } else if (section == 2) {
            NSArray *parttimeActivitorList = [self.typeActivitorDic objectForKey:@"parttime"];
            return [parttimeActivitorList count];
        }
    } else {
        return [self.singleWarmerList count];
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KTVBeautyGirlCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KTVBeautyGirlCollectionCell" forIndexPath:indexPath];
    if (self.warmerType == MultipleWarmerType) {
        if (indexPath.section == 0) {
            NSArray *fixedActivitorList = [self.typeActivitorDic objectForKey:@"fixed"];
            KTVUser *user = fixedActivitorList[indexPath.row];
            cell.user = user;
        } else if (indexPath.section == 1) {
            NSArray *longtimeActivitorList = [self.typeActivitorDic objectForKey:@"longtime"];
            KTVUser *user = longtimeActivitorList[indexPath.row];
            cell.user = user;
        } else if (indexPath.section == 2) {
            NSArray *parttimeActivitorList = [self.typeActivitorDic objectForKey:@"parttime"];
            KTVUser *user = parttimeActivitorList[indexPath.row];
            cell.user = user;
        }
    } else {
        KTVUser *user = self.singleWarmerList[indexPath.row];
        cell.user = user;
    }
    @WeakObj(self);
    cell.callback = ^(KTVUser *user) {
        if (user.isSelected) {
            BOOL isContain = NO;
            for (KTVUser *selUser in weakself.selectedActivitorList) {
                if ([user.userId isEqualToString:selUser.userId]) {
                    isContain = YES;
                    break;
                }
            }
            if (!isContain) [weakself.selectedActivitorList addObject:user];
        } else {
            KTVUser *targetUser = nil;
            for (KTVUser *selUser in weakself.selectedActivitorList) {
                if ([user.userId isEqualToString:selUser.userId]) {
                    targetUser = selUser;
                    break;
                }
            }
            [weakself.selectedActivitorList removeObject:targetUser];
        }
    };
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        KTVBeeCollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"KTVBeeCollectionHeaderView" forIndexPath:indexPath];
        reusableView = headerView;
        headerView.type = indexPath.section;
        return reusableView;
    }
    

    if (kind == UICollectionElementKindSectionFooter) {
        KTVBeeCollectionFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"KTVBeeCollectionFooterView" forIndexPath:indexPath];
        if (self.warmerType == MultipleWarmerType) {
            @WeakObj(self);
            footerView.findMoreCallback = ^(NSInteger type) {
                KTVSelectedBeautyController *vc = (KTVSelectedBeautyController *)[UIViewController storyboardName:@"MainPage" storyboardId:@"KTVSelectedBeautyController"];
                vc.warmerType = SingleWarmerType;
                NSArray *singleWarmerList = nil;
                if (indexPath.section == 0) {
                    singleWarmerList = [weakself.typeActivitorDic objectForKey:@"fixed"];
                } else if (indexPath.section == 1) {
                    singleWarmerList = [weakself.typeActivitorDic objectForKey:@"longtime"];
                } else if (indexPath.section == 2) {
                    singleWarmerList = [weakself.typeActivitorDic objectForKey:@"parttime"];
                }
                vc.singleWarmerList = singleWarmerList;
                [weakself.navigationController pushViewController:vc animated:YES];
            };
            footerView.hidden = NO;
        } else {
            footerView.hidden = YES;
        }
        reusableView = footerView;
    }
    return reusableView;
}

@end
