//
//  KTVDandianController.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/27.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVBaseViewController.h"
#import "KTVStore.h"

@interface KTVDandianController : KTVBaseViewController

@property (nonatomic, strong) KTVStore *store;
// 已经单点的商品
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSMutableDictionary<NSString *, id> *> *shoppingCartDict; // 购物车中的商品
@property (nonatomic, copy) void (^shoppingCartCallBack)(NSMutableDictionary<NSString *, NSMutableDictionary<NSString *, id> *> *);

@end
