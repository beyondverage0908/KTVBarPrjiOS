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
#import <AVKit/AVKit.h>
#import "KTVVideo.h"

@interface KTVPublishDynamicController ()<UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate,UIImagePickerControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableDictionary *userInfo;
@property (strong, nonatomic) NSMutableArray *photoList; // 动态将上传的图片
@property (strong, nonatomic) NSMutableArray<KTVVideo *> *videoList; // 动态将上传的图片
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
    // 默认先获取已经上传的视频
    self.videoList = [NSMutableArray arrayWithCapacity:self.user.videoList.count];
    for (NSInteger i = [self.user.videoList count] - 1; i >= 0; i--) {
        KTVVideo *video = self.user.videoList[i];
        if (video.url) {
            [self.videoList addObject:self.user.videoList[i]];
        }
    }
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

- (void)uploadVideo:(NSURL *)url {
    
    NSDictionary *params = @{@"username" : [KTVCommon userInfo].phone,
                             @"video" : url};
    [MBProgressHUD showMessage:@"上传中..."];
    [KTVMainService uploadVideo:params result:^(NSDictionary *result) {
        [MBProgressHUD hiddenHUD];
        if ([result[@"code"] isEqualToString:ktvCode]) {
            [self.videoList removeAllObjects];
            NSArray *videoList = result[@"data"][@"videoList"];
            for (NSInteger i = [videoList count] - 1; i >= 0; i--) {
                NSDictionary *dic = videoList[i];
                KTVVideo *video = [KTVVideo yy_modelWithDictionary:dic];
                [self.videoList addObject:video];
            }
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
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
        cell.pickImageCallback = ^(KTVMediaType mediaType) {
            self.tapPickNumber = 1;
            [self showAlterSheet];
        };
        return cell;
    } else if (indexPath.section == 2) {
        KTVAddMediaCell *cell = [[KTVAddMediaCell alloc] initWithMediaList:self.videoList style:UITableViewCellStyleDefault reuseIdentifier:@"KTVAddMediaCell"];
        cell.pickImageCallback = ^(KTVMediaType mediaType) {
            self.tapPickNumber = 2;
            if ([self.videoList count] >= 5) {
                [KTVToast toast:TOAST_VIDEO_CANT_MORETHAN_FIVE];
            } else {
                [self showVideoSheet];
            }
        };
        cell.showMediaCallback = ^(id media) {
            if ([media isKindOfClass:[KTVVideo class]]) {
                KTVVideo *video = (KTVVideo *)media;
                [self playVideaUrl:video.url];
            }
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
        
        NSURL *sourceURL = [info objectForKey:UIImagePickerControllerMediaURL];
        NSURL *newVideoUrl ; //一般.mp4
        // 用时间给文件全名，以免重复，在测试的时候其实可以判断文件是否存在若存在，则删除，重新生成文件即可
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];
        [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
        newVideoUrl = [NSURL fileURLWithPath:[NSHomeDirectory() stringByAppendingFormat:@"/Documents/output-%@.mp4", [formater stringFromDate:[NSDate date]]]] ;//这个是保存在app自己的沙盒路径里，后面可以选择是否在上传后删除掉。我建议删除掉，免得占空间。
        [self convertVideoQuailtyWithInputURL:sourceURL outputURL:newVideoUrl completeHandler:nil];
        
    } else if (self.tapPickNumber == 3) {
        UIImage *image = [KTVUtil clipImage:originImage toRect:CGSizeMake(130, 130)];
        self.daynamicHeaderImage = image;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
        NSDictionary *param = @{@"file" : image};
        [self uploadUsePicture:param];
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 拍摄视频

- (void)showVideoSheet {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:@"拍摄小视频" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self recordingVideo];
    }];
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"从相册选择视频" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self chooseVideo];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}];
    [alertController addAction:takePhotoAction];
    [alertController addAction:photoAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - 选择视频， 录制视频

//选择本地视频
- (void)chooseVideo
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;//sourcetype有三种分别是camera，photoLibrary和photoAlbum
    NSArray *availableMedia = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];//Camera所支持的Media格式都有哪些,共有两个分别是@"public.image",@"public.movie"
    ipc.mediaTypes = [NSArray arrayWithObject:availableMedia[1]];//设置媒体类型为public.movie
    [self presentViewController:ipc animated:YES completion:nil];
    ipc.delegate = self;//设置委托
}

//录制视频
- (void)recordingVideo
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;//sourcetype有三种分别是camera，photoLibrary和photoAlbum
    //Camera所支持的Media格式都有哪些,共有两个分别是@"public.image",@"public.movie"
    NSArray *availableMedia = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    ipc.mediaTypes = [NSArray arrayWithObject:availableMedia[1]];//设置媒体类型为public.movie
    [self presentViewController:ipc animated:YES completion:nil];
    ipc.videoMaximumDuration = 30.0f;//30秒
    ipc.videoQuality = UIImagePickerControllerQualityTypeHigh;
    
    ipc.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo; // 拍照模式
    ipc.cameraDevice = UIImagePickerControllerCameraDeviceRear; // 前置/后置摄像头 default rear
    
    UIView *overlayView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 100, self.view.frame.size.height - 250, 100, 150)];
    overlayView.backgroundColor = [UIColor yellowColor];
    ipc.cameraOverlayView = overlayView;
    
    ipc.delegate = self;//设置
}


#pragma mark - 视频大小

//此方法可以获取文件的大小，返回的是单位是KB。
- (CGFloat)getFileSize:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    float filesize = -1.0;
    if ([fileManager fileExistsAtPath:path]) {
        NSDictionary *fileDic = [fileManager attributesOfItemAtPath:path error:nil];//获取文件的属性
        unsigned long long size = [[fileDic objectForKey:NSFileSize] longLongValue];
        filesize = 1.0 * size / 1024;
    }
    return filesize;
}

//此方法可以获取视频文件的时长。
- (CGFloat)getVideoLength:(NSURL *)URL {
    AVURLAsset *avUrl = [AVURLAsset assetWithURL:URL];
    CMTime time = [avUrl duration];
    int second = ceil(time.value/time.timescale);
    return second;
}

#pragma mark - 转换视频质量

- (void)convertVideoQuailtyWithInputURL:(NSURL*)inputURL
                              outputURL:(NSURL*)outputURL
                        completeHandler:(void (^)(AVAssetExportSession*))handler
{
    [MBProgressHUD showMessage:@"处理中..."];
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:inputURL options:nil];
    
    AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetMediumQuality];
    exportSession.outputURL = outputURL;
    exportSession.outputFileType = AVFileTypeMPEG4;
    exportSession.shouldOptimizeForNetworkUse = YES;
    [exportSession exportAsynchronouslyWithCompletionHandler:^(void) {
         switch (exportSession.status) {
             case AVAssetExportSessionStatusCancelled:
                 break;
             case AVAssetExportSessionStatusUnknown:
                 break;
             case AVAssetExportSessionStatusWaiting:
                 break;
             case AVAssetExportSessionStatusExporting:
                 break;
             case AVAssetExportSessionStatusFailed:
                 break;
             case AVAssetExportSessionStatusCompleted:
             {
//                 UISaveVideoAtPathToSavedPhotosAlbum([outputURL path], self, nil, NULL);//这个是保存到手机相册
                 dispatch_async(dispatch_get_main_queue() , ^{
                     [MBProgressHUD hiddenHUD];
                     [self alertUploadVideo:outputURL];
                 });
             }
                 break;
             default:
                 NSLog(@"defalut");
         }
     }];
}


- (void)alertUploadVideo:(NSURL *)URL{
    CGFloat size = [self getFileSize:[URL path]];
    NSString *message;
    NSString *sizeString;
    CGFloat sizemb= size / 1024;
    if(size <= 1024){
        sizeString = [NSString stringWithFormat:@"%.2fKB",size];
    }else{
        sizeString = [NSString stringWithFormat:@"%.2fMB",sizemb];
    }
    
    if( sizemb < 2){
        [self uploadVideo:URL];
    } else if(sizemb <= 30){
        message = [NSString stringWithFormat:@"视频%@，大于30MB会有点慢，确定上传吗？", sizeString];
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil
                                                                                  message: message
                                                                           preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshwebpages" object:nil userInfo:nil];
            [[NSFileManager defaultManager] removeItemAtPath:[URL path] error:nil];//取消之后就删除，以免占用手机硬盘空间（沙盒）
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self uploadVideo:URL];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    } else if (sizemb > 30){
        message = [NSString stringWithFormat:@"视频%@，超过5MB，不能上传，抱歉。", sizeString];
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil
                                                                                  message: message
                                                                           preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshwebpages" object:nil userInfo:nil];
            [[NSFileManager defaultManager] removeItemAtPath:[URL path] error:nil];//取消之后就删除，以免占用手机硬盘空间
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

#pragma mark - 播放视频

- (void)playVideaUrl:(NSString *)videaUrl {
    //    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Alladin" withExtension:@"mp4"];
    if (videaUrl) {
        NSURL *url = [NSURL URLWithString:videaUrl];
        AVAsset *asset = [AVURLAsset URLAssetWithURL:url options:nil];
        AVPlayerItem *item = [AVPlayerItem playerItemWithAsset:asset];
        AVPlayer *player = [AVPlayer playerWithPlayerItem:item];
        
        AVPlayerViewController *playController = [[AVPlayerViewController alloc] init];
        playController.player = player;
        [playController.player play];
        [self presentViewController:playController animated:YES completion:nil];
    } else {
        [KTVToast toast:TOAST_VIDEO_CANT_PLAY];
    }
}

@end
