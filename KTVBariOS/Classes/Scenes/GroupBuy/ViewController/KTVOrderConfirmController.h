//
//  KTVOrderConfirmController.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/29.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVBaseViewController.h"
#import "KTVStore.h"
#import "KTVPackage.h"
#import "KTVShop.h"

@interface KTVOrderConfirmController : KTVBaseViewController

@property (nonatomic, strong) KTVStore * store;
@property (nonatomic, strong) NSArray<KTVPackage *> *packageList; // 已经选中的额套餐列表，支持选择多个套餐
@property (nonatomic, strong) NSMutableArray<KTVUser *> *selectedActivitorList;
@property (nonatomic, strong) NSArray<KTVShop *> *shopCartList; // 单点商品列表


@end
