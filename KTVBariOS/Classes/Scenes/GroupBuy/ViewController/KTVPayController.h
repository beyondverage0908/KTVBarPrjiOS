//
//  KTVPayController.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/31.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVBaseViewController.h"
#import "KTVStore.h"

@interface KTVPayController : KTVBaseViewController

@property (nonatomic, strong) NSMutableDictionary *orderUploadDictionary;
@property (nonatomic, strong) KTVStore *store;

@end
