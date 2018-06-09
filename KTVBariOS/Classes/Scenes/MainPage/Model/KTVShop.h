//
//  KTVShop.h
//  KTVBariOS
//
//  Created by pingjun lin on 2018/6/9.
//  Copyright © 2018年 Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KTVGood.h"

@interface KTVShop : NSObject

@property (nonatomic, copy) NSString *goodCount; // 商品数量
@property (nonatomic, strong) KTVGood *good; // 商品

@end
