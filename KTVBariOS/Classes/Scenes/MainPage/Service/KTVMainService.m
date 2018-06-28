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

+ (void)postShareTable:(NSDictionary *)params result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getCreatShareTableUrl];
    msg.httpType = KtvPOST;
    msg.params = params;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        // 数据接口解析
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

+ (void)postShareTableAddress:(NSDictionary *)params result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getShareTableAddressUrl];
    msg.httpType = KtvPOST;
    msg.params = params;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        // 数据接口解析
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

+ (void)getShareTableDetail:(NSString *)mobileNum result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getShareTableDetailUrl];
    msg.httpType = KtvGET;
    msg.params = mobileNum;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

+ (void)postStoreSearch:(NSDictionary *)params result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getStoreSearchUrl];
    msg.httpType = KtvPOST;
    msg.params = params;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        // 数据接口解析
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

+ (void)postSearchOrder:(NSDictionary *)params result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getSearchOrderUrl];
    msg.httpType = KtvPOST;
    msg.params = params;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        // 数据接口解析
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

+ (void)postCreateInvite:(NSDictionary *)params result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getCreateInviteUrl];
    msg.httpType = KtvPOST;
    msg.params = params;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        // 数据接口解析
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

+ (void)getSingleInvite:(NSString *)inviteId result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getSingleInviteUrl];
    msg.httpType = KtvGET;
    msg.params = inviteId;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        // 数据接口解析
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

+ (void)postNearInvite:(NSDictionary *)params result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getNearInviteUrl];
    msg.httpType = KtvPOST;
    msg.params = params;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        // 数据接口解析
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

/// 用户申请入驻
+ (void)postUserEnter:(NSDictionary *)params result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getUserEnterUrl];
    msg.httpType = KtvUpload;
    msg.params = params;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        // 数据接口解析
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

/// 同意用户入驻
+ (void)postAgreeUserEnter:(NSDictionary *)params result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getAgreeUserEnterUrl];
    msg.httpType = KtvPOST;
    msg.params = params;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        // 数据接口解析
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

/// 添加收藏
+ (void)postUserCollect:(NSDictionary *)params result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getUserCollectUrl];
    msg.httpType = KtvPOST;
    msg.params = params;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        // 数据接口解析
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

/// 获取收藏
+ (void)getUserCollect:(NSString *)mobile result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getAlreadyCollectUrl];
    msg.httpType = KtvGET;
    msg.params = mobile;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        // 数据接口解析
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

+ (void)postUserCollectCancel:(NSDictionary *)params result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getCancelCollectUrl];
    msg.httpType = KtvPOST;
    msg.params = params;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        // 数据接口解析
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

// 加入拼桌
+ (void)postShareTableEnroll:(NSDictionary *)params result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getShareTableEnrollUrl];
    msg.httpType = KtvPOST;
    msg.params = params;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        // 数据接口解析
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

+ (void)postSaveUserDetail:(NSDictionary *)params result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getSaveUserDetailUrl];
    msg.httpType = KtvPOST;
    msg.params = params;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        // 数据接口解析
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

+ (void)postUploadUserPicture:(NSDictionary *)params result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getUploadUserPictureUrl];
    msg.httpType = KtvUpload;
    msg.params = params;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        // 数据接口解析
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

+ (void)postUploadHeader:(NSDictionary *)params result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getUploadHeaderUrl];
    msg.httpType = KtvUpload;
    msg.params = params;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        // 数据接口解析
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

+ (void)postUploadHeaderBg:(NSDictionary *)params result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getUploadHeaderBgUrl];
    msg.httpType = KtvUpload;
    msg.params = params;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        // 数据接口解析
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

+ (void)postEditNickname:(NSDictionary *)params result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getEditNicknameUrl];
    msg.httpType = KtvPOST;
    msg.params = params;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        // 数据接口解析
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

+ (void)postUploadDynamic:(NSDictionary *)params result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getUserDynamicStatementUrl];
    msg.httpType = KtvUpload;
    msg.params = params;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        // 数据接口解析
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

+ (void)postLocalStore:(NSDictionary *)params result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getLocalOrderUrl];
    msg.httpType = KtvPOST;
    msg.params = params;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        // 数据接口解析
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

+ (void)postAppExit:(NSDictionary *)params result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getExitUrl];
    msg.httpType = KtvPOST;
    msg.params = params;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        // 数据接口解析
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

+ (void)postStoreLike:(NSDictionary *)params result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getStoreLikeUrl];
    msg.httpType = KtvPOST;
    msg.params = params;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        // 数据接口解析
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

+ (void)postStoreNearActivity:(NSDictionary *)params result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getStoreNearActivityUrl];
    msg.httpType = KtvPOST;
    msg.params = params;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        // 数据接口解析
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

+ (void)getMainBanner:(NSString *)params result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getMainBannerUrl];
    msg.httpType = KtvGET;
    msg.params = params;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        // 数据接口解析
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

+ (void)getAppVersion:(NSDictionary *)params result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getAppVersionUrl];
    msg.httpType = KtvGET;
    msg.params = params;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        // 数据接口解析
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

+ (void)getCommonNearUser:(NSDictionary *)params result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getCommonNearUserUrl];
    msg.httpType = KtvGET;
    msg.params = params;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        // 数据接口解析
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

+ (void)uploadVideo:(NSDictionary *)params result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getUploadVideoUrl];
    msg.httpType = KtvUploadStream;
    msg.params = params;
    msg.videoUrl = params[@"video"];
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        // 数据接口解析
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

/// 删除相册图片
+ (void)postDeleteUserPhoto:(NSDictionary *)params result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getDeletePictureUrl];
    msg.httpType = KtvPOST;
    msg.params = params;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        // 数据接口解析
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

/// 删除相册
+ (void)postDeleteUserVideo:(NSDictionary *)params result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getDeleteVideoUrl];
    msg.httpType = KtvPOST;
    msg.params = params;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        // 数据接口解析
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

+ (void)getRongCloudToken:(NSDictionary *)params result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getRongCloudTokenUrl];
    msg.httpType = KtvGET;
    msg.params = params;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        // 数据接口解析
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

/// 获取好友
+ (void)getMyFriend:(NSString *)phone result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getMyFriendUrl];
    msg.httpType = KtvGET;
    msg.params = phone;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        // 数据接口解析
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

/// 添加好友
+ (void)postAddFriend:(NSDictionary *)params result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getAddFriendUrl];
    msg.httpType = KtvPOST;
    msg.params = params;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        // 数据接口解析
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

+ (void)postRecentUserAddress:(NSDictionary *)params result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getRecentUserAddressUrl];
    msg.httpType = KtvPOST;
    msg.params = params;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        // 数据接口解析
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

/// 申请暖场人
+ (void)postApplyWarmer:(NSDictionary *)params result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getApplyWarmerUrl];
    msg.httpType = KtvHybridStream;
//    msg.domainUrl = @"http://humdeef.imwork.net";
    msg.params = params;
    msg.videoUrl = params[@"video"];
    msg.imageList = params[@"shz"];
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        // 数据接口解析
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

+ (void)postPayAfterWarmer:(NSDictionary *)params result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getPayAfterWarmerUrl];
    msg.httpType = KtvPOST;
    msg.params = params;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        // 数据接口解析
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

/// 修改暖场人兼职的时间
+ (void)postUpdateWarmerWorkTime:(NSDictionary *)params result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getUpdateWarmerTimeUrl];
    msg.httpType = KtvPOST;
    msg.params = params;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        // 数据接口解析
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

/// 附近的暖场人
+ (void)postNearWarmerUser:(NSDictionary *)params result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getNearWarmerUserUrl];
    msg.httpType = KtvPOST;
    msg.params = params;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        // 数据接口解析
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

/// 更新用户channelid
+ (void)postUpdateBPushChannel:(NSDictionary *)params result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getUpdateBPushChannelIdUrl];
    msg.httpType = KtvPOST;
    msg.params = params;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        // 数据接口解析
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

/// 获取兼职暖场人的订单
+ (void)postWarmerUserOrder:(NSDictionary *)params result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getWarmerUserOrderUrl];
    msg.httpType = KtvPOST;
    msg.params = params;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        // 数据接口解析
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

/// 设置兼职暖场人接受和拒绝
+ (void)postUpdateRejectRecordOrder:(NSDictionary *)params result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getUpdateRejectRecordOrderUrl];
    msg.httpType = KtvPOST;
    msg.params = params;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        // 数据接口解析
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

/// 查询兼职暖场人的拒绝和接受订单
+ (void)postQueryRejectRecordOrderUrl:(NSDictionary *)params result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getUpdateRejectRecordOrderUrl];
    msg.httpType = KtvPOST;
    msg.params = params;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        // 数据接口解析
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

/// 创建暖场人订单
+ (void)postCreateWarmerOrder:(NSDictionary *)params result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getCreateWarmerOrderUrl];
    msg.httpType = KtvPOST;
    msg.params = params;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        // 数据接口解析
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

/// 获取用户的余额
+ (void)getUserBalance:(NSString *)userId result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getUserBalanceUrl];
    msg.httpType = KtvGET;
    msg.params = userId;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        // 数据接口解析
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

/// 获取门店的评论
+ (void)postStoreComment:(NSDictionary *)params result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getCommentUrl];
    msg.httpType = KtvPOST;
    msg.params = params;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        // 数据接口解析
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

/// 添加门店评论
+ (void)postCreatStoreComment:(NSDictionary *)params result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getRecentStatusUrl];
    msg.httpType = KtvPOST;
    msg.params = params;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        // 数据接口解析
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

/// 获取门店活动
+ (void)getStoreActivity:(NSString *)storeId result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getStoreActivityUrl];
    msg.httpType = KtvGET;
    msg.params = storeId;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        // 数据接口解析
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

/// 取消订单
+ (void)postOrderCancel:(NSDictionary *)params result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getOrderCancelUrl];
    msg.httpType = KtvPOST;
    msg.params = params;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        // 数据接口解析
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

/// 查询指定订单
+ (void)getOrder:(NSString *)orderId result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getOrderUrl];
    msg.httpType = KtvGET;
    msg.params = orderId;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        // 数据接口解析
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

/// 创建暖场人评论
+ (void)postCreateActorComment:(NSDictionary *)commentDict result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getActorUserCreatUrl];
    msg.httpType = KtvPOST;
    msg.params = commentDict;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        // 数据接口解析
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

/// 获取暖场人评论
+ (void)postQueryActorComment:(NSDictionary *)queryDict result:(ResponseSuccess)responseResult {
    KTVRequestMessage *msg = [[KTVRequestMessage alloc] init];
    msg.path = [KTVUrl getActorUserQueryAllUrl];
    msg.httpType = KtvPOST;
    msg.params = queryDict;
    
    [[KTVNetworkHelper sharedInstance] send:msg success:^(NSDictionary *result) {
        // 数据接口解析
        responseResult(result);
    } fail:^(NSError *error) {
        CLog(@"--->>>%@", error);
    }];
}

@end

