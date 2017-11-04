//
//  KTVRequestMessage.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/1.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVRequestMessage.h"

@implementation KTVRequestMessage

- (void)setParams:(id)params {
    if ([params isKindOfClass:[NSString class]]) {
        _params = params;
    } else if ([params isKindOfClass:[NSMutableString class]]) {
        _params = [params copy];
    } else if ([params isKindOfClass:[NSDictionary class]] || [params isKindOfClass:[NSMutableDictionary class]]) {
        NSDictionary *pa = (NSDictionary *)params;
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        NSMutableDictionary *imageMap = [NSMutableDictionary dictionary];
        for (NSString *key in pa.allKeys) {
            if ([pa[key] isKindOfClass:[UIImage class]]) {
                imageMap[key] = pa[key];
            } else {
                dic[key] = pa[key];
            }
            if ([key isEqualToString:@"file"] && [pa[@"file"] isKindOfClass:[NSArray class]]) {
                _imageList = pa[@"file"];
            }
        }
        _params = dic;
        _imageMap = imageMap;
    } else {
        _params = params;
    }
}

@end
