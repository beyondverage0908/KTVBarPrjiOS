//
//  KTVOrderInfo.h
//  KTVBariOS
//
//  Created by pingjun lin on 2018/6/16.
//  Copyright © 2018年 Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KTVOrderInfo : NSObject

@property (nonatomic, assign) NSInteger timeSplit; // 时间间隔，距离当前时间多少天 0：当天 1:明天 2:后天
@property (nonatomic, strong) NSString *orderStartTime;
@property (nonatomic, strong) NSString *siteInfo;

@end
