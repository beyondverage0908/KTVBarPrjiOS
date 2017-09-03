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

@interface KTVSelectedBeautyController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIButton *cityBtn;
@property (weak, nonatomic) IBOutlet UIView *collectionHeaderView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *yueTaBtn;

@end

static NSInteger RowCount = 2;

@implementation KTVSelectedBeautyController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor ktvBG];
    self.collectionView.collectionViewLayout = [self setupFlowLayout];
    
    [self layoutCollectionHeader];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self hideNavigationBar:NO];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self hideNavigationBar:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    KTVFilterView *filterView = [[KTVFilterView alloc] initWithFilter:@[@"智能排序", @"性别"]];
    [self.collectionHeaderView addSubview:filterView];
    [filterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.collectionHeaderView);
    }];
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
}

- (IBAction)yueTaAction:(UIButton *)sender {
    CLog(@"选美女--约她");
}

- (IBAction)nextStepAction:(UIButton *)sender {
    CLog(@"选美女--下一步");
    KTVOrderUploadController *vc = (KTVOrderUploadController *)[UIViewController storyboardName:@"MainPage" storyboardId:@"KTVOrderUploadController"];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
   
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KTVBeautyGirlCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KTVBeautyGirlCollectionCell" forIndexPath:indexPath];
    return cell;
}

@end
