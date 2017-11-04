//
//  KTVPublishDateController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/29.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVPublishDateController.h"
#import "KTVCallOtherController.h"
#import "KTVStoreViewController.h"

#import "KTVPickerView.h"

#import "KTVMainService.h"

#import "UIImage+extension.h"

@interface KTVPublishDateController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *barNameBtn;
@property (weak, nonatomic) IBOutlet UIButton *yearBtn;
@property (weak, nonatomic) IBOutlet UIButton *monthBtn;
@property (weak, nonatomic) IBOutlet UIButton *dayBtn;
@property (weak, nonatomic) IBOutlet UIButton *genderBtn;
@property (weak, nonatomic) IBOutlet UIButton *payBtn; // 费用
@property (weak, nonatomic) IBOutlet UITextView *explainTextView;
@property (weak, nonatomic) IBOutlet UIImageView *firstimageView;
@property (weak, nonatomic) IBOutlet UIImageView *secondImageView;
@property (weak, nonatomic) IBOutlet UIImageView *thirdImageView;

@property (strong, nonatomic) NSMutableDictionary *params;

@property (assign, nonatomic) NSInteger tapNumber; // 用于标示上传图片当前选中的是第几个
@property (strong, nonatomic) NSMutableArray<UIImage *> *photoList; // 图片对象数组

@end

@implementation KTVPublishDateController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.type == 0) {
        self.title = @"酒吧";
        [self.barNameBtn setTitle:@"点击选择酒吧" forState:UIControlStateNormal];
    } else {
        self.title = @"KTV";
        [self.barNameBtn setTitle:@"点击选择KTV" forState:UIControlStateNormal];
    }
    
    [self initUI];
    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 重写

- (NSMutableArray<UIImage *> *)photoList {
    if (!_photoList) {
        _photoList = [NSMutableArray arrayWithCapacity:3];
    }
    return _photoList;
}

#pragma mark - 初始化Ui

- (void)initUI {
    self.explainTextView.backgroundColor = [UIColor ktvTextFieldBg];
    self.explainTextView.layer.cornerRadius = 5;
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(firstClick:)];
    [self.firstimageView addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(secondClick:)];
    [self.secondImageView addGestureRecognizer:tap2];
    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(thirdClick:)];
    [self.thirdImageView addGestureRecognizer:tap3];
}

#pragma mark - 初始化

- (void)initData {
    self.params = [NSMutableDictionary dictionary];
    [self.params setObject:[KTVCommon userInfo].phone forKey:@"username"];
    [self.params setObject:@"0" forKey:@"sex"];
    [self.params setObject:@0 forKey:@"consumeType"];
    [self.params setObject:[NSNumber numberWithBool:NO] forKey:@"puckUp"];
}

#pragma mark - 事件

- (IBAction)chooseBarAction:(UIButton *)sender {
    CLog(@"-->> 选择酒吧");
    KTVStoreViewController *vc = (KTVStoreViewController *)[UIViewController storyboardName:@"MainPage" storyboardId:@"KTVStoreViewController"];
    vc.storeType = self.type;
    vc.selectedStoreCallback = ^(KTVStore *store) {
        [self.barNameBtn setTitle:store.storeName forState:UIControlStateNormal];
        [self.params setObject:store.storeId forKey:@"storeId"];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)chooseYearAction:(UIButton *)sender {
    CLog(@"-->> 选择年");
    KTVPickerView *pv = [[KTVPickerView alloc] initWithSelectedCallback:^(NSString *selectedTitle) {
        [sender setTitle:selectedTitle forState:UIControlStateNormal];
    }];
    [self.view addSubview:pv];
    pv.dataSource = [KTVUtil yearList];
    [pv mas_makeConstraints:^(MASConstraintMaker *make) {make.edges.equalTo(self.view);}];
}

- (IBAction)chooseMonthAction:(UIButton *)sender {
    CLog(@"-->> 选择月");
    KTVPickerView *pv = [[KTVPickerView alloc] initWithSelectedCallback:^(NSString *selectedTitle) {
        [sender setTitle:selectedTitle forState:UIControlStateNormal];
    }];
    [self.view addSubview:pv];
    pv.dataSource = [KTVUtil monthList];
    [pv mas_makeConstraints:^(MASConstraintMaker *make) {make.edges.equalTo(self.view);}];
}

- (IBAction)chooseDayAction:(UIButton *)sender {
    CLog(@"-->> 选择日");
    NSInteger month = [self.monthBtn.currentTitle integerValue];
    KTVPickerView *pv = [[KTVPickerView alloc] initWithSelectedCallback:^(NSString *selectedTitle) {
        [sender setTitle:selectedTitle forState:UIControlStateNormal];
    }];
    [self.view addSubview:pv];
    pv.dataSource = [KTVUtil dayListByMonth:month];
    [pv mas_makeConstraints:^(MASConstraintMaker *make) {make.edges.equalTo(self.view);}];
}

- (IBAction)chooseGenderAction:(UIButton *)sender {
    CLog(@"-->> 选择性别");
    KTVPickerView *pv = [[KTVPickerView alloc] initWithSelectedCallback:^(NSString *selectedTitle) {
        [sender setTitle:selectedTitle forState:UIControlStateNormal];
        if ([selectedTitle isEqualToString:@"男"]) {
            [self.params setObject:@"1" forKey:@"sex"];
        } else {
            [self.params setObject:@"0" forKey:@"sex"];
        }
    }];
    [self.view addSubview:pv];
    pv.dataSource = @[@"女", @"男"];
    [pv mas_makeConstraints:^(MASConstraintMaker *make) {make.edges.equalTo(self.view);}];
}

- (IBAction)choosePayAction:(UIButton *)sender {
    CLog(@"-->> 选择付款方式");
    NSArray *dataSource = @[@"AA制", @"我买单"];
    KTVPickerView *pv = [[KTVPickerView alloc] initWithSelectedCallback:^(NSString *selectedTitle) {
        [sender setTitle:selectedTitle forState:UIControlStateNormal];
        for (NSInteger i = 0; i < dataSource.count; i++) {
            if ([dataSource[i] isEqualToString:selectedTitle]) {
                [self.params setObject:@(i) forKey:@"consumeType"];
                return;
            }
        }
    }];
    [self.view addSubview:pv];
    pv.dataSource = dataSource;
    [pv mas_makeConstraints:^(MASConstraintMaker *make) {make.edges.equalTo(self.view);}];
}

- (IBAction)chooseAendAction:(UIButton *)sender {
    CLog(@"-->> 我接送");
    [sender setSelected:!sender.isSelected];
    UIImage *image = nil;
    if (sender.isSelected) {
        image = [UIImage imageNamed:@"app_gou_red"];
        [self.params setObject:[NSNumber numberWithBool:YES] forKey:@"puckUp"];
    } else {
        image = [UIImage imageNamed:@"app_selected_kuang"];
        [self.params setObject:[NSNumber numberWithBool:NO] forKey:@"puckUp"];
    }
    [sender setImage:image forState:UIControlStateNormal];
}

- (IBAction)publishYueAction:(UIButton *)sender {
    CLog(@"-->> 发布预约");
    [self.params setObject:self.explainTextView.text forKey:@"description"];
    NSString *month = self.monthBtn.currentTitle;
    if (month.integerValue < 10) {
        month = [NSString stringWithFormat:@"0%@", month];
    }
    NSString *day = self.dayBtn.currentTitle;
    if (day.integerValue < 10) {
        day = [NSString stringWithFormat:@"0%@", day];
    }
    NSString *year = self.yearBtn.currentTitle;
    NSString *fullDate = [NSString stringWithFormat:@"%@-%@-%@", year, month, day];
    
    [self.params setObject:fullDate forKey:@"startTime"];
    if (self.photoList.count) {
        [self.params setObject:self.photoList forKey:@"file"];
    }
    
    CLog(@"-->>> %@", @(self.params.allKeys.count));
    
    [KTVMainService postCreateInvite:self.params result:^(NSDictionary *result) {
        if (![result[@"code"] isEqualToString:ktvCode]) {
            [KTVToast toast:TOAST_CREATE_INVITE_FAIL];
            return;
        }
        [KTVToast toast:TOAST_CREATE_SUCCESS];
        [self showYaoYueSuccess:YES];
    }];
}

- (void)cancelAction:(UIButton *)btn {
    [btn.superview.superview removeFromSuperview];
}

- (void)callOtherPlayAction:(UIButton *)btn {
    [btn.superview.superview removeFromSuperview];
    CLog(@"-->>> 喊人玩");
    KTVCallOtherController *vc = (KTVCallOtherController *)[UIViewController storyboardName:@"DatingFriend" storyboardId:@"KTVCallOtherController"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)firstClick:(UITapGestureRecognizer *)tap {
    self.tapNumber = 1;
    [self showAlterSheet];
}

- (void)secondClick:(UITapGestureRecognizer *)tap {
    self.tapNumber = 2;
    [self showAlterSheet];
}

- (void)thirdClick:(UITapGestureRecognizer *)tap {
    self.tapNumber = 3;
    [self showAlterSheet];
}

#pragma mark - 展示邀约成功弹出框

- (void)showYaoYueSuccess:(BOOL)isShow {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    UIView *mask = [[UIView alloc] init];
    [keyWindow addSubview:mask];
    mask.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.2];
    [mask mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(keyWindow);
    }];
    
    UIView *toastBgView = [[UIView alloc] init];
    [mask addSubview:toastBgView];
    toastBgView.backgroundColor = [UIColor whiteColor];
    toastBgView.layer.cornerRadius = 8;
    [toastBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(mask);
        make.width.equalTo(mask).multipliedBy(0.8);
        make.height.equalTo(toastBgView.mas_width).multipliedBy(0.6);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [toastBgView addSubview:titleLabel];
    titleLabel.textColor = [UIColor ktvBG];
    titleLabel.text = @"发布邀约成功";
    titleLabel.font = [UIFont bold17];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(toastBgView);
        make.top.equalTo(toastBgView).offset(20);
        make.width.equalTo(toastBgView).multipliedBy(0.9);
    }];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [toastBgView addSubview:cancelBtn];
    [cancelBtn setTitle:@"知道了" forState:UIControlStateNormal];
    cancelBtn.layer.borderColor = [UIColor ktvPlaceHolder].CGColor;
    cancelBtn.layer.borderWidth = 1;
    cancelBtn.layer.cornerRadius = 5;
    cancelBtn.titleLabel.font = [UIFont bold17];
    [cancelBtn setTitleColor:[UIColor ktvPlaceHolder] forState:UIControlStateNormal];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(toastBgView).offset(-15);
        make.width.equalTo(toastBgView).multipliedBy(0.4);
        make.height.equalTo(@40);
        make.left.equalTo(toastBgView).offset(10);
    }];
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [toastBgView addSubview:confirmBtn];
    [confirmBtn setTitle:@"喊人玩" forState:UIControlStateNormal];
    confirmBtn.layer.cornerRadius = 5;
    [confirmBtn setBackgroundColor:[UIColor ktvGold]];
    cancelBtn.titleLabel.font = [UIFont bold17];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(toastBgView).offset(-15);
        make.width.equalTo(toastBgView).multipliedBy(0.4);
        make.height.equalTo(@40);
        make.right.equalTo(toastBgView).offset(-10);
    }];
    
    UILabel *messageLabel = [[UILabel alloc] init];
    [toastBgView addSubview:messageLabel];
    messageLabel.textColor = [UIColor ktvBG];
    messageLabel.text = @"您的邀约已经发布，可以喊人来玩了～";
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.numberOfLines = 2;
    messageLabel.font = [UIFont systemFontOfSize:15];
    [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(toastBgView);
        make.top.equalTo(titleLabel.mas_bottom).offset(20);
        make.width.equalTo(toastBgView).multipliedBy(0.9);
        make.bottom.equalTo(cancelBtn.mas_top).offset(-20);
    }];
    
    // 添加按钮事件
    [cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [confirmBtn addTarget:self action:@selector(callOtherPlayAction:) forControlEvents:UIControlEventTouchUpInside];
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
            [self.firstimageView setImage:image];
        } else if (self.tapNumber == 2) {
            [self.secondImageView setImage:image];
        } else if (self.tapNumber == 3) {
            [self.thirdImageView setImage:image];
        }
        [self.photoList addObject:image];
    }];
}

@end
