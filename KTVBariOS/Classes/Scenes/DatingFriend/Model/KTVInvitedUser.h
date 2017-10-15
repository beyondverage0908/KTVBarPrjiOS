//
//  KTVInvitedUser.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/10/14.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KTVUser.h"

@interface KTVInvitedUser : NSObject

@property (nonatomic, strong) KTVUser * user;
@property (nonatomic, strong) NSString *distance;

@end
