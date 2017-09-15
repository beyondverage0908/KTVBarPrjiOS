//
//  KTVSelectedBeautyController.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/30.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVBaseViewController.h"

@interface KTVSelectedBeautyController : KTVBaseViewController

// 接受提交订单参数
@property (nonatomic, strong) NSMutableDictionary *orderUploadDictionary;

@property (strong, nonatomic) NSMutableArray *selectedActivitorList;

@end
