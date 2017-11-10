//
//  KTVDynamicController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/10/25.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVDynamicController.h"
#import "UIImage+extension.h"
#import "KTVMainService.h"

@interface KTVDynamicController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextView *contentTv;
@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondBtn;
@property (weak, nonatomic) IBOutlet UIButton *thirdBtn;

@property (assign, nonatomic) NSInteger tapNumber;

@property (strong, nonatomic) NSMutableDictionary *params;
@property (strong, nonatomic) NSMutableArray *photoList;

@end

@implementation KTVDynamicController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"发布动态";
    
    [self addlayerWithBtn:self.firstBtn];
    [self addlayerWithBtn:self.secondBtn];
    [self addlayerWithBtn:self.thirdBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)addlayerWithBtn:(UIButton *)btn {
    btn.layer.borderColor = [UIColor whiteColor].CGColor;
    btn.layer.borderWidth = 1.0;
    btn.layer.cornerRadius = 5;
}

- (void)rebuildLayerWithBtn:(UIButton *)btn {
    btn.layer.borderColor = [UIColor clearColor].CGColor;
    btn.layer.borderWidth = 0;
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
}

- (NSMutableDictionary *)params {
    if (!_params) {
        _params = [NSMutableDictionary dictionary];
    }
    return _params;
}

- (NSMutableArray *)photoList {
    if (!_photoList) {
        _photoList = [NSMutableArray arrayWithCapacity:3];
    }
    return _photoList;
}

#pragma mark - 网络

- (void)uploadDynamic {
    NSString *content = self.contentTv.text;
    if (content && content.length) {
        [self.params setObject:content forKey:@"content"];
    }
    if (self.photoList.count) {
        [self.params setObject:self.photoList forKey:@"file"];
    }
    [self.params setObject:[KTVCommon userInfo].phone forKey:@"username"];

    [MBProgressHUD showMessage:@"正在发布中..."];
    [KTVMainService postUploadDynamic:self.params result:^(NSDictionary *result) {
        [MBProgressHUD hiddenHUD];
        if (![result[@"code"] isEqualToString:ktvCode]) {
            [KTVToast toast:TOAST_DYNAMIC_UPLOAD_FAIL];
            return;
        }
        [KTVToast toast:TOAST_DYNAMIC_UPLOAD_SUCC];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

#pragma mark - 事件

- (IBAction)publishDynamicAction:(UIButton *)sender {
    CLog(@"-->> 发布动态");
    [self uploadDynamic];
}

- (IBAction)firstDynamicAction:(UIButton *)sender {
    self.tapNumber = 1;
    [self showAlterSheet];
}

- (IBAction)secondDynamicAction:(UIButton *)sender {
    self.tapNumber = 2;
    [self showAlterSheet];
}

- (IBAction)thirdDynamicAction:(UIButton *)sender {
    self.tapNumber = 3;
    [self showAlterSheet];
}

#pragma mark - 显示AlertSheet

- (void)showAlterSheet {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self takePhotoAction];
    }];
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self choosePhotoLibAction];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}];
    [alertController addAction:takePhotoAction];
    [alertController addAction:photoAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - 相机相册相关

// 拍照处理
- (void)takePhotoAction {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController *imagepicker = [[UIImagePickerController alloc] init];
        imagepicker.delegate = self;
        imagepicker.allowsEditing = YES;
        imagepicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:imagepicker animated:YES completion:^{}];
    }
}

// 相册中选择图片
- (void)choosePhotoLibAction {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:picker animated:YES completion:^{}];
    }
}

#pragma mark - 图片处理

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    CLog(@"--->>> 相册回调");
    [picker dismissViewControllerAnimated:YES completion:^{
        // 设置照片按钮信息
        UIImage *originImage = info[UIImagePickerControllerEditedImage];
        UIImage *image = [originImage resetSizeOfImageData:originImage maxSize:100];
        
        NSData * imageData = UIImageJPEGRepresentation(image,1);
        NSInteger length = [imageData length]/1000;
        CLog(@"--->> image size of %@kb", @(length));
        
        if (self.tapNumber == 1) {
            [self.firstBtn setImage:image forState:UIControlStateNormal];
            [self rebuildLayerWithBtn:self.firstBtn];
        } else if (self.tapNumber == 2) {
            [self.secondBtn setImage:image forState:UIControlStateNormal];
            [self rebuildLayerWithBtn:self.secondBtn];
            
        } else if (self.tapNumber == 3) {
            [self rebuildLayerWithBtn:self.thirdBtn];
            [self.thirdBtn setImage:image forState:UIControlStateNormal];
        }
        [self.photoList addObject:image];
    }];
}

@end
