//
//  KTVDandianController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/27.
//  Copyright © 2017年 Lin. All rights reserved.
//
//  单点商品

#import "KTVDandianController.h"
#import "KTVBuycarController.h"

#import "KTVDandianItemCollectionCell.h"

#import "KTVCollectionFilterView.h"
#import "KTVBuycarPickerView.h"

static NSInteger RowCount = 2;

@interface KTVDandianController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *resetBtn;
@property (weak, nonatomic) IBOutlet UIButton *buycarBtn;
@property (weak, nonatomic) IBOutlet UIButton *payBtn;

@end

static NSString * HeaderID = @"KTVCollectionFilterView";

@implementation KTVDandianController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"诺亚方舟酒吧";
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.collectionView.collectionViewLayout = [self setupFlowLayout];;
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
    //self.flowLayout.headerReferenceSize = CGSizeMake(self.view.bounds.size.width, 12);
    
    [self.collectionView registerClass:[KTVCollectionFilterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderID];
    flowLayout.headerReferenceSize = CGSizeMake(SCREENW, 44.0f);
    
    return flowLayout;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CLog(@"--->>> 选中某件商品");
    KTVBuycarPickerView *pickView = [[[NSBundle mainBundle] loadNibNamed:@"KTVBuycarPickerView" owner:nil options:nil] lastObject];
    pickView.frame = [UIScreen mainScreen].bounds;
    [[UIApplication sharedApplication].keyWindow addSubview:pickView];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KTVDandianItemCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KTVDandianItemCollectionCell" forIndexPath:indexPath];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (kind == UICollectionElementKindSectionHeader) {
        KTVCollectionFilterView *filterView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderID forIndexPath:indexPath];
        filterView.filters = @[@"酒水", @"饮料", @"小吃", @"筛选"];
        return filterView;
    }
    return nil;
}

#pragma mark - 控件事件

- (IBAction)resetAction:(UIButton *)sender {
    CLog(@"--->>> 购物车重置");
}

- (IBAction)buycarAction:(UIButton *)sender {
    CLog(@"--->>> 点击购物车");
    KTVBuycarController *vc = (KTVBuycarController *)[UIViewController storyboardName:@"MainPage" storyboardId:@"KTVBuycarController"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)payAction:(UIButton *)sender {
    CLog(@"--->>> 立即支付");
}
@end
