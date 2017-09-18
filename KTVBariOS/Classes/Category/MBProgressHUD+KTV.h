//
//  MBProgressHUD+KTV.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/16.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (KTV)

/// 没有描述，15秒后消失
+ (void)show;

/// 没有描述，delay秒后开始执行其他操作
+ (void)showDelay:(NSInteger)delay;

/// 描述错误信息，1.5秒消失
+ (void)showError:(NSString *)message;

/// 描述成功信息，1.5秒消失
+ (void)showSuccess:(NSString *)message;

/// 等待框，描述信息，15秒后消失
+ (void)showMessage:(NSString *)message;

/// 关闭弹框
+ (void)hiddenHUD;

@end
