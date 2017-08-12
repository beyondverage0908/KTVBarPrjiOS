//
//  KTVUtil.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/1.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KTVUtil : NSObject

+ (BOOL)isNetworkAvailable;

+ (BOOL)isNullString:(NSString *)string;

+ (void)setObject:(id)obj forKey:(NSString *)key;

+ (id)objectForKey:(NSString *)key;

@end
