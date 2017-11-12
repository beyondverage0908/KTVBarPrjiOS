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

static NSInteger RowCount = 2;

@implementation KTVSelectedBeautyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"邀约暖场人";
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor ktvBG];
    self.collectionView.collectionViewLayout = [self setupFlowLayout];
    
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
    
    CGFloat iWith = (SCREENW / RowCount) - 2.5;
    flowLayout.itemSize = CGSizeMake(iWith, iWith * 1.27f);
    flowLayout.minimumLineSpacing = 5.0f;
    flowLayout.minimumInteritemSpacing = 5.0f;
    
    return flowLayout;
}

- (void)layoutCollectionHeader {
    NSArray *dataS = @[@{@"智能排序" : @[@"北京", @"上海", @"南昌", @"合肥", @"宁波", @"杭州", @"石家庄"]},
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

- (IBAction)resetAction:(UIButton *)sender {
    CLog(@"选美女--重置");
    [self.selActivitorList removeAllObjects];
    [self resetBtnYueNumber:[self.selActivitorList count]];
    [self.collectionView reloadData];
}

- (IBAction)yueTaAction:(UIButton *)sender {
    CLog(@"选美女--约她");
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
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.activitorList count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KTVBeautyGirlCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KTVBeautyGirlCollectionCell" forIndexPath:indexPath];
    KTVUser *user = self.activitorList[indexPath.row];
    cell.user = user;
    
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

@end
