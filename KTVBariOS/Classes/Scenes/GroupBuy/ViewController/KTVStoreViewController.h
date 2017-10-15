//
//  KTVStoreViewController.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/3.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVBaseViewController.h"

#import "KTVStore.h"

@interface KTVStoreViewController : KTVBaseViewController

@property (nonatomic, copy) void (^selectedStoreCallback)(KTVStore *store);

/// 查询条件
@property (nonatomic, strong) NSString *storeName;
@property (nonatomic, assign) NSInteger storeType;

@end
