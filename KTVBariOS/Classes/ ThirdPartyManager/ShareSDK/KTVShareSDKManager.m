//
//  KTVShareSDKManager.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/7/25.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVShareSDKManager.h"

NSString * const WeChatAppId        = @"wx4a1101d07f5b4ba6";
NSString * const WeChatAppSecret    = @"6ffad55052af669a51415f5fcfab8597";

NSString * const QQAppId            = @"1106185387";
NSString * const QQAppKey           = @"aeMOppOmRFRBt99U";


@implementation KTVShareSDKManager

+ (void)shareSDKInitial {
    [ShareSDK registerActivePlatforms:@[
                                        @(SSDKPlatformTypeSinaWeibo),
                                        @(SSDKPlatformTypeWechat),
                                        @(SSDKPlatformTypeQQ)
                                        ]
                             onImport:^(SSDKPlatformType platformType) {
                                 switch (platformType)
                                 {
                                     case SSDKPlatformTypeWechat:
                                         [ShareSDKConnector connectWeChat:[WXApi class]];
                                         break;
                                     case SSDKPlatformTypeQQ:
                                         [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                                         break;
                                     case SSDKPlatformTypeSinaWeibo:
                                         [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                                         break;
                                     default:
                                         break;
                                 }
                             }
                      onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
                                 switch (platformType)
                                 {
                                     case SSDKPlatformTypeSinaWeibo:
                                         //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                                         [appInfo SSDKSetupSinaWeiboByAppKey:@"568898243"
                                                                   appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                                                                 redirectUri:@"http://www.sharesdk.cn"
                                                                    authType:SSDKAuthTypeBoth];
                                         break;
                                     case SSDKPlatformTypeWechat:
                                         [appInfo SSDKSetupWeChatByAppId:WeChatAppId appSecret:WeChatAppSecret];
                                         break;
                                     case SSDKPlatformTypeQQ:
                                         [appInfo SSDKSetupQQByAppId:QQAppId appKey:QQAppKey authType:SSDKAuthTypeSSO];
                                         break;
                                     default:
                                         break;
                                 }
                             }];
}

+ (void)thirdpartyLogin:(KTVShareSDKType)loginType completeHandler:(void (^)(SSDKUser *rawData))completeHandler {
    switch (loginType) {
        case KTVShareSDKQQLoginType:
        {
            [ShareSDK getUserInfo:SSDKPlatformTypeQQ onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
                if (state == SSDKResponseStateSuccess) {
                    NSLog(@"uid=%@",user.uid);
                    NSLog(@"%@",user.credential);
                    NSLog(@"token=%@",user.credential.token);
                    NSLog(@"nickname=%@",user.nickname);
                    completeHandler(user);
                } else {
                    NSLog(@"%@",error);
                    completeHandler(user);
                }
            }];
        }
            break;
        case KTVShareSDKWeChatLoginType:
        {
            __block SSDKUser *sduser = nil;
            [SSEThirdPartyLoginHelper loginByPlatform:SSDKPlatformTypeWechat onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
                //在此回调中可以将社交平台用户信息与自身用户系统进行绑定，最后使用一个唯一用户标识来关联此用户信息。
                //在此示例中没有跟用户系统关联，则使用一个社交用户对应一个系统用户的方式。将社交用户的uid作为关联ID传入associateHandler。
                sduser = user;
                associateHandler(user.uid, user, user);
                NSLog(@"dd%@",user.rawData);
                NSLog(@"dd%@",user.credential);
            } onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {
                if (state == SSDKResponseStateSuccess) {
                    if (user) {
                        completeHandler(sduser);
                    } else {
                        completeHandler(nil);
                    }
                }
            }];
        }
            break;
        case KTVShareSDKSinaType:
            
            break;
        default:
            break;
    }
}
    
+(void)thirdpartyShareTitle:(NSString *)title text:(NSString *)text images:(NSArray *)images targetUrl:(NSURL *)url {

    //1、创建分享参数
    if (images) {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:text
                                         images:images
                                            url:url
                                          title:title
                                           type:SSDKContentTypeAuto];
        //有的平台要客户端分享需要加此方法，例如微博
        [shareParams SSDKEnableUseClientShare];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               [KTVToast toast:@"分享成功"];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               [KTVToast toast:@"分享失败"];
                               break;
                           }
                           default:
                           break;
                       }
                   }
         ];}
}

@end
