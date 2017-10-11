//
//  KTVPhotoPicker.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/30.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVPhotoPicker.h"
#import <Photos/Photos.h>

@interface KTVPhotoPicker ()<UINavigationBarDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation KTVPhotoPicker

- (instancetype)init {
    self = [super init];
    if (self) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            switch (status) {
                case PHAuthorizationStatusAuthorized:
                    NSLog(@"PHAuthorizationStatusAuthorized");
                    break;
                case PHAuthorizationStatusDenied:
                    NSLog(@"PHAuthorizationStatusDenied");
                    break;
                case PHAuthorizationStatusNotDetermined:
                    NSLog(@"PHAuthorizationStatusNotDetermined");
                    break;
                case PHAuthorizationStatusRestricted:
                    NSLog(@"PHAuthorizationStatusRestricted");
                    break;
            }
        }];
    }
    return self;
}

- (void)startPickPhoto {
    
    UIViewController *rootNav = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        CLog(@"-->> 拍照");
        [self takePhotoClick];
    }];
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        CLog(@"-->> 相册")
        [self choosePhotoClick];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        CLog(@"-->> 取消")
    }];
    
    [alertController addAction:takePhotoAction];
    [alertController addAction:photoAction];
    [alertController addAction:cancelAction];
    
    [rootNav presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - 事件

// 拍照处理
- (void)takePhotoClick {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController *imagepicker = [[UIImagePickerController alloc] init];
        imagepicker.delegate = self;
        imagepicker.allowsEditing = YES;
        imagepicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [UIApplication.sharedApplication.keyWindow.rootViewController presentViewController:imagepicker animated:YES completion:^{}];
    }
}

// 相册中选择图片
- (void)choosePhotoClick {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [UIApplication.sharedApplication.keyWindow.rootViewController presentViewController:picker animated:YES completion:^{}];
    }
}

#pragma mark - 图片处理

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    CLog(@"--->>> 相册回调");
    [picker dismissViewControllerAnimated:YES completion:^{
        // 设置照片按钮信息
        UIImage *image = [KTVUtil scaleImage:[KTVUtil clipImage:info[UIImagePickerControllerOriginalImage] toRect:CGSizeMake(62, 62)] toSize:CGSizeMake(62, 62)];
    }];
}

@end
