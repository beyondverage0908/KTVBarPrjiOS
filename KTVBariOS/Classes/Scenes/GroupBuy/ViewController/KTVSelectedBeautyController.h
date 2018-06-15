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

typedef NS_ENUM(NSInteger, WarmerType) {
    MultipleWarmerType,
    SingleWarmerType
};

@interface KTVSelectedBeautyController : KTVBaseViewController

@property (nonatomic, assign) WarmerType warmerType; // 表示暖场人的类型
@property (nonatomic, strong) NSArray *singleWarmerList;
@property (nonatomic, assign) NSInteger singleType;
@property (strong, nonatomic) KTVStore *store;
@property (strong, nonatomic) KTVGroupbuy *groupbuy;
@property (strong, nonatomic) NSMutableArray *selectedActivitorList; //已经选中的暖场人
@property (nonatomic, copy) void (^selectedWarmerCallback)(NSArray *selActivitorList);

@end
