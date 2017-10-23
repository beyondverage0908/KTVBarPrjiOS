//
//  KTVApplyStoreController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/10/17.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVApplyStoreController.h"
#import <Photos/Photos.h>
#import "KTVMainService.h"
#import "UIImage+extension.h"
#import "KTVPickerView.h"

@interface KTVApplyStoreController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *firstImageview;
@property (weak, nonatomic) IBOutlet UIImageView *secondImageView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *numberTextField;
@property (weak, nonatomic) IBOutlet UITextField *storeNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;

@property (assign, nonatomic) NSInteger pickNumber;
@property (strong, nonatomic) NSMutableDictionary *params;
@property (strong, nonatomic) NSNumber *storeType;

@end

@implementation KTVApplyStoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"申请入驻成为商家";
    
    [self requestAuthorizationPhotoLib];
    
    self.firstImageview.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectFirstImageAction:)];
    [self.firstImageview addGestureRecognizer:tap1];
    
    self.secondImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectSecondImageAction:)];
    [self.secondImageView addGestureRecognizer:tap2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 重写方法

- (NSMutableDictionary *)params {
    if (!_params) {
        _params = [NSMutableDictionary dictionaryWithCapacity:6];
    }
    return _params;
}

#pragma mark - 申请相册访问权限认证

- (void)requestAuthorizationPhotoLib {
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

#pragma mark - 事件

- (void)selectFirstImageAction:(UITapGestureRecognizer *)tap {
    self.pickNumber = 1;
    [self showAlterSheet];
}

- (void)selectSecondImageAction:(UITapGestureRecognizer *)tap {
    self.pickNumber = 2;
    [self showAlterSheet];
}

- (IBAction)selectStoreType:(UIButton *)sender {
    [self pickDataSource:@[@"酒吧", @"KTV"] sender:sender];
}

- (IBAction)submitAction:(UIButton *)sender {
    CLog(@"--->>> 申请入驻商家提交");
    
    if (![KTVUtil isNullString:self.storeNameTextField.text]) {
        self.params[@"storeName"] = self.storeNameTextField.text;
    }
    if (![KTVUtil isNullString:self.nameTextField.text]) {
        self.params[@"username"] = self.nameTextField.text;
    }
    if (![KTVUtil isNullString:self.numberTextField.text]) {
        self.params[@"username"] = self.numberTextField.text;
    }
    if (![KTVUtil isNullString:self.addressTextField.text]) {
        self.params[@"addressName"] = self.addressTextField.text;
    }
    if (self.storeType) {
        self.params[@"storeType"] = self.storeType;
    }
    self.params[@"latitude"] = @"121.48799949";
    self.params[@"longitude"] = @"31.24914171";
    
    if ([self.params.allKeys count] < 6) {
        [KTVToast toast:TOAST_EMPTY_INFO];
        return;
    }
    
    [KTVMainService postUserEnter:self.params result:^(NSDictionary *result) {
        if (![result[@"code"] isEqualToString:ktvCode]) {
            [KTVToast toast:result[@"detail"]];
            return;
        }
        [KTVToast toast:TOAST_APPLY_STORE_SUCCESS];
        [self.navigationController popViewControllerAnimated:YES];
    }];
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

#pragma mark - 封装

- (void)pickDataSource:(NSArray<NSString *> *)dataSource sender:(UIButton *)sender {
    UIView *superView = [UIApplication sharedApplication].keyWindow;
    KTVPickerView *pv = [[KTVPickerView alloc] initWithSelectedCallback:^(NSString *selectedTitle) {
        [sender setTitle:selectedTitle forState:UIControlStateNormal];
        if ([selectedTitle isEqualToString:@"酒吧"]) {
            self.storeType = [NSNumber numberWithInteger:0];
        } else if ([selectedTitle isEqualToString:@"KTV"]) {
            self.storeType = [NSNumber numberWithInteger:1];
        }
    }];
    [superView addSubview:pv];
    [pv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superView);
    }];
    pv.dataSource = dataSource;
}

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
        UIImage *image = [KTVUtil scaleImage:info[UIImagePickerControllerOriginalImage] toSize:CGSizeMake(100, 100)];
        image = [image resetSizeOfImageData:image maxSize:100];
        if (self.pickNumber == 1) {
            // 第一张图片
            self.firstImageview.image = image;
            self.params[@"businessLicencePictureFile"] = image;
        } else if (self.pickNumber == 2) {
            // 第二张图片
            self.secondImageView.image = image;
            self.params[@"handBusinessLicencePictureFile"] = image;
        }
    }];
}


@end
