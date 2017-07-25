//
//  KTVLoginController.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/7/9.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVBaseViewController.h"
#import "KTVLoginBaseController.h"

typedef NS_ENUM(NSUInteger, KTVLoginType) {
    KTVLoginAccountType,
    KTVLoginMobileType,
};

@interface KTVLoginController : KTVLoginBaseController

@property (assign, nonatomic) KTVLoginType loginType;

@end
