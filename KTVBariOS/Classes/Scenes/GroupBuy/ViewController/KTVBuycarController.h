//
//  KTVBuycarController.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/27.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVBaseViewController.h"

@interface KTVBuycarController : KTVBaseViewController

@property (nonatomic, strong) NSMutableDictionary<NSString *, NSMutableDictionary<NSString *, id> *> *shoppingCartDict; // 购物车中的商品

@end
