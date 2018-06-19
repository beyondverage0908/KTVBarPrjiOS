//
//  KTVOrderUploadController.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/30.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVBaseViewController.h"
#import "KTVStore.h"
#import "KTVGroupbuy.h"
#import "KTVPackage.h"
#import "KTVShop.h"
#import "KTVOrderInfo.h"

@interface KTVOrderUploadController : KTVBaseViewController

@property (nonatomic, strong) KTVStore *store;
@property (nonatomic, strong) KTVGroupbuy *groupbuy;
@property (nonatomic, strong) NSArray<KTVPackage *> *packageList;
@property (nonatomic, strong) NSArray *selectedActivitorList;
@property (nonatomic, copy) NSArray<KTVShop *> *shopCartList;
@property (nonatomic, strong) KTVOrderInfo *orderInfo;

@end
