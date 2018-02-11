//
//  ApplyWarmerView.h
//  KTVBariOS
//
//  Created by pingjun lin on 2018/1/27.
//  Copyright © 2018年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApplyWarmerView : UIView

@property (nonatomic, copy) void (^uploadIDCallback)(BOOL isTop);
@property (nonatomic, copy) void (^uploadVedioCallback)(void);

- (NSDictionary *)obtainWarmerInfo;
// 设置用户的信息
- (void)setUserIdentifier:(NSDictionary *)info;

@end
