//
//  KTVNearUser.h
//  KTVBariOS
//
//  Created by pingjun lin on 2018/2/13.
//  Copyright © 2018年 Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "KTVUser.h"

@interface KTVNearUser : NSObject

@property (nonatomic, strong) NSString * storeId;
@property (nonatomic, strong) NSString * distance;
@property (nonatomic, strong) KTVUser * userModel;

@end
