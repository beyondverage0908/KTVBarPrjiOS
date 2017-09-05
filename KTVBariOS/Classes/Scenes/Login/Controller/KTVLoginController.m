//
//  KTVLoginController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/7/9.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVLoginController.h"
#import "KTVLoginInputView.h"
#import "KTVForgetPasswordController.h"
#import "KTVLoginService.h"

@interface KTVLoginController ()<KTVLoginInputViewDelegate>

@property (strong, nonatomic) UIButton *accountLoginBtn;
@property (strong, nonatomic) UIView *accountLine;
@property (strong, nonatomic) UIButton *mobileLoginBtn;
@property (strong, nonatomic) UIView *mobileLine;

@property (strong, nonatomic) UIButton *loginBtn;
@property (strong, nonatomic) UIButton *fastRegisterBtn;
@property (strong, nonatomic) UIButton *forgetBtn;
@property (strong, nonatomic) UIButton *getVerfiyBtn;

@property (strong, nonatomic) KTVLoginInputView *accountInputView;
@property (strong, nonatomic) KTVLoginInputView *passwordInputView;

@property (strong, nonatomic) NSMutableDictionary *loginAccountParams;
@property (strong, nonatomic) NSMutableDictionary *loginMobileParams;

@end

@implementation KTVLoginController

- (void)setLoginType:(KTVLoginType)loginType {
    _loginType = loginType;
    
    [self removeInvalidateBtn];
    
    if (self.loginType == KTVLoginAccountType) {
        self.fastRegisterBtn = [[UIButton alloc] init];
        [self.view addSubview:self.fastRegisterBtn];
        [self.fastRegisterBtn setTitle:@"<< 快速注册" forState:UIControlStateNormal];
        self.fastRegisterBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        [self.fastRegisterBtn setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        [self.fastRegisterBtn addTarget:self action:@selector(fastRegisterAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.fastRegisterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.loginBtn);
            make.top.equalTo(self.loginBtn.mas_bottom).mas_offset(40);
        }];
        
        self.forgetBtn = [[UIButton alloc] init];
        [self.view addSubview:self.forgetBtn];
        [self.forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
        self.forgetBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        [self.forgetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.forgetBtn addTarget:self action:@selector(forgetAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.loginBtn);
            make.top.equalTo(self.loginBtn.mas_bottom).mas_offset(40);
        }];
        
        // 确定文本输入框类型
        self.accountInputView.inputType = KTVInputAccountType;
        self.accountInputView.inputValue = self.loginAccountParams[@"phone"];
        self.passwordInputView.inputType = KTVInputLockType;
        self.passwordInputView.inputValue = self.loginAccountParams[@"password"];
    } else {
        self.getVerfiyBtn = [[UIButton alloc] init];
        [self.view addSubview:self.getVerfiyBtn];
        [self.getVerfiyBtn setTitle:@"收不到验证码?" forState:UIControlStateNormal];
        self.getVerfiyBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        [self.getVerfiyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.getVerfiyBtn addTarget:self action:@selector(getVerfiyAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.getVerfiyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.loginBtn);
            make.top.equalTo(self.loginBtn.mas_bottom).mas_offset(40);
        }];
        
        // 确定文本输入框类型
        self.accountInputView.inputType = KTVInputMobileType;
        self.accountInputView.inputValue = self.loginMobileParams[@"phone"];
        self.passwordInputView.inputType = KTVInputVerfiyType;
        self.passwordInputView.inputValue = self.loginMobileParams[@"password"];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    
    [self initLoginUI];
    [self initParam];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)initParam {
    self.loginAccountParams = [NSMutableDictionary dictionaryWithCapacity:2];
    self.loginMobileParams = [NSMutableDictionary dictionaryWithCapacity:2];
}

- (void)initLoginUI {
    UIImageView *loginTabBgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_navigation_bar"]];
    [self.view addSubview:loginTabBgView];
    loginTabBgView.userInteractionEnabled = YES;
    [loginTabBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.mas_topLayoutGuideBottom);
    }];
    
    CGFloat oneHalf = SCREENW / 4.0f;
    _accountLoginBtn = [[UIButton alloc] init];
    [loginTabBgView addSubview:_accountLoginBtn];
    [_accountLoginBtn setTitle:@"账号密码登录" forState:UIControlStateNormal];
    _accountLoginBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_accountLoginBtn setTitleColor:[UIColor ktvRed] forState:UIControlStateNormal];
    _accountLoginBtn.tag = 520;
    [_accountLoginBtn addTarget:self action:@selector(accountLoginAction:) forControlEvents:UIControlEventTouchUpInside];
    [_accountLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(loginTabBgView);
        make.centerX.equalTo(loginTabBgView.mas_centerX).offset(-oneHalf);
    }];
    
    _accountLine = [[UIView alloc] init];
    [loginTabBgView addSubview:_accountLine];
    _accountLine.backgroundColor = [UIColor ktvRed];
    [_accountLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(_accountLoginBtn.mas_width).multipliedBy(1.0f);
        make.height.mas_equalTo(3.0f);
        make.centerX.equalTo(_accountLoginBtn.mas_centerX);
        make.bottom.equalTo(loginTabBgView.mas_bottom);
    }];
    
    _mobileLoginBtn = [[UIButton alloc] init];
    [loginTabBgView addSubview:_mobileLoginBtn];
    [_mobileLoginBtn setTitle:@"手机快捷登录" forState:UIControlStateNormal];
    _mobileLoginBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _mobileLoginBtn.tag = 521;
    [_mobileLoginBtn addTarget:self action:@selector(mobileLoginAction:) forControlEvents:UIControlEventTouchUpInside];
    [_mobileLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(loginTabBgView);
        make.centerX.equalTo(loginTabBgView.mas_centerX).offset(oneHalf);
    }];
    
    _mobileLine = [[UIView alloc] init];
    [loginTabBgView addSubview:_mobileLine];
    _mobileLine.backgroundColor = [UIColor ktvRed];
    _mobileLine.hidden = YES;
    [_mobileLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(_mobileLoginBtn.mas_width).multipliedBy(1.0f);
        make.height.mas_equalTo(3.0f);
        make.centerX.equalTo(_mobileLoginBtn.mas_centerX);
        make.bottom.equalTo(loginTabBgView.mas_bottom);
    }];
    
    self.accountInputView = [[KTVLoginInputView alloc] init];
    [self.view addSubview:self.accountInputView];
    self.accountInputView.inputType = KTVInputAccountType;
    self.accountInputView.delegate = self;
    [self.accountInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(30);
        make.right.equalTo(self.view).offset(-30);
        make.height.equalTo(@45);
        make.top.equalTo(loginTabBgView.mas_bottom).offset(67.5);
    }];
    
    self.passwordInputView = [[KTVLoginInputView alloc] init];
    [self.view addSubview:self.passwordInputView];
    self.passwordInputView.inputType = KTVInputVerfiyType;
    self.passwordInputView.delegate = self;
    [self.passwordInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.accountInputView);
        make.height.equalTo(self.accountInputView);
        make.top.equalTo(self.accountInputView.mas_bottom).offset(17.5);
    }];
    
    self.loginBtn = [[UIButton alloc] init];
    [self.view addSubview:self.loginBtn];
    [self.loginBtn setBackgroundImage:[UIImage imageNamed:@"app_anniu_red"] forState:UIControlStateNormal];
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordInputView.mas_bottom).offset(34.0f);
        make.left.and.right.equalTo(self.accountInputView);
    }];
    
    // 默认账号登录
    self.loginType = KTVLoginAccountType;
}

#pragma mark - 触发事件

- (void)accountLoginAction:(UIButton *)btn {
    [self changeColorStatusWithBtn:btn];
    self.loginType = KTVLoginAccountType;
}

- (void)mobileLoginAction:(UIButton *)btn {
    [self changeColorStatusWithBtn:btn];
    self.loginType = KTVLoginMobileType;
}

- (void)changeColorStatusWithBtn:(UIButton *)btn {
    [btn setTitleColor:[UIColor ktvRed] forState:UIControlStateNormal];
    [btn setSelected:YES];
    
    NSInteger tag = btn.tag;
    switch (tag) {
        case 520:
        {
            self.accountLine.hidden = NO;
            [self.mobileLoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.mobileLoginBtn setSelected:NO];
            self.mobileLine.hidden = YES;
        }
            break;
        case 521:
        {
            self.mobileLine.hidden = NO;
            [self.accountLoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.accountLoginBtn setSelected:NO];
            self.accountLine.hidden = YES;
        }
            break;
        default:
            break;
    }
}

- (void)loginAction:(UIButton *)btn {
    NSLog(@"--->>>loginAction");
    [self.view endEditing:YES];
    
    [self accountLoginService];
}

- (void)fastRegisterAction:(UIButton *)btn {
    CLog(@"--->>>fastRegisterAction");
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)forgetAction:(UIButton *)btn {
    KTVForgetPasswordController *forgetVC = (KTVForgetPasswordController *)[UIViewController storyboardName:@"Login" storyboardId:@"SB_KTVForgetPasswordController"];
    [self.navigationController pushViewController:forgetVC animated:YES];
}

- (void)getVerfiyAction:(UIButton *)btn {
    NSLog(@"--->>>getVerfiyAction");
}

#pragma mark ---

- (void)removeInvalidateBtn {
    [self.fastRegisterBtn removeFromSuperview];
    [self.forgetBtn removeFromSuperview];
    [self.getVerfiyBtn removeFromSuperview];
}

#pragma mark - KTVLoginInputViewDelegate

- (void)inputView:(KTVLoginInputView *)inputView inputType:(KTVInputType)type inputValue:(NSString *)inputValue {
    switch (type) {
        case KTVInputAccountType:
        {
            CLog(@"---1>>>%@", inputValue);
            if (self.loginType == KTVLoginAccountType) {
                [self.loginAccountParams setObject:inputValue forKey:@"phone"];
            }
        }
            break;
        case KTVInputVerfiyType:
        {
            CLog(@"---2>>>%@", inputValue);
            if (self.loginType == KTVLoginMobileType) {
                [self.loginMobileParams setObject:inputValue forKey:@"password"];
            }
        }
            break;
        case KTVInputLockType:
        {
            CLog(@"---3>>>%@", inputValue);
            if (self.loginType == KTVLoginAccountType) {
                [self.loginAccountParams setObject:inputValue forKey:@"password"];
            }
        }
            break;
        case KTVInputMobileType:
        {
            CLog(@"---4>>>%@", inputValue);
            if (self.loginType == KTVLoginMobileType) {
                [self.loginMobileParams setObject:inputValue forKey:@"phone"];
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark - 网络请求

- (void)accountLoginService {
    NSDictionary *params = nil;
    if (self.loginType == KTVLoginAccountType) {
        params = self.loginAccountParams;
    } else {
        params = self.loginMobileParams;
    }
    [KTVLoginService getCommonLoginParams:params result:^(NSDictionary *result) {
        if ([result[@"msg"] isEqualToString:ktvSuccess]) {
            NSString *ktvToken = result[@"data"][@"token"];
            // 保存token
            [KTVUtil setObject:ktvToken forKey:@"ktvToken"];
            [KTVCommon setUserInfoKey:@"phone" infoValue:self.loginAccountParams[@"phone"]];
            
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            [KTVToast toast:result[@"detail"]];
        }
    }];
}

@end
