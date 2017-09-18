//
//  KTVSelectedBeautyController.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/30.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVBaseViewController.h"
#import "KTVStore.h"
#import "KTVGroupbuy.h"

@interface KTVSelectedBeautyController : KTVBaseViewController

@property (strong, nonatomic) KTVStore *store;
@property (strong, nonatomic) KTVGroupbuy *groupbuy;
@property (strong, nonatomic) NSMutableArray *selectedActivitorList; //已经选中的暖场人

@end
