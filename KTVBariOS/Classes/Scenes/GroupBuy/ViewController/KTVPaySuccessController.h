//
//  KTVPaySuccessController.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/31.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVBaseViewController.h"
#import "KTVStore.h"

@interface KTVPaySuccessController : KTVBaseViewController

@property (nonatomic, strong) KTVStore * store;
@property (nonatomic, strong) NSString *payedMoney;
@property (nonatomic, assign) NSInteger payType; // 支付方式
@property (nonatomic, assign) BOOL isHiddenActivity; // 是否隐藏本次活动

@end
