//
//  IHAlertController.m
//  nurse
//
//  Created by linsir on 16/3/4.
//  Copyright © 2016年 vhs. All rights reserved.
//

#import "KTVAlertController.h"

@interface KTVAlertController ()

@property (nonatomic, strong)UIWindow *alertWindow;

@end

@implementation KTVAlertController

+ (void)alertMessage:(NSString *)message
               title:(NSString *)title
      confirmHandler:(void (^)(UIAlertAction *action))confirmHandler {
    [KTVAlertController alertMessageText:message title:title confirmHandler:confirmHandler cancleHandler:nil];
}

+ (void)alertMessage:(NSString *)message
               title:(NSString *)title
      confirmHandler:(void (^)(UIAlertAction *action))confirmHandler
       cancleHandler:(void (^)(UIAlertAction *action))cancleHandler {
    [KTVAlertController alertMessageText:message title:title confirmHandler:confirmHandler cancleHandler:cancleHandler];
}

+ (void)alertMessage:(NSString *)message
      confirmHandler:(void (^)(UIAlertAction *action))confirmHandler
       cancleHandler:(void (^)(UIAlertAction *action))cancleHandler {
    [KTVAlertController alertMessageText:message title:@"提示" confirmHandler:confirmHandler cancleHandler:cancleHandler];
}

+ (void)alertMessage:(NSString *)message
      confirmHandler:(void (^)(UIAlertAction *action))confirmHandler {
    [KTVAlertController alertMessageText:message title:@"提示" confirmHandler:confirmHandler cancleHandler:nil];
}

+ (void)alertMessageText:(NSString *)_showText
                   title:(NSString *)title
          confirmHandler:(void (^)(UIAlertAction *action))confirmHandler
           cancleHandler:(void (^)(UIAlertAction *action))cancleHandler {
    
    KTVAlertController *alertController = [KTVAlertController alertControllerWithTitle:title message:_showText preferredStyle:UIAlertControllerStyleAlert];
    
    if (confirmHandler) {
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:confirmHandler];
        [alertController addAction:confirmAction];
    }
    if (cancleHandler) {
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:cancleHandler];
        [alertController addAction:cancleAction];
    }
    
    [alertController showAnimated];
}

#pragma mark - origin program

- (void)show {
    [self showAnimated:NO];
}

- (void)showAnimated {
    [self showAnimated:YES];
}

- (void)showAnimated:(BOOL)animated {
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [window setBackgroundColor:[UIColor clearColor]];
    
    UIViewController *rootControllerView = [[UIViewController alloc] init];
    [rootControllerView.view setBackgroundColor:[UIColor clearColor]];
    
    [window setWindowLevel:UIWindowLevelAlert + 1];
    [window makeKeyAndVisible];
    [self setAlertWindow:window];
    
    [window setRootViewController:rootControllerView];
    [rootControllerView presentViewController:self animated:YES completion:nil];
}


@end
