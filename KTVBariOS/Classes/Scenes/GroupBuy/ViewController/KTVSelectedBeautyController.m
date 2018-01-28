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

@interface KTVSelectedBeautyController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIButton *cityBtn;
@property (weak, nonatomic) IBOutlet UIView *collectionHeaderView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *yueTaBtn;

@property (strong, nonatomic) NSMutableArray *activitorList;    // 暖场人列表
@property (strong, nonatomic) NSMutableArray *selActivitorList; // 已约的暖场人列表

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
    
    [self layoutCollectionHeader];
    
    [self initData];
    
    // 获取暖场人
    [self loadStoreActivitors];
}

- (void)initData {
    self.activitorList = [NSMutableArray array];
    self.selActivitorList = [NSMutableArray array];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 网络

// 获取暖场人
- (void)loadStoreActivitors {
    [KTVMainService getStoreActivitors:self.store.storeId result:^(NSDictionary *result) {
        if (![result[@"msg"] isEqualToString:ktvSuccess]) {
            return;
        }
        
        NSArray *activitorList = result[@"data"][@"activitorList"];
        for (NSDictionary *dict in activitorList) {
            KTVUser *user = [KTVUser yy_modelWithDictionary:dict];
            [self.activitorList addObject:user];
        }
        
        [self.collectionView reloadData];
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
    NSArray *dataS = @[@{@"暖场人类型" : @[@"可爱", @"清纯", @"淑女", @"熟女"]},
                       @{@"性别": @[@"男", @"女", @"不限"]}];
    KTVFilterView *filterView = [[KTVFilterView alloc] initWithFilter:dataS];
    [self.collectionHeaderView addSubview:filterView];
    
    [filterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.collectionHeaderView);
    }];

    filterView.filterCallback = ^(NSDictionary *filterMap) {
        NSInteger idx = [dataS indexOfObject:filterMap];
        CLog(@"--->>> %@", filterMap);
    };
    filterView.filterDitailCallback = ^(NSString *filterDetailKey) {
        CLog(@"--->>> %@", filterDetailKey);
    };
}

#pragma mark - 事件
- (IBAction)selectionCityAction:(UIButton *)sender {
    CLog(@"选择城市");
}

- (IBAction)popAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)nextStepAction:(UIButton *)sender {
    CLog(@"选美女--下一步");
    
    for (KTVUser *user in self.selActivitorList) {
        if (![self.selectedActivitorList containsObject:user]) {
            [self.selectedActivitorList addObject:user];
        }
    }
    
    KTVOrderUploadController *vc = (KTVOrderUploadController *)[UIViewController storyboardName:@"MainPage" storyboardId:@"KTVOrderUploadController"];
    vc.store = self.store;
    vc.groupbuy = self.groupbuy;
    vc.selectedActivitorList = self.selectedActivitorList;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 封装

- (void)resetBtnYueNumber:(NSInteger)yueNumber {
    NSString *yueStr = [NSString stringWithFormat:@"约TA(%@)", @(yueNumber)];
    [self.yueTaBtn setTitle:yueStr forState:UIControlStateNormal];
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
   
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return [self.activitorList count];
    if (section == 0) {
        return 7;
    } else if (section == 1) {
        return 5;
    } else if (section == 2) {
        return 11;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KTVBeautyGirlCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KTVBeautyGirlCollectionCell" forIndexPath:indexPath];
//    KTVUser *user = self.activitorList[indexPath.row];
//    cell.user = user;
    
    cell.callback = ^(KTVUser *user, BOOL isSelected) {
        if (isSelected) {
            [self.selActivitorList addObject:user];
        } else {
            [self.selActivitorList removeObject:user];
            if ([self.selectedActivitorList containsObject:user]) {
                [self.selectedActivitorList removeObject:user];
            }
        }
        
        [self resetBtnYueNumber:[self.selActivitorList count]];
    };
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        KTVBeeCollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"KTVBeeCollectionHeaderView" forIndexPath:indexPath];
        reusableView = headerView;
        headerView.type = indexPath.section;
    }
    
    if (kind == UICollectionElementKindSectionFooter) {
        KTVBeeCollectionFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"KTVBeeCollectionFooterView" forIndexPath:indexPath];
        @WeakObj(self);
        footerView.findMoreCallback = ^(NSInteger type) {
            KTVSelectedBeautyController *vc = (KTVSelectedBeautyController *)[UIViewController storyboardName:@"MainPage" storyboardId:@"KTVSelectedBeautyController"];
            [weakself.navigationController pushViewController:vc animated:YES];
        };
        reusableView = footerView;
    }
    return reusableView;
}

@end
