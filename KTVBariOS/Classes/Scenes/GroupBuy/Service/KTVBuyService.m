//
//  KTVBuyService.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/6.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVBuyService.h"

@implementation KTVBuyService

+ (void)postPayParams:(NSDictionary *)params result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.params = params;
    msg.httpType = KtvPOST;
    msg.path = [KTVUrl getPingPayUrl];
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"%@", error);
    }];
}

+ (void)postCreateOrder:(NSDictionary *)params result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.params = params;
    msg.httpType = KtvPOST;
    msg.path = [KTVUrl getCreateOrderUrl];
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"%@", error);
    }];
}

@end
