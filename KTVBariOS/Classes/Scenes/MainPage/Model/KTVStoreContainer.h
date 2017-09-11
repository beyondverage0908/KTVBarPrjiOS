//
//  KTVStoreContainer.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/10.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "KTVStore.h"
#import "KTVUser.h"

@interface KTVStoreContainer : NSObject

@property (nonatomic, assign) NSInteger distance;
@property (nonatomic, strong) NSArray<KTVUser *> * userList;
@property (nonatomic, assign) NSInteger storeType;
@property (nonatomic, assign) NSInteger star;

@property (nonatomic, strong) KTVStore * store;

@end
