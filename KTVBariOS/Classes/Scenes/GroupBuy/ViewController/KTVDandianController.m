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
#import "KTVMainService.h"
#import "KTVAlertController.h"

static NSInteger RowCount = 2;

@interface KTVDandianController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *resetBtn;
@property (weak, nonatomic) IBOutlet UIButton *buycarBtn;
@property (weak, nonatomic) IBOutlet UIButton *payBtn;

@property (nonatomic, strong) NSMutableArray *goodsList;

@end

static NSString * HeaderID = @"KTVCollectionFilterView";

@implementation KTVDandianController

// MARK: override setter method

- (NSMutableDictionary<NSString *,NSMutableDictionary<NSString *,id> *> *)shoppingCartDict {
    if (!_shoppingCartDict) {
        _shoppingCartDict = [NSMutableDictionary new];
    }
    return _shoppingCartDict;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.store.storeName;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.collectionView.collectionViewLayout = [self setupFlowLayout];
    
    safetyArray(self.goodsList);
    
    [self getStoreGoodsWithStoreId:self.store.storeId];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.buycarBtn setTitle:[NSString stringWithFormat:@"购物车(%ld)", [self getShoppingCartCount:self.shoppingCartDict]] forState:UIControlStateNormal];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// 获取购物车中商品数目
- (NSInteger)getShoppingCartCount:(NSDictionary *)shoppingCart {
    NSInteger count = 0;
    for (NSString *goodId in shoppingCart.allKeys) {
        NSMutableDictionary *goodDic = [shoppingCart objectForKey:goodId];
        count += [[goodDic objectForKey:@"goodCount"] integerValue];
    }
    return count;
}

/// 商品添加到购物车
- (void)addToShoppingCart:(NSMutableDictionary *)shoppingCart good:(KTVGood *)good {
    NSMutableDictionary *cart = shoppingCart[good.goodId];
    if (cart) {
        cart[@"goodCount"] = @([cart[@"goodCount"] integerValue] + 1);
    } else {
        cart = [NSMutableDictionary dictionaryWithObjectsAndKeys:@(1), @"goodCount", good, @"goodKey", nil];
        [shoppingCart setObject:cart forKey:good.goodId];
    }
}

/// 商品从购物车中移除
- (void)removeShoppingCart:(NSMutableDictionary *)shoppingCart good:(KTVGood *)good {
    NSMutableDictionary *cart = shoppingCart[good.goodId];
    if (cart) {
        NSInteger goodCount = [cart[@"goodCount"] integerValue];
        if (goodCount - 1 >= 0) {
            cart[@"goodCount"] = @(goodCount - 1);
        } else {
            cart[@"goodCount"] = @(0);
        }
    }
}

/// 清空购物车所有商品
- (void)clearShppingCart {
    [self.shoppingCartDict removeAllObjects];
}

/// 创建单品购物车
- (NSMutableDictionary<NSString *, id> *)creatShopCartWithGood:(KTVGood *)good {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:@"0", @"goodCount", good, @"goodKey", nil];
}

/// 获取有效的购物车信息
- (NSMutableDictionary<NSString *, NSMutableDictionary<NSString *, id> *> *)getValidateShoppingCart {
    for (NSString *goodId in self.shoppingCartDict.allKeys) {
        NSMutableDictionary *shopCart = self.shoppingCartDict[goodId];
        if ([shopCart[@"goodCount"] integerValue] <= 0) {
            [self.shoppingCartDict removeObjectForKey:goodId];
        }
    }
    return self.shoppingCartDict;
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

// MARK: - 网络

- (void)getStoreGoodsWithStoreId:(NSString *)storeId {
    [KTVMainService getStoreGoods:storeId result:^(NSDictionary *result) {
        if ([result[@"code"] isEqualToString:ktvCode]) {
            if ([result[@"data"][@"goodList"] count]) {
                for (NSDictionary *goodDic in result[@"data"][@"goodList"]) {
                    [self.goodsList addObject:[KTVGood yy_modelWithDictionary:goodDic]];
                }
                [self.collectionView reloadData];
            } else {
                [KTVToast toast:@"商家无单选商品"];
            }
        } else {
            [KTVToast toast:@"无法获取商家商品"];
        }
    }];
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CLog(@"--->>> 选中某件商品");
    KTVBuycarPickerView *pickView = [[[NSBundle mainBundle] loadNibNamed:@"KTVBuycarPickerView" owner:nil options:nil] lastObject];
    pickView.frame = [UIScreen mainScreen].bounds;
    [[UIApplication sharedApplication].keyWindow addSubview:pickView];
    @WeakObj(self);
    pickView.operateShoppingCartCallBack = ^(BOOL isIn, KTVGood *good) {
        [weakself.buycarBtn setTitle:[NSString stringWithFormat:@"购物车(%ld)", [weakself getShoppingCartCount:weakself.shoppingCartDict]] forState:UIControlStateNormal];
    };
    pickView.operateShoppingCartCompeletion = ^(BOOL isConfirm, NSMutableDictionary *shopCart) {
        [weakself.buycarBtn setTitle:[NSString stringWithFormat:@"购物车(%ld)", [weakself getShoppingCartCount:weakself.shoppingCartDict]] forState:UIControlStateNormal];
    };
    
    // 用于显示的模版商品
    KTVGood *tempGood = self.goodsList[indexPath.row];
    pickView.tempGood = tempGood;
    // 购物车中多件相同的商品
    NSMutableDictionary *similarGoodDict = self.shoppingCartDict[tempGood.goodId];
    if (!similarGoodDict) {
        similarGoodDict = [self creatShopCartWithGood:tempGood];
        [self.shoppingCartDict setObject:similarGoodDict forKey:tempGood.goodId];
    }
    pickView.shopCart = similarGoodDict;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.goodsList count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KTVDandianItemCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KTVDandianItemCollectionCell" forIndexPath:indexPath];
    cell.good = self.goodsList[indexPath.row];
    @WeakObj(self);
    cell.buyCarCallBack = ^(BOOL buyIn, KTVGood *good) {
        if (buyIn) {
            [weakself addToShoppingCart:weakself.shoppingCartDict good:good];
        } else {
            [weakself removeShoppingCart:weakself.shoppingCartDict good:good];
        }
        [weakself.buycarBtn setTitle:[NSString stringWithFormat:@"购物车(%ld)", [weakself getShoppingCartCount:weakself.shoppingCartDict]] forState:UIControlStateNormal];
    };
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (kind == UICollectionElementKindSectionHeader) {
        KTVCollectionFilterView *filterView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderID forIndexPath:indexPath];
        filterView.filters = @[@"酒水", @"饮料", @"小吃", @"筛选"];
        return filterView;
        // [collectionView setContentOffset:CGPointMake(collectionView.contentOffset.x,  -60) animated:YES];
    }
    return nil;
}

#pragma mark - 控件事件

- (IBAction)resetAction:(UIButton *)sender {
    CLog(@"--->>> 购物车重置");
    [KTVAlertController alertMessage:@"请确定清空购物车" title:@"提示" confirmHandler:^(UIAlertAction *action) {
        [self clearShppingCart];
        [self.buycarBtn setTitle:[NSString stringWithFormat:@"购物车(%ld)", [self getShoppingCartCount:self.shoppingCartDict]] forState:UIControlStateNormal];
    } cancleHandler:^(UIAlertAction *action) {}];
}

- (IBAction)buycarAction:(UIButton *)sender {
    CLog(@"--->>> 点击购物车");
    KTVBuycarController *vc = (KTVBuycarController *)[UIViewController storyboardName:@"MainPage" storyboardId:@"KTVBuycarController"];
    vc.shoppingCartDict = [self getValidateShoppingCart];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)payAction:(UIButton *)sender {
    CLog(@"--->>> 购物车-立即支付");
    if (self.shoppingCartCallBack) {
        self.shoppingCartCallBack([self getValidateShoppingCart]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
@end
