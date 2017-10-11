//
//  KTVPackageController.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/14.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVBaseViewController.h"
#import "KTVStore.h"
#import "KTVPackage.h"

@interface KTVPackageController : KTVBaseViewController

@property (nonatomic, strong) KTVStore *store;
@property (nonatomic, strong) KTVPackage *package;

@end
