//
//  KTVPayManager.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/5.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVPayManager.h"

@implementation KTVPayManager

static NSString * const alipayUrlScheme = @"ktvalipayurlschemes";
// URLScheme -- 必须是在微信官方平台注册后以wx开头的字符串 - 这里是随机定义的，不能作数
static NSString * const wechatUrlScheme = @"wxktvpayurlsechemes";
static NSString * const unionUrlScheme = @"ktvunionpaytype";

+ (void)ktvPay:(KTVPayType)payType
       payment:(NSObject *)charge
     contoller:(UIViewController *)controller
    completion:(void (^)(NSString *result))completion {
    switch (payType) {
        case AlipayType:
        {
            [Pingpp createPayment:charge appURLScheme:alipayUrlScheme withCompletion:^(NSString *result, PingppError *error) {
                if ([result isEqualToString:@"success"]) {
                    // 支付成功
                    if (completion) {
                        completion(result);
                    }
                } else {
                    // 支付失败或取消
                    NSLog(@"Error: code=%lu msg=%@", error.code, [error getMsg]);
                }
            }];
        }
            break;
        case WeChatType:
        {
            // URLScheme -- 必须是在微信官方平台注册后以wx开头的字符串 -- shareSDK同理
            [Pingpp createPayment:charge appURLScheme:wechatUrlScheme withCompletion:^(NSString *result, PingppError *error) {
                if ([result isEqualToString:@"success"]) {
                    // 支付成功
                    if (completion) {
                        completion(result);
                    }
                } else {
                    // 支付失败或取消
                    NSLog(@"Error: code=%lu msg=%@", error.code, [error getMsg]);
                }
            }];
        }
            break;
        case UnionPayType:
        {
            [Pingpp createPayment:charge
                   viewController:controller
                     appURLScheme:unionUrlScheme
                   withCompletion:^(NSString *result, PingppError *error) {
                       if ([result isEqualToString:@"success"]) {
                           // 支付成功
                           if (completion) {
                               completion(result);
                           }
                       } else {
                           // 支付失败或取消
                           NSLog(@"Error: code=%lu msg=%@", error.code, [error getMsg]);
                       }
                   }];
        }
            break;
        default:
            break;
    }
}

@end
