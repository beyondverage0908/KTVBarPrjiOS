//
//  KTVPackageController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/14.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVPackageController.h"
#import "KTVBarKtvDetailHeaderCell.h"
#import "KTVIntroduceCell.h"
#import "KTVPackageDetailCell.h"
#import "KTVYuePaoUserCell.h"

#import "KTVTableHeaderView.h"

#import "KTVPackageDetailController.h"
#import "KTVOrderConfirmController.h"
#import "KTVShareFriendController.h"
#import "KTVSelectedBeautyController.h"
#import "KTVFriendDetailController.h"
#import "KTVLittleBeeController.h"
#import "KTVDandianController.h"
#import "KTVShop.h"

#import "KTVMainService.h"

#import "KSPhotoBrowser.h"

@interface KTVPackageController ()<UITableViewDelegate, UITableViewDataSource, KSPhotoBrowserDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UILabel *moneyLabel;

@property (strong, nonatomic) NSMutableArray<KTVUser *> *selectedActivitorList; // 选中的暖场人
@property (strong, nonatomic) NSMutableArray<KTVUser *> *activitorList; // 暖场人列表
@property (assign, nonatomic) NSInteger activitorPage;      // 分页获取暖场人
@property (strong, nonatomic) NSMutableArray<KTVUser *> * invitatorList;
/// 单点 - 购物车
@property (strong, nonatomic) NSDictionary *shoppingCart; // 单点商品
@property (strong, nonatomic) NSMutableArray<KTVShop *> *shopCartList; // 单点商品

@end

@implementation KTVPackageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择套餐";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor ktvBG];
    
    self.tableView.tableFooterView = [self tableViewFooter];
    
    // 默认选中第一个套餐
    if ([self.store.packageList count]) {
        KTVPackage *package = [self.store.packageList firstObject];
        package.isSelected = YES;
    }
    
    [self initData];
    [self initUI];
    
    [self loadStoreInvitators];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self hideNavigationBar:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark - 重写

- (NSMutableArray<KTVUser *> *)invitatorList {
    if (!_invitatorList) {
        _invitatorList = [NSMutableArray array];
    }
    return _invitatorList;
}

#pragma mark - 初始化

- (void)initUI {
    self.moneyLabel.text = [NSString stringWithFormat:@"¥%@", [self getOrderMoney]];
}

- (void)initData {
    self.selectedActivitorList = [NSMutableArray array];
    self.activitorList = [NSMutableArray array];
}

#pragma mark - 网络

/// 获取门店在约人数
- (void)loadStoreInvitators {
    [KTVMainService getStoreInvitators:self.store.storeId result:^(NSDictionary *result) {
        if (![result[@"code"] isEqualToString:ktvCode]) {
            return;
        }
        
        for (NSDictionary *dict in result[@"data"]) {
            KTVUser *user = [KTVUser yy_modelWithDictionary:dict];
            [self.invitatorList addObject:user];
        }
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
    }];
}

#pragma mark - UITableView Header Footer

- (UIView *)tableViewFooter {
    UIView *allBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 128)];
    
    UIView *aheadView = [[UIView alloc] init];
    [allBgView addSubview:aheadView];
    aheadView.backgroundColor = [UIColor ktvSeparateBG];
    [aheadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.and.top.equalTo(allBgView);
        make.height.mas_equalTo(@35);
    }];
    
    UIImageView *aheadImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainpage_all_bg_line"]];
    [aheadView addSubview:aheadImageView];
    [aheadImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.and.bottom.equalTo(aheadView);
        make.height.mas_equalTo(@29);
    }];
    
    UIButton *alertBtn = [[UIButton alloc] init];
    [aheadImageView addSubview:alertBtn];
    [alertBtn setBackgroundColor:[UIColor redColor]];
    [alertBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(aheadImageView).offset(10);
        make.width.height.equalTo(@10);
        make.centerY.equalTo(aheadImageView);
    }];
    
    UILabel *alertTimeLabel = [[UILabel alloc] init];
    [aheadImageView addSubview:alertTimeLabel];
    alertTimeLabel.text = @"周日(07-02) 14:00";
    alertTimeLabel.textColor = [UIColor ktvPurple];
    alertTimeLabel.font = [UIFont boldSystemFontOfSize:13];
    [alertTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(alertBtn.mas_right).offset(10);
        make.centerY.equalTo(aheadImageView);
    }];
    
    UILabel *alertLabel = [[UILabel alloc] init];
    [aheadImageView addSubview:alertLabel];
    alertLabel.text = @"钱可随时退，逾期不可退款";
    alertLabel.textColor = [UIColor ktvGray];
    alertLabel.font = [UIFont boldSystemFontOfSize:13];
    [alertLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(alertTimeLabel.mas_right).offset(10);
        make.centerY.equalTo(aheadImageView);
    }];
    
    UIImageView *downImageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainpage_all_bg_line"]];
    [allBgView addSubview:downImageview];
    downImageview.userInteractionEnabled = YES;
    [downImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(aheadView.mas_bottom);
        make.left.and.right.equalTo(allBgView);
        make.height.equalTo(@93);
    }];
    
    self.moneyLabel = [[UILabel alloc] init];
    [downImageview addSubview:self.moneyLabel];
    self.moneyLabel.text = @"¥0";
    self.moneyLabel.textColor = [UIColor ktvGold];
    self.moneyLabel.font = [UIFont boldSystemFontOfSize:25];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(downImageview).offset(10);
        make.centerY.equalTo(downImageview);
    }];
    
    UIButton *payBtn = [[UIButton alloc] init];
    [downImageview addSubview:payBtn];
    [payBtn setImage:[UIImage imageNamed:@"app_pay"] forState:UIControlStateNormal];
    payBtn.layer.cornerRadius = 6;
    payBtn.layer.masksToBounds = YES;
    [payBtn addTarget:self action:@selector(payAction:) forControlEvents:UIControlEventTouchUpInside];
    [payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(downImageview).offset(-10);
        make.centerY.equalTo(downImageview);
    }];
    
    return allBgView;
}

#pragma mark - 事件

- (void)payAction:(UIButton *)btn {
    CLog(@"--->>>套餐-立即支付");
    if (![[self getSelectedPackageList] count]) {
        [KTVToast toast:@"您还未选择套餐，请选择套餐"];
        return;
    }
    // 跳转到订单确认
    KTVOrderConfirmController *vc = (KTVOrderConfirmController *)[UIViewController storyboardName:@"MainPage" storyboardId:@"KTVOrderConfirmController"];
    vc.store = self.store;
    vc.packageList = [self getSelectedPackageList];
    vc.selectedActivitorList = self.selectedActivitorList;
    // 创建单点商品列表
    vc.shopCartList = self.shopCartList;
    // 创建订单的其他而外信息
    vc.orderInfo = self.orderInfo;
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 封装

- (void)setPackage:(KTVPackage *)package {
    _package = package;
    
    for (KTVPackage *pv in self.store.packageList) {
        if ([pv isEqual:_package]) {
            pv.isSelected = YES;
        }
    }
}

/// 获取当前选择套餐和暖场人的总价
- (NSString *)getOrderMoney {
    float price = 0;
    // 套餐价格
    for (KTVPackage *pk in [self getSelectedPackageList]) {
        price += pk.price.floatValue;
    }
    // 暖场人价格
    for (KTVUser *user in self.selectedActivitorList) {
        price += user.userDetail.price;
    }
    // 单点商品价格
    for (KTVShop *shop in self.shopCartList) {
        price += [shop.goodCount floatValue] * [shop.good.goodPrice floatValue];
    }
    return @(price).stringValue;
}

/// 获取已经选中的套餐
- (NSArray *)getSelectedPackageList {
    NSMutableArray *packageList = [NSMutableArray array];
    for (KTVPackage *pk in self.store.packageList) {
        if (pk.isSelected) {
            [packageList addObject:pk];
        }
    }
    return packageList;
}

/// 获取单点商品总价
- (float)getShoppingCartAllPrice {
    float allPrice = 0;
    if (self.shoppingCart) {
        for (NSString *goodId in self.shoppingCart.allKeys) {
            NSDictionary *shop = self.shoppingCart[goodId];
            allPrice += [shop[@"goodCount"] integerValue] * [((KTVGood *)shop[@"goodKey"]).goodPrice floatValue];
        }
    }
    return allPrice;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 225;
    } else if (indexPath.section == 1) {
        return 70;
    } else if (indexPath.section == 2) {
        return 50;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:@"app_order_ding" title:@"座位信息" remark:nil];
        return headerView;
    } else if (section == 2) {
        KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:nil title:@"套餐详情" remark:nil];
        return headerView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1 || section == 2) {
        return 28;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 2) {
        KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:@"app_order_dandian" title:@"进入单点 已点(0)" headerImgUrl:nil remarkUrl:@"app_arrow_right" remark:nil];
        @WeakObj(self);
        headerView.bgActionBlock = ^(KTVTableHeaderView *myView, KTVHeaderType headerType) {
            KTVDandianController *vc = (KTVDandianController *)[UIViewController storyboardName:@"MainPage" storyboardId:@"KTVDandianController"];
            vc.store = weakself.store;
            vc.shoppingCartDict = [self.shoppingCart mutableCopy];
            vc.shoppingCartCallBack = ^(NSMutableDictionary<NSString *,NSMutableDictionary<NSString *,id> *> *shoppingCart) {
                weakself.shoppingCart = shoppingCart;
                // 获取购物车中商品数目
                NSMutableArray<KTVShop *> *shopCartList = [NSMutableArray array];
                NSInteger count = 0;
                for (NSString *goodId in shoppingCart.allKeys) {
                    NSMutableDictionary *goodDic = [shoppingCart objectForKey:goodId];
                    // 获取商品数量
                    KTVShop *shop = [KTVShop yy_modelWithDictionary:goodDic];
                    count += [shop.goodCount integerValue];
                    [shopCartList addObject:shop];
                }
                weakself.shopCartList = [shopCartList copy];
                
                myView.title = [NSString stringWithFormat:@"进入单点 已点(%@)", @(count)];
                // 更新订单价格
                weakself.moneyLabel.text = [NSString stringWithFormat:@"¥%@", [self getOrderMoney]];
            };
            [weakself.navigationController pushViewController:vc animated:YES];
        };
        return headerView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 2) {
        return 28;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        // 套餐详情
        KTVPackageDetailController *vc = (KTVPackageDetailController *)[UIViewController storyboardName:@"MainPage" storyboardId:@"KTVPackageDetailController"];
        KTVPackage *package = self.store.packageList[indexPath.row];
        vc.package = package;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 1;
    } else if (section == 2) {
        return [self.store.packageList count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        KTVBarKtvDetailHeaderCell *cell = (KTVBarKtvDetailHeaderCell *)[tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVBarKtvDetailHeaderCell)];
        cell.store = self.store;
        cell.invitorList = self.invitatorList;
        
        @WeakObj(self);
        cell.callback = ^(KTVStore *store) {
            KTVFriendDetailController *vc = (KTVFriendDetailController *)[UIViewController storyboardName:@"MePage" storyboardId:KTVStringClass(KTVFriendDetailController)];
            vc.store = store;
            [weakself.navigationController pushViewController:vc animated:YES];
        };
        cell.purikuraCallBack = ^(KTVStore *store) {
            NSString *url = @"http://ww4.sinaimg.cn/large/a15bd3a5jw1f12r9ku6wjj20u00mhn22.jpg";
            NSMutableArray *urlItems = @[].mutableCopy;
            for (NSInteger i = 0; i < 10; i++) {
                KSPhotoItem *item = [KSPhotoItem itemWithSourceView:[UIImageView new] imageUrl:[NSURL URLWithString:url]];
                [urlItems addObject:item];
            }
            KSPhotoBrowser *browser = [KSPhotoBrowser browserWithPhotoItems:urlItems selectedIndex:indexPath.row];
            browser.delegate = weakself;
            browser.dismissalStyle = KSPhotoBrowserInteractiveDismissalStyleRotation;
            browser.backgroundStyle = KSPhotoBrowserBackgroundStyleBlur;
            browser.loadingStyle = KSPhotoBrowserImageLoadingStyleIndeterminate;
            browser.pageindicatorStyle = KSPhotoBrowserPageIndicatorStyleText;
            browser.bounces = NO;
            [browser showFromViewController:weakself];
        };
        return cell;
    } else if (indexPath.section == 1) {
        KTVIntroduceCell *cell = (KTVIntroduceCell *)[tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVIntroduceCell)];
        return cell;
    } else if (indexPath.section == 2) {
        KTVPackageDetailCell *cell = (KTVPackageDetailCell *)[tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVPackageDetailCell)];
        KTVPackage *package = self.store.packageList[indexPath.row];
        cell.package = package;
        @WeakObj(self);
        cell.selectCallback = ^(KTVPackage *package, BOOL isSelected) {
            weakself.moneyLabel.text = [NSString stringWithFormat:@"¥%@", [self getOrderMoney]];
        };
        return cell;
    }
    return nil;
}

// MARK: - KSPhotoBrowserDelegate

- (void)ks_photoBrowser:(KSPhotoBrowser *)browser didSelectItem:(KSPhotoItem *)item atIndex:(NSUInteger)index {
    NSLog(@"selected index: %ld", index);
}



@end
