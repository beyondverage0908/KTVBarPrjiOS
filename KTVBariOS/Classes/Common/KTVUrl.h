//
//  KTVUrl.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/1.
//  Copyright © 2017年 Lin. All rights reserved.
//

#ifndef KTVUrl_h
#define KTVUrl_h

//生产环境
#define BUILD_FOR_RELEASE 0

#if BUILD_FOR_RELEASE

static NSString * const KTV_BASE_URL        = @"https://vhealthplus.valurise.com/oauth2/";                      // 域名
static NSString * const MAIN_SHOP_URL       = @"https://vhealthplus.valurise.com/index.php";                    // 福利地址
static NSString * const ACTIVITY_MAIN_URL   = @"https://vhealthplus.valurise.com/client/activity/index.htm";    // 活动地址

#else

static NSString * const KTV_BASE_URL        = @"https://vtest.valurise.com/oauth2/";                        // 域名
static NSString * const MAIN_SHOP_URL       = @"https://vtest.valurise.com/index.php";                      // 福利地址
static NSString * const ACTIVITY_MAIN_URL   = @"https://vtest.valurise.com/client/activity/index.htm";      // 活动地址

//static NSString * const kServerURL          = @"http://172.17.21.173:8080/oauth2";
//static NSString *MAIN_SHOP_URL              = @"http://172.17.21.173:8080/index.php"; // 福利地址
//static NSString *ACTIVITY_MAIN_URL          = @"http://172.17.21.173:8080/client/activity/index.htm";  // 活动地址

#endif

#endif /* KTVUrl_h */
