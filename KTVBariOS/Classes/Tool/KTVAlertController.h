//
//  IHAlertController.h
//  nurse
//
//  Created by linsir on 16/3/4.
//  Copyright © 2016年 vhs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KTVAlertController : UIAlertController

/**
 *  alertViewController with message and title and confirm handler
 *
 *  @param message        message
 *  @param title          title
 *  @param confirmHandler confirm handler
 */
+ (void)alertMessage:(NSString *)message title:(NSString *)title confirmHandler:(void (^)(UIAlertAction *action))confirmHandler;

/**
 *  alertViewController with message and title and confirm handler and cancle handler
 *
 *  @param message        message
 *  @param title          title
 *  @param confirmHandler confirm handler
 *  @param cancleHandler  cancle handler
 */
+ (void)alertMessage:(NSString *)message title:(NSString *)title confirmHandler:(void (^)(UIAlertAction *action))confirmHandler cancleHandler:(void (^)(UIAlertAction *action))cancleHandler;

/**
 *  alertViewController with message and confirmHandler and cancleHandler default title with "提示"
 *
 *  @param message        message
 *  @param confirmHandler confirmHandler
 *  @param cancleHandler  cancleHandler
 */
+ (void)alertMessage:(NSString *)message confirmHandler:(void (^)(UIAlertAction *action))confirmHandler cancleHandler:(void (^)(UIAlertAction *action))cancleHandler;

/**
 *  alertViewController with message and confirmHandler default title with "提示"
 *
 *  @param message        message
 *  @param confirmHandler confirmHandler
 */
+ (void)alertMessage:(NSString *)message confirmHandler:(void (^)(UIAlertAction *action))confirmHandler;

@end
