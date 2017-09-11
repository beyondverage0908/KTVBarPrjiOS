//
//  KTVMainLogic.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/10.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ResponseSuccess)(NSDictionary *result);

@interface KTVMainLogic : NSObject

+ (void)parsingMainResult:(NSDictionary *)result result:(ResponseSuccess)responseResult;

@end
