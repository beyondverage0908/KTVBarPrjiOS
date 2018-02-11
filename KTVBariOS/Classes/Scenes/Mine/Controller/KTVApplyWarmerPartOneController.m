//
//  KTVApplyWarmerPartOneController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2018/1/27.
//  Copyright © 2018年 Lin. All rights reserved.
//

#import "KTVApplyWarmerPartOneController.h"
#import "KTVApplyWarmerPartTwoController.h"
#import "ApplyWarmerView.h"
#import "UIImage+extension.h"
#import <AVKit/AVKit.h>

@interface KTVApplyWarmerPartOneController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) NSMutableDictionary * warmerIdentifyDic;
@property (nonatomic, strong) ApplyWarmerView *applyView;
@property (nonatomic, assign) BOOL isZhengmian;

@property (nonatomic, strong) NSMutableDictionary *warmerParams;

@end

@implementation KTVApplyWarmerPartOneController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"申请成为暖场人";
    self.view.backgroundColor = [UIColor ktvBG];
    
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - override getter or setter

- (NSMutableDictionary *)warmerIdentifyDic {
    if (!_warmerIdentifyDic) {
        _warmerIdentifyDic = [NSMutableDictionary dictionaryWithCapacity:2];
    }
    return _warmerIdentifyDic;
}

- (NSMutableDictionary *)warmerParams {
    if (!_warmerParams) {
        _warmerParams = [NSMutableDictionary dictionaryWithCapacity:10];
    }
    return _warmerParams;
}

#pragma mark - init

- (void)initUI {
    self.applyView = [[[NSBundle mainBundle] loadNibNamed:@"ApplyWarmerView" owner:self options:nil] firstObject];
    CGRect frame = self.view.frame;
    frame.size.height = frame.size.height - 64;
    self.applyView.frame = frame;
    [self.view addSubview:self.applyView];
    
    @WeakObj(self);
    self.applyView.uploadIDCallback = ^(BOOL isTop) {
        if (isTop) {
            CLog(@"上传正面 --- ");
            [weakself showAlterSheet];
        } else {
            CLog(@"上传反面 --- ");
            [weakself showAlterSheet];
        }
        weakself.isZhengmian = isTop;
    };
    
    self.applyView.uploadVedioCallback = ^{
        [weakself showVideoSheet];
    };
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 64, self.view.frame.size.width, 64)];
    [self.view addSubview:bgView];
    bgView.backgroundColor = [UIColor ktvBG];
    
    UIButton *nextBtn = [[UIButton alloc] init];
    [bgView addSubview:nextBtn];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn setBackgroundColor:[UIColor ktvRed]];
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(bgView);
        make.height.equalTo(bgView).multipliedBy(0.7);
        make.width.equalTo(bgView).multipliedBy(0.7);
    }];
    nextBtn.layer.cornerRadius = 8;
    [nextBtn addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - UI Action

- (void)nextAction:(UIButton *)btn {
    if (self.warmerIdentifyDic.allValues.count < 2) {
        [KTVToast toast:@"请上传身份照片"];
        return;
    } else {
        [self.warmerParams setObject:self.warmerIdentifyDic.allValues forKey:@"shz"];
    }
 
    NSDictionary *infodic = [self.applyView obtainWarmerInfo];
    [self.warmerParams addEntriesFromDictionary:infodic];
    
    if (self.warmerParams.allKeys.count < 5) {
        [KTVToast toast:@"请补全资料后进行下一步"];
        return;
    }
    
    KTVApplyWarmerPartTwoController *vc = [[KTVApplyWarmerPartTwoController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.warmerParams = self.warmerParams;
    [self.navigationController pushViewController:vc animated:YES];
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
    // UIImagePickerControllerMediaType = "public.image";
    // UIImagePickerControllerMediaType = "public.movie";
    @WeakObj(self);
    if ([info[@"UIImagePickerControllerMediaType"] isEqualToString:@"public.image"]) {
        // 设置照片按钮信息
        UIImage *originImage = info[UIImagePickerControllerEditedImage];
        UIImage *image = [originImage resetSizeOfImageData:originImage maxSize:100];
        if (weakself.isZhengmian) {
            [weakself.applyView setUserIdentifier:@{@"id_zhengmian" : image}];
            [weakself.warmerIdentifyDic setObject:image forKey:@"id_zhengmian"];
        }
        if (!weakself.isZhengmian) {
            [weakself.applyView setUserIdentifier:@{@"id_fanmian" : image}];
            [weakself.warmerIdentifyDic setObject:image forKey:@"id_fanmian"];
        }
    } else {
        NSURL *sourceURL = [info objectForKey:UIImagePickerControllerMediaURL];
        NSURL *newVideoUrl ; //一般.mp4
        // 用时间给文件全名，以免重复，在测试的时候其实可以判断文件是否存在若存在，则删除，重新生成文件即可
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];
        [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
        newVideoUrl = [NSURL fileURLWithPath:[NSHomeDirectory() stringByAppendingFormat:@"/Documents/output-%@.mp4", [formater stringFromDate:[NSDate date]]]] ;//这个是保存在app自己的沙盒路径里，后面可以选择是否在上传后删除掉。我建议删除掉，免得占空间。
        [self convertVideoQuailtyWithInputURL:sourceURL outputURL:newVideoUrl completeHandler:nil];
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
    if ([availableMedia count]) {
        ipc.mediaTypes = [NSArray arrayWithObject:availableMedia[1]];//设置媒体类型为public.movie
        [self presentViewController:ipc animated:YES completion:nil];
        ipc.delegate = self;//设置委托
    } else {
        [KTVToast toast:@"手机中暂无符合格式的视频"];
    }
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
        //[self uploadVideo:URL];
        [self.warmerParams setObject:URL forKey:@"video"];
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
//            [self uploadVideo:URL];
            [self.warmerParams setObject:URL forKey:@"video"];
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

@end
