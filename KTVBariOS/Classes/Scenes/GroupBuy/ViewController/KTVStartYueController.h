//
//  KTVStartYueController.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/31.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVBaseViewController.h"
#import "KTVStore.h"

@interface KTVStartYueController : KTVBaseViewController
/// 查询条件-拼桌者电话号码
@property (nonatomic, strong) NSString *phone;

@property (nonatomic, strong) NSArray<KTVStore *> * storeList;

@end
