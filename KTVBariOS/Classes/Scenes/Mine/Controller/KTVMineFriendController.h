//
//  KTVMineFriendController.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/7.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVBaseViewController.h"
#import "KTVUser.h"
#import <RongIMKit/RongIMKit.h>

@interface KTVMineFriendController : KTVBaseViewController

@property (nonatomic, strong) NSMutableArray<KTVUser *> *userList;

@end
