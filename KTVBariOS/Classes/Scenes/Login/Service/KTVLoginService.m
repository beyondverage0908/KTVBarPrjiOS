//
//  KTVLoginService.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/20.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVLoginService.h"

@implementation KTVLoginService

+ (void)getUserInfo:(NSString *)userId result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.params = userId;
    msg.httpType = KtvGET;
    msg.path = [KTVUrl getUserInfoUrl];
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        responseResult(result);
    } fail:^(NSError *error) {}];
}

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

+ (void)postPhoneLoginParams:(NSDictionary *)params result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getPhoneLoginUrl];
    msg.httpType = KtvPOST;
    msg.params = params;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

+ (void)postCheckIndentifyCodeParams:(NSDictionary *)params result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getCheckIndentifyCodeUrl];
    msg.httpType = KtvPOST;
    msg.params = params;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

+ (void)postRegisterParams:(NSDictionary *)params result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getRegisterUrl];
    msg.httpType = KtvPOST;
    msg.params = params;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

+ (void)postRegisterDetaliParams:(NSDictionary *)params result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getRegisterDetailUrl];
    msg.httpType = KtvPOST;
    msg.params = params;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

+ (void)postWechatLoginParams:(NSDictionary *)params result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getWeChatLoginUrl];
    msg.httpType = KtvPOST;
    msg.params = params;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

+ (void)postQQLoginParams:(NSDictionary *)params result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getQQLoginUrl];
    msg.httpType = KtvPOST;
    msg.params = params;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

+ (void)postChangePassword:(NSDictionary *)params result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getChangePasswordUrl];
    msg.httpType = KtvPOST;
    msg.params = params;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

+ (void)postUpdateThird:(NSDictionary *)params result:(ResponseSuccess)responseResult {
    
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getUpdateThirdLoginUserUrl];
    msg.httpType = KtvPOST;
    msg.params = params;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
    
}

@end
