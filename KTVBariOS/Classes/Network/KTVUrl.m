//
//  KTVUrl.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/20.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVUrl.h"

@implementation KTVUrl

+ (NSString *)getDomainUrl {
    return @"http://119.23.148.104";
}

#pragma mark - 用户

+ (NSString *)getUserInfoUrl {
    return @"/api/login/user/";
}

+ (NSString *)getSaveUserDetailUrl {
    return @"/api/login/saveUserDetail";
}

#pragma mark - 登陆

+ (NSString *)getIdentifyingCodeUrl {
    return @"/api/login/user/getIdentifyingCode";
}

+ (NSString *)getCheckIndentifyCodeUrl {
    return @"/api/login/user/checkIdentifyingCode";
}

+ (NSString *)getCommonLoginUrl {
    return @"/api/login/user/commonLogin";
}

+ (NSString *)getPhoneLoginUrl {
    return @"/api/login/user/phoneLogin";
}

+ (NSString *)getQQLoginUrl {
    return @"/api/login/user/qq/login";
}

+ (NSString *)getWeChatLoginUrl {
    return @"/api/login/user/wx/login";
}

+ (NSString *)getRegisterUrl {
    return @"/api/login/user/register";
}

+ (NSString *)getRegisterDetailUrl {
    return @"/api/login/user/registerDetail";
}

+ (NSString *)getChangePasswordUrl {
    return @"/api/password/user/changePassword";
}

+ (NSString *)getLocationRecentStatusUrl {
    return @"/api/login/user/recentStatus";
}

+ (NSString *)getPingPayUrl {
    return @"/api/pay";
}

+ (NSString *)getRefundUrl {
    return @"/api/refund";
}

+ (NSString *)getMainUrl {
    return @"/api/main/data";
}

+ (NSString *)getAtivitorsUrl {
    return @"/api/store/activitors/";
}

+ (NSString *)getAtivitorsByPageUrl {
    return @"/api/store/activitors";
}

+ (NSString *)getStoreGoodsUrl {
    return @"/api/store/goods/";
}

+ (NSString *)getStoreUrl {
    return @"/api/store/";
}

+ (NSString *)getStoreInvitatorsUrl {
    return @"/api/store/invitators/";
}

+ (NSString *)getStoreNearActivityUrl {
    return @"/api/nearActivity";
}

+ (NSString *)getGroupBuyUrl {
    return @"/api/groupBuy/";
}

+ (NSString *)getCreateOrderUrl {
    return @"/api/order/createOrder";
}

+ (NSString *)getOrderUrl {
    return @"/api/order/";
}

+ (NSString *)getOrderUpdateStatusUrl {
    return @"/api/store/updateStatus";
}

+ (NSString *)getSearchOrderUrl {
    return @"/api/order/searchOrder";
}

+ (NSString *)getRecentStatusUrl {
    return @"/api/user/recentStatus";
}

+ (NSString *)getCommentUrl {
    return @"/api/store/comment";
}

#pragma mark - 拼桌

+ (NSString *)getCreatShareTableUrl {
    return @"/api/shareTable";
}

+ (NSString *)getShareTableAddressUrl {
    return @"/api/shareTable/address";
}

+ (NSString *)getShareTableDetailUrl {
    return @"/api/shareTable/";
}

+ (NSString *)getShareTableEnrollUrl {
    return @"/api/shareTable/enroll";
}

+ (NSString *)getStoreSearchUrl {
    return @"/api/store/search";
}

/// 创建邀约
+ (NSString *)getCreateInviteUrl {
    return @"/api/userInvite";
}

/// 获取单个邀约
+ (NSString *)getSingleInviteUrl {
    return @"/api/userInvite/";
}

/// 邀约大厅数据
+ (NSString *)getNearInviteUrl {
    return @"/api/userInvite/near";
}

#pragma mark - 用户入驻

/// 用户申请入驻
+ (NSString *)getUserEnterUrl {
    return @"/api/userEnter";
}

/// 同意用户入驻
+ (NSString *)getAgreeUserEnterUrl {
    return @"/api/agreeUserEnter";
}

#pragma mark - 收藏

/// 添加收藏
+ (NSString *)getUserCollectUrl {
    return @"/api/userCollect";
}

/// 获取收藏
+ (NSString *)getAlreadyCollectUrl {
    return @"/api/userCollect/";
}

@end
