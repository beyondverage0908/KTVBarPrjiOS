//
//  KTVLoginService.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/20.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVLoginService.h"

@implementation KTVLoginService

+ (void)getIdentifyingCodeParams:(NSDictionary *)params result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.params = params;
    msg.httpType = KtvPOST;
    msg.path = [KTVUrl getIdentifyingCodeUrl];
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        responseResult(result);
    } fail:^(NSError *error) {}];
}

+ (void)getCommonLoginParams:(NSDictionary *)params result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getCommonLoginUrl];
    msg.httpType = KtvPOST;
    msg.params = params;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

@end
