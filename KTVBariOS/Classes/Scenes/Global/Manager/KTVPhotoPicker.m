//
//  KTVPhotoPicker.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/30.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVPhotoPicker.h"

@implementation KTVPhotoPicker

+ (void)pickPhoto {
    UIViewController *rootNav = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        CLog(@"-->> 拍照")
    }];
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        CLog(@"-->> 相册")
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        CLog(@"-->> 取消")
    }];
    
    [alertController addAction:takePhotoAction];
    [alertController addAction:photoAction];
    [alertController addAction:cancelAction];
    
    [rootNav presentViewController:alertController animated:YES completion:nil];
}

@end
