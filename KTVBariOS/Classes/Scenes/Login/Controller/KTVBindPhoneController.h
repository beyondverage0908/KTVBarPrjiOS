//
//  KTVBindPhoneController.h
//  KTVBariOS
//
//  Created by pingjun lin on 2018/5/12.
//  Copyright © 2018年 Lin. All rights reserved.
//

#import "KTVBaseViewController.h"

@interface KTVBindPhoneController : KTVBaseViewController

@property (nonatomic, assign) NSInteger type; // 1: 微信 2: qq
@property (nonatomic, copy) NSString * uid; // 微信或者qq返回的uid
@property (nonatomic, copy) NSString * gender;

@end
