//
//  KTVMainService.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/6.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVMainService.h"
#import "KTVMainLogic.h"

@implementation KTVMainService

+ (void)postMainPage:(NSDictionary *)params result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getMainUrl];
    msg.httpType = KtvPOST;
    msg.params = params;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        // 数据接口解析
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

+ (void)getStoreActivitors:(NSString *)storeId result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getAtivitorsUrl];
    msg.httpType = KtvGET;
    msg.params = storeId;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

+ (void)getStorePageActivitors:(NSDictionary *)params result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getAtivitorsByPageUrl];
    msg.httpType = KtvGET;
    msg.params = params;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

+ (void)getStoreGoods:(NSString *)storeId result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getStoreGoodsUrl];
    msg.httpType = KtvGET;
    msg.params = storeId;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

+ (void)getStore:(NSString *)storeId result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getStoreUrl];
    msg.httpType = KtvGET;
    msg.params = storeId;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

+ (void)getStoreInvitators:(NSString *)storeId result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getStoreInvitatorsUrl];
    msg.httpType = KtvGET;
    msg.params = storeId;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

@end
