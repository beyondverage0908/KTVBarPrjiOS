//
//  KTVRegisterController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/7/9.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVRegisterController.h"
#import "KTVUnderlineButton.h"
#import "KTVLoginInputView.h"
#import "KTVLoginService.h"

@interface KTVRegisterController ()<KTVLoginInputViewDelegate>

@property (strong, nonatomic) UIImageView *tabBgView;
@property (strong, nonatomic) NSArray *titleArray;
@property (strong, nonatomic) UIScrollView *pageView;

@property (strong, nonatomic) UIView *datePickerBgView;
@property (strong, nonatomic) UIDatePicker *datePickerView;

@property (assign, nonatomic) NSInteger currentPage;            // scrollView当前第几页
@property (strong, nonatomic) NSMutableDictionary *registerParams;
@property (strong, nonatomic) NSMutableDictionary *registerDetailParams; // 注册详情

@property (nonatomic, assign) BOOL agreeProtocol;                // 是否同意协议

@end

@implementation KTVRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    self.view.backgroundColor = [UIColor whiteColor];
    self.currentPage = 0;
    
    [self initRegisterUI];
    [self initDatePickerUI];
    [self initData];
}

- (void)initData {
    self.registerParams = [NSMutableDictionary dictionaryWithCapacity:6];
    [self.registerParams setObject:[NSNumber numberWithInteger:1] forKey:@"userType"];
    
    self.registerDetailParams = [NSMutableDictionary dictionary];
    // 默认出生年月1990-08-21
    [self.registerDetailParams setObject:@"1990-08-21" forKey:@"birthday"];
    // 默认男
    [self.registerDetailParams setObject:@"1" forKey:@"sex"];
}

- (void)initDatePickerUI {
    self.datePickerBgView = [[UIView alloc] init];
    self.datePickerBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.datePickerBgView];
    [self.datePickerBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.and.bottom.equalTo(self.view);
        make.height.equalTo(self.view).multipliedBy(.4f);
    }];
    
    UIView *headerView = [[UIView alloc] init];
    [self.datePickerBgView addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.and.right.equalTo(self.datePickerBgView);
        make.height.mas_equalTo(@50);
    }];
    
    UIButton *cancelBtn = [[UIButton alloc] init];
    [headerView addSubview:cancelBtn];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont bold15];
    [cancelBtn setTitleColor:[UIColor ktvBG] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(pickerDateCancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).offset(15);
        make.centerY.equalTo(headerView);
    }];
    
    UIButton *confirmBtn = [[UIButton alloc] init];
    [headerView addSubview:confirmBtn];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = [UIFont bold15];
    [confirmBtn setTitleColor:[UIColor ktvRed] forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(pickerDateConfirmAction:) forControlEvents:UIControlEventTouchUpInside];
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(headerView).offset(-15);
        make.centerY.equalTo(headerView);
    }];
    
    self.datePickerView = [[UIDatePicker alloc] init];
    [self.datePickerBgView addSubview:self.datePickerView];
    [self.datePickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_bottom);
        make.left.right.and.bottom.equalTo(self.datePickerBgView);
    }];
    
    self.datePickerView.datePickerMode = UIDatePickerModeDate;
    self.datePickerView.minimumDate = [NSDate dateWithDateString:@"1960-01-01 12:12:12" andFormatString:@"yyyy-MM-dd HH:mm:ss"];
    self.datePickerView.maximumDate = [NSDate date];
    [self.datePickerView setDate:[NSDate dateWithDateString:@"1990-01-01 00:00:00" andFormatString:@"yyyy-MM-dd HH:mm:ss"] animated:YES];
    
    self.datePickerBgView.alpha = 0;
    self.datePickerBgView.hidden = YES;
}

- (void)initRegisterUI {
    self.tabBgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_navigation_bar"]];
    [self.view addSubview:self.tabBgView];
    self.tabBgView.userInteractionEnabled = YES;
    [self.tabBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.mas_topLayoutGuideBottom);
    }];
    
    self.titleArray = @[@"1.填写用户信息", @"2.填写手机号码", @"3.填写验证码"];
    CGFloat itemW = self.tabBgView.frame.size.width / self.titleArray.count;
    for (NSInteger i = 0; i < self.titleArray.count; i++) {
        KTVUnderlineButton *btn = [[KTVUnderlineButton alloc] init];
        [self.tabBgView addSubview:btn];
        [btn setTitle:self.titleArray[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.tag = 1000 + i;
//        [btn addTarget:self action:@selector(registerTabAction:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat centerXOffset = itemW * (i + 0.5f);
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.equalTo(self.tabBgView);
            make.centerX.equalTo(self.tabBgView.mas_left).mas_offset(centerXOffset);
        }];
    }
    // 默认选中第一个
    KTVUnderlineButton *btn = [self.tabBgView viewWithTag:1000];
    [btn setSelected:YES];
    [btn setTitleColor:[UIColor ktvRed] forState:UIControlStateNormal];
    
    self.pageView = [[UIScrollView alloc] init];
    [self.view addSubview:self.pageView];
    self.pageView.scrollEnabled = NO;
    self.pageView.userInteractionEnabled = YES;
    [self.pageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tabBgView.mas_bottom);
        make.left.and.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-99);
    }];
    
    UIView *containerView = [[UIView alloc] init];
    [self.pageView addSubview:containerView];
    containerView.userInteractionEnabled = YES;
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.pageView);
        make.height.equalTo(self.pageView);
    }];
    
    //  第一个
    UIView *firstPageView = [[UIView alloc] init];
    [containerView addSubview:firstPageView];
    firstPageView.userInteractionEnabled = YES;
    [firstPageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(containerView);
        make.width.equalTo(self.pageView);
        make.height.equalTo(self.pageView);
        make.left.equalTo(containerView);
    }];
    [self generateFirstPage:firstPageView];

    // 第二个
    UIView *secondPageView = [[UIView alloc] init];
    [containerView addSubview:secondPageView];
    secondPageView.userInteractionEnabled = YES;
    [secondPageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(containerView);
        make.size.equalTo(firstPageView);
        make.left.equalTo(firstPageView.mas_right);
    }];
    [self generateSecondPage:secondPageView];

    // 第三个
    UIView *thirdPageView = [[UIView alloc] init];
    [containerView addSubview:thirdPageView];
    thirdPageView.userInteractionEnabled = YES;
    [thirdPageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(containerView);
        make.size.equalTo(firstPageView);
        make.left.equalTo(secondPageView.mas_right);
        make.right.equalTo(containerView);
    }];
    [self generateThirdPage:thirdPageView];
}

- (void)diyiyaAction:(UIButton *)btn {
    CLog(@"--->>>diyiya");
}

- (void)generateFirstPage:(UIView *)superView {
    UIButton *firstBgViewBtn = [[UIButton alloc] init];
    [superView addSubview:firstBgViewBtn];
    [firstBgViewBtn setBackgroundImage:[UIImage imageNamed:@"app_input"] forState:UIControlStateNormal];
    [firstBgViewBtn addTarget:self action:@selector(getBirthdayAction:) forControlEvents:UIControlEventTouchUpInside];
    [firstBgViewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView).offset(67.5);
        make.left.equalTo(superView).offset(30);
        make.right.equalTo(superView).offset(-30);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [firstBgViewBtn addSubview:titleLabel];
    titleLabel.text = @"生日";
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.textColor = [UIColor whiteColor];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(firstBgViewBtn).offset(10);
        make.top.and.bottom.equalTo(firstBgViewBtn);
    }];
    
    UILabel *borthdayLabel = [[UILabel alloc] init];
    [firstBgViewBtn addSubview:borthdayLabel];
    borthdayLabel.text = @"1990-08-21";
    borthdayLabel.font = [UIFont boldSystemFontOfSize:17];
    borthdayLabel.textColor = [UIColor whiteColor];
    borthdayLabel.tag = 10000;
    [borthdayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel.mas_right).mas_offset(35);
        make.top.and.bottom.equalTo(firstBgViewBtn);
    }];
    
    UIImageView *arrowRightImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_arrow_right"]];
    [firstBgViewBtn addSubview:arrowRightImgView];
    [arrowRightImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(firstBgViewBtn);
        make.right.equalTo(firstBgViewBtn).offset(-13.5);
    }];
    
    UIButton *secondBgViewBtn = [[UIButton alloc] init];
    [secondBgViewBtn setBackgroundImage:[UIImage imageNamed:@"app_input"] forState:UIControlStateNormal];
    [secondBgViewBtn addTarget:self action:@selector(getGenderAction:) forControlEvents:UIControlEventTouchUpInside];
    [superView addSubview:secondBgViewBtn];
    [secondBgViewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstBgViewBtn.mas_bottom).offset(17.5);
        make.left.equalTo(superView).offset(30);
        make.right.equalTo(superView).offset(-30);
    }];
    
    UILabel *stitleLabel = [[UILabel alloc] init];
    [secondBgViewBtn addSubview:stitleLabel];
    stitleLabel.text = @"性别";
    stitleLabel.font = [UIFont boldSystemFontOfSize:17];
    stitleLabel.textColor = [UIColor whiteColor];
    [stitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(secondBgViewBtn).offset(10);
        make.top.and.bottom.equalTo(secondBgViewBtn);
    }];
    
    UILabel *genderLabel = [[UILabel alloc] init];
    [secondBgViewBtn addSubview:genderLabel];
    genderLabel.text = @"男";
    genderLabel.font = [UIFont boldSystemFontOfSize:17];
    genderLabel.textColor = [UIColor whiteColor];
    genderLabel.tag = 20000;
    [genderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(stitleLabel.mas_right).mas_offset(35);
        make.top.and.bottom.equalTo(secondBgViewBtn);
    }];
    
    UILabel *declareLabel = [[UILabel alloc] init];
    [superView addSubview:declareLabel];
    declareLabel.text = @"注册成功后，性别不可更改";
    declareLabel.font = [UIFont boldSystemFontOfSize:14];
    declareLabel.textColor = [UIColor whiteColor];
    [declareLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(superView);
        make.top.equalTo(secondBgViewBtn.mas_bottom).mas_offset(15);
    }];

    UIButton *nextBtn = [[UIButton alloc] init];
    [superView addSubview:nextBtn];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn setBackgroundImage:[UIImage imageNamed:@"app_anniu_red"] forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(nextStepAction:) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(superView);
        make.top.equalTo(declareLabel.mas_bottom).offset(15);
    }];
    
    UILabel *protocolLabel = [[UILabel alloc] init];
    [superView addSubview:protocolLabel];
    protocolLabel.text = @"我已阅读并接受《酒吧APP协议》";
    protocolLabel.font = [UIFont boldSystemFontOfSize:14];
    protocolLabel.textColor = [UIColor whiteColor];
    [protocolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(superView);
        make.top.equalTo(nextBtn.mas_bottom).mas_offset(45);
    }];
    
    // app_selected_kuang app_gou_red
    UIButton *selectedBtn = [[UIButton alloc] init];
    [superView addSubview:selectedBtn];
    [selectedBtn addTarget:self action:@selector(agreeProtolAction:) forControlEvents:UIControlEventTouchUpInside];
    [selectedBtn setImage:[UIImage imageNamed:@"app_selected_kuang"] forState:UIControlStateNormal];
    [selectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(protocolLabel.mas_right).offset(5);
        make.centerY.equalTo(protocolLabel);
    }];
}

- (void)generateSecondPage:(UIView *)superView {
    KTVLoginInputView *mobileInputView = [[KTVLoginInputView alloc] init];
    [superView addSubview:mobileInputView];
    mobileInputView.inputType = KTVInputMobileType;
    mobileInputView.delegate = self;
    [mobileInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView.mas_top).mas_offset(67.5);
        make.left.equalTo(superView).offset(30);
        make.right.equalTo(superView).offset(-30);
    }];
    
    KTVLoginInputView *psdInputView = [[KTVLoginInputView alloc] init];
    [superView addSubview:psdInputView];
    psdInputView.inputType = KTVInputLockType;
    psdInputView.delegate = self;
    [psdInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mobileInputView.mas_bottom).mas_offset(22.5);
        make.left.equalTo(superView).offset(30);
        make.right.equalTo(superView).offset(-30);
    }];
    
    UIButton *secondNextBtn = [[UIButton alloc] init];
    [superView addSubview:secondNextBtn];
    [secondNextBtn setBackgroundImage:[UIImage imageNamed:@"app_anniu_red"] forState:UIControlStateNormal];
    [secondNextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [secondNextBtn addTarget:self action:@selector(nextStepAction:) forControlEvents:UIControlEventTouchUpInside];
    [secondNextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(psdInputView.mas_bottom).offset(30);
        make.centerX.equalTo(superView);
    }];
    
    UILabel *protocolLabel = [[UILabel alloc] init];
    [superView addSubview:protocolLabel];
    protocolLabel.text = @"我已阅读并接受《酒吧APP协议》";
    protocolLabel.font = [UIFont boldSystemFontOfSize:14];
    protocolLabel.textColor = [UIColor whiteColor];
    [protocolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(superView);
        make.top.equalTo(secondNextBtn.mas_bottom).mas_offset(45);
    }];
    
    // app_selected_kuang app_gou_red
    UIButton *selectedBtn = [[UIButton alloc] init];
    [superView addSubview:selectedBtn];
    [selectedBtn addTarget:self action:@selector(secondAgreeProtolAction:) forControlEvents:UIControlEventTouchUpInside];
    [selectedBtn setImage:[UIImage imageNamed:@"app_selected_kuang"] forState:UIControlStateNormal];
    [selectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(protocolLabel.mas_right).offset(5);
        make.centerY.equalTo(protocolLabel);
    }];
}

- (void)generateThirdPage:(UIView *)superView {
    UILabel *verfiyTipLabel = [[UILabel alloc] init];
    [superView addSubview:verfiyTipLabel];
    verfiyTipLabel.text = @"为了您的安全，我们会给你的手机发送验证码";
    verfiyTipLabel.font = [UIFont boldSystemFontOfSize:14];
    verfiyTipLabel.textColor = [UIColor whiteColor];
    [verfiyTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView).offset(84.5);
        make.left.equalTo(superView).offset(30);
        make.right.equalTo(superView).offset(-30);
    }];
    
    KTVLoginInputView *inputView = [[KTVLoginInputView alloc] init];
    [superView addSubview:inputView];
    inputView.inputType = KTVInputVerfiyType;
    inputView.delegate = self;
    [inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(verfiyTipLabel.mas_bottom).mas_offset(30);
        make.left.equalTo(superView).offset(30);
        make.right.equalTo(superView).offset(-30);
    }];
    
    UILabel *verfiyDownLabel = [[UILabel alloc] init];
    [superView addSubview:verfiyDownLabel];
    verfiyDownLabel.text = @"接受短信大约需要 60 秒";
    verfiyDownLabel.textColor = [UIColor whiteColor];
    verfiyDownLabel.font = [UIFont boldSystemFontOfSize:14];
    [verfiyDownLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(superView);
        make.top.equalTo(inputView.mas_bottom).offset(15);
    }];
    
    UIButton *completeBtn = [[UIButton alloc] init];
    [superView addSubview:completeBtn];
    [completeBtn setTitle:@"注册完成" forState:UIControlStateNormal];
    [completeBtn setBackgroundImage:[UIImage imageNamed:@"app_anniu_red"] forState:UIControlStateNormal];
    [completeBtn addTarget:self action:@selector(completeRegisterAction:) forControlEvents:UIControlEventTouchUpInside];
    [completeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView).offset(30);
        make.right.equalTo(superView).offset(-30);
        make.top.equalTo(verfiyDownLabel.mas_bottom).offset(15);
    }];
}

#pragma mark - Tab Action

- (void)registerTabAction:(UIButton *)btn {
    [self changeButtonStatusBy:btn.tag];
    CGFloat tab = btn.tag - 1000;
    self.pageView.contentOffset = CGPointMake(tab * CGRectGetWidth(self.pageView.frame), 0);
}

- (void)switchPage:(NSInteger)page {
    [self changeButtonStatusBy:page];
    self.pageView.contentOffset = CGPointMake(page * CGRectGetWidth(self.pageView.frame), 0);
}

- (void)changeButtonStatusBy:(NSInteger)page {
    NSInteger tag = page + 1000;
    KTVUnderlineButton *btn = [self.tabBgView viewWithTag:tag];
    [btn setSelected:YES];
    [btn setTitleColor:[UIColor ktvRed] forState:UIControlStateNormal];
    
    for (NSInteger i = 1000; i < 1000 + self.titleArray.count; i++) {
        if (tag == i) {
            continue;
        }
        KTVUnderlineButton *btn = [self.tabBgView viewWithTag:i];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setSelected:NO];
    }
}

#pragma mark - 事件

// app_selected_kuang app_gou_red
- (void)agreeProtolAction:(UIButton *)btn {
    [btn setSelected:!btn.isSelected];
    
    self.agreeProtocol = btn.isSelected;
    
    if (btn.isSelected) {
        [btn setImage:[UIImage imageNamed:@"app_gou_red"] forState:UIControlStateNormal];
    } else {
        [btn setImage:[UIImage imageNamed:@"app_selected_kuang"] forState:UIControlStateNormal];
    }
}

- (void)secondAgreeProtolAction:(UIButton *)btn {
    [btn setSelected:!btn.isSelected];
    
    self.agreeProtocol = btn.isSelected;
    if (btn.isSelected) {
        [btn setImage:[UIImage imageNamed:@"app_gou_red"] forState:UIControlStateNormal];
    } else {
        [btn setImage:[UIImage imageNamed:@"app_selected_kuang"] forState:UIControlStateNormal];
    }
}

#pragma mark - KTVLoginInputViewDelegate 

- (void)inputView:(KTVLoginInputView *)inputView inputType:(KTVInputType)type inputValue:(NSString *)inputValue {
    switch (type) {
        case KTVInputMobileType:
        {
            [self.registerDetailParams setObject:inputValue forKey:@"phone"]; // 用户的电话号码
            [self.registerParams setObject:inputValue forKey:@"phone"]; // 用户的电话号码
        }
            break;
        case KTVInputLockType:
        {
            [self.registerParams setObject:inputValue forKey:@"password"]; // 用户密码
            [self.registerParams setObject:inputValue forKey:@"confirmPassword"];
        }
            break;
        case KTVInputVerfiyType:
        {
            [self.registerParams setObject:inputValue forKey:@"verfiyCode"]; // 验证码
        }
            break;
        default:
            break;
    }
    CLog(@"--->>>input--->>> %@", inputValue);
}

#pragma mark - 点击事件

- (void)getBirthdayAction:(UIButton *)btn {
    CLog(@"--->>> 获取出生年月");
    [UIView animateWithDuration:0.5f animations:^{
        self.datePickerBgView.alpha = 1;
        self.datePickerBgView.hidden = NO;
    }];
}

- (void)getGenderAction:(UIButton *)btn {
    CLog(@"--->>> 获取性别");
    UILabel *genderLabel = (UILabel *)[self.pageView viewWithTag:20000];
    
    __block NSString *gender = @"1";
    UIAlertController *alertvc = [UIAlertController alertControllerWithTitle:@"请选择" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *manAction = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        CLog(@"--->>> 男");
        gender = @"1";
        genderLabel.text = @"男";
        [self.registerDetailParams setObject:gender forKey:@"sex"];
    }];
    [alertvc addAction:manAction];
    UIAlertAction *womanAction = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        CLog(@"--->>> 女");
        gender = @"0";
        genderLabel.text = @"女";
        [self.registerDetailParams setObject:gender forKey:@"sex"];
    }];
    [alertvc addAction:womanAction];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        CLog(@"--->>> 取消");
    }];
    [alertvc addAction:cancelAction];
    [self presentViewController:alertvc animated:YES completion:nil];
}

- (void)nextStepAction:(UIButton *)btn {
    [self.view endEditing:YES];
    
    if (!self.agreeProtocol) {
        [KTVToast toast:TOAST_CONFIRM_PROTOCOL];
        return;
    }
    
    CLog(@"--->>> 下一步");
    self.currentPage++;
    
    if (self.currentPage == 1) {
        [self switchPage:self.currentPage];
        self.agreeProtocol = NO;
        return;
    }
    
    if (self.currentPage == 2) {
        [KTVLoginService postRegisterDetaliParams:self.registerDetailParams result:^(NSDictionary *result) {
            if (![result[@"code"] isEqualToString:ktvCode]) {
                --self.currentPage;
                [KTVToast toast:result[@"detail"]];
                return;
            }
            [self switchPage:self.currentPage];
        }];
    }
}

- (void)completeRegisterAction:(UIButton *)btn {
    [self.view endEditing:YES];
    CLog(@"--->>> 完成注册");
    // 接口请求放这里
    [KTVLoginService postRegisterParams:self.registerParams result:^(NSDictionary *result) {
        if ([result[@"msg"] isEqualToString:@"Success"]) {
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            [KTVToast toast:result[@"detail"]];
        }
    }];
}

- (void)pickerDateCancelAction:(UIButton *)btn {
    CLog(@"--->>> 日期选择器 取消");
    [UIView animateWithDuration:0.5f animations:^{
        self.datePickerBgView.alpha = 0;
    } completion:^(BOOL finished) {
        self.datePickerBgView.hidden = YES;
    }];
}

- (void)pickerDateConfirmAction:(UIButton *)btn {
    CLog(@"--->>> 日期选择器 确定");
    [UIView animateWithDuration:0.5f animations:^{
        self.datePickerBgView.alpha = 0;
    } completion:^(BOOL finished) {
        self.datePickerBgView.hidden = YES;
    }];
    
    CLog(@"--->>> %@", self.datePickerView.date);
    NSString *birthday = [NSDate dateStringWithDate:self.datePickerView.date andFormatString:@"yyyy-MM-dd"];
    UILabel *birthdaylabel = (UILabel *)[self.pageView viewWithTag:10000];
    birthdaylabel.text = birthday;
    
    [self.registerDetailParams setObject:birthday forKey:@"birthday"];
}

@end
