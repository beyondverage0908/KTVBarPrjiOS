//
//  KTVPublishDynamicController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/10/19.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVPublishDynamicController.h"
#import "KTVDynamicHeaderCell.h"
#import "KTVDynamicPictureCell.h"
#import "KTVDynamicUserBaseCell.h"
#import "KTVAddMediaCell.h"

#import "KTVMainService.h"

#import "KTVTableHeaderView.h"

#import "UIImage+extension.h"

@interface KTVPublishDynamicController ()<UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate,UIImagePickerControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableDictionary *userInfo;
@property (strong, nonatomic) NSMutableArray *photoList; // 动态将上传的图片
@property (strong, nonatomic) NSMutableArray *vedioList; // 动态将上传的图片
@property (assign, nonatomic) NSInteger tapPickNumber; // 标志当前点击的是哪个section中的获取图片
@property (strong, nonatomic) UIImage *daynamicHeaderBgImage;  // 动态头部背景图片
@property (strong, nonatomic) UIImage *daynamicHeaderImage;  // 动态头部图片

@end

@implementation KTVPublishDynamicController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor ktvBG];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    [self initData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self clearNavigationbar:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self clearNavigationbar:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 初始化

- (void)initData {
    self.userInfo = [NSMutableDictionary dictionary];
    
    if ([KTVCommon userInfo].phone) {
        [self.userInfo setObject:[KTVCommon userInfo].phone forKey:@"username"];
    }
    
    self.photoList = [NSMutableArray array];
    self.vedioList = [NSMutableArray array];
}

#pragma mark - 网络

// 提交用户基本信息
- (void)submitUserDetail {
    [KTVMainService postSaveUserDetail:self.userInfo result:^(NSDictionary *result) {
        if ([result[@"code"] isEqualToString:ktvCode]) {
            [KTVToast toast:TOAST_SAVE_USERINFO_SUCCESS];
        } else {
            [KTVToast toast:result[@"detail"]];
        }
    }];
}

- (void)uploadUsePicture:(NSDictionary *)pickImageDict {
    if (!pickImageDict) {
        return;
    }
    NSString *key = pickImageDict.allKeys.firstObject;
    NSDictionary *param = @{@"username" : [KTVCommon userInfo].phone,
                             key : pickImageDict[key]};
    [KTVMainService postUploadUserPicture:param result:^(NSDictionary *result) {
        if ([result[@"code"] isEqualToString:ktvCode]) {
            [KTVToast toast:TOAST_UPLOAD_SUCCESS];
        } else {
            [KTVToast toast:result[@"detail"]];
        }
    }];
}

- (void)uploadUserHeader:(NSDictionary *)pickDict {
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:pickDict];
    [params setObject:[KTVCommon userInfo].phone forKey:@"username"];
    [KTVMainService postUploadHeader:params result:^(NSDictionary *result) {
        if ([result[@"code"] isEqualToString:ktvCode]) {
            [KTVToast toast:TOAST_UPLOAD_SUCCESS];
        } else {
            [KTVToast toast:result[@"detail"]];
        }
    }];
}

- (void)uploadUserHeaderBg:(NSDictionary *)pickDict {
    if (!pickDict) {
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:pickDict];
    [params setObject:[KTVCommon userInfo].phone forKey:@"username"];
    [KTVMainService postUploadHeaderBg:params result:^(NSDictionary *result) {
        if ([result[@"code"] isEqualToString:ktvCode]) {
            [KTVToast toast:TOAST_UPLOAD_SUCCESS];
        } else {
            [KTVToast toast:result[@"detail"]];
        }
    }];
}

#pragma mark - 事件

- (IBAction)submitAction:(UIButton *)sender {
    CLog(@"-->> 提交");
    [self submitUserDetail];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        KTVDynamicHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVDynamicHeaderCell)];
        cell.headerBgImage = self.daynamicHeaderBgImage;
        cell.pickHeaderBgImageCallback = ^{
            self.tapPickNumber = 0;
            [self showAlterSheet];
        };
        cell.headerImage = self.daynamicHeaderImage;
        cell.pickHeaderImageCallback = ^{
            self.tapPickNumber = 3;
            [self showAlterSheet];
        };
        cell.user = self.user;
        return cell;
    } else if (indexPath.section == 1) {
        NSInteger imgCount = self.user.pictureList.count;
        for (NSInteger i = imgCount - 1; i > 1; i--) {
            [self.photoList addObject:self.user.pictureList[i].pictureUrl];
        }
        KTVAddMediaCell *cell = [[KTVAddMediaCell alloc] initWithMediaList:self.photoList style:UITableViewCellStyleDefault reuseIdentifier:@"KTVAddMediaCell"];
        cell.pickImageCallback = ^{
            self.tapPickNumber = 1;
            [self showAlterSheet];
        };
        return cell;
    } else if (indexPath.section == 2) {
        KTVAddMediaCell *cell = [[KTVAddMediaCell alloc] initWithMediaList:self.vedioList style:UITableViewCellStyleDefault reuseIdentifier:@"KTVAddMediaCell"];
        cell.pickImageCallback = ^{
            self.tapPickNumber = 2;
            [self showAlterSheet];
        };
        return cell;
    } else if (indexPath.section == 3) {
        KTVDynamicPictureCell *cell = [tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVDynamicPictureCell)];
        return cell;
    } else if (indexPath.section == 4) {
        KTVDynamicUserBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVDynamicUserBaseCell)];
        cell.userInfoCallback = ^(NSDictionary *userInfo) {
            [self.userInfo setObject:userInfo forKey:@"userDetail"];
        };
        return cell;
    }
    return [UITableViewCell new];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 233;
    } else if (indexPath.section == 1) {
        return 90;
    } else if (indexPath.section == 2) {
        return 90;
    } else if (indexPath.section == 3) {
        return 163;
    } else if (indexPath.section == 4) {
        return 746;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:nil title:@"我的相册" remark:nil];
        return headerView;
    } else if (section == 2) {
        KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:nil title:@"我的视频" remark:nil];
        return headerView;
    } else if (section == 3) {
        KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:nil title:@"动态" remark:nil];
        return headerView;
    } else if (section == 4) {
        KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:nil title:@"关于我" remark:nil];
        return headerView;
    }
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1 || section == 2 || section == 3 || section == 4) {
        return 30;
    }
    return 0;
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
        UIImage *originImage = info[UIImagePickerControllerOriginalImage];
        if (self.tapPickNumber == 0) {
            UIImage *image = [KTVUtil clipImage:originImage toRect:CGSizeMake(KtvScreenW, 140)];
            image = [image resetSizeOfImageData:image maxSize:100];
            self.daynamicHeaderBgImage = image;
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
            NSDictionary *param = @{@"file" : image};
            [self uploadUsePicture:param];
        } else if (self.tapPickNumber == 1) {
            originImage = [originImage resetSizeOfImageData:originImage maxSize:100];
            [self.photoList insertObject:originImage atIndex:0];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
            NSDictionary *param = @{@"file" : originImage};
            [self uploadUsePicture:param];
        } else if (self.tapPickNumber == 2) {
            
        } else if (self.tapPickNumber == 3) {
            UIImage *image = [KTVUtil clipImage:originImage toRect:CGSizeMake(130, 130)];
            self.daynamicHeaderImage = image;
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
            NSDictionary *param = @{@"file" : image};
            [self uploadUsePicture:param];
        }
    }];
}

@end
