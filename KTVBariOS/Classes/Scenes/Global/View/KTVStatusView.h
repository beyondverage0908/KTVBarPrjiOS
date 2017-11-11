//
//  KTVStatusView.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/11/11.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTVStatus.h"

@interface KTVStatusView : UIView

@property (nonatomic, copy) void (^selectedStatusCallback)(KTVStatus *selectedStatus);

- (instancetype)initWithStatusList:(NSArray<KTVStatus *> *)statusList;

@end
