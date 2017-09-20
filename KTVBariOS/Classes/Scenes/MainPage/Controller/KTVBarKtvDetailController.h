//
//  KTVBarKtvDetailController.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/12.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVBaseViewController.h"
#import "KTVStore.h"
#import "KTVPackage.h"

@interface KTVBarKtvDetailController : KTVBaseViewController

@property (nonatomic, strong) KTVStore *store;
@property (nonatomic, strong) KTVPackage *package;

@end
