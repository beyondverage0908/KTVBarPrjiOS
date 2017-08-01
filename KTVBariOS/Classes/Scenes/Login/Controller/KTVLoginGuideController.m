//
//  LoginOrRegisterController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/7/9.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVLoginGuideController.h"
#import "KTVLoginController.h"
#import "KTVRegisterController.h"

@interface KTVLoginGuideController ()

@end

@implementation KTVLoginGuideController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initGuideUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self hideNavigationBar:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self hideNavigationBar:NO];
}

- (void)initGuideUI {
    UIImageView *logoImageView = [[UIImageView alloc] init];
    [self.view addSubview:logoImageView];
    logoImageView.image = [UIImage imageNamed:@"app_logo"];
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(95.0f);
    }];
    
    UIButton *loginBtn = [[UIButton alloc] init];
    [self.view addSubview:loginBtn];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"app_anniu_red"] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(logoImageView.mas_bottom).offset(30.0f);
    }];
    
    UIButton *registerBtn = [[UIButton alloc] init];
    [self.view addSubview:registerBtn];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn setBackgroundImage:[UIImage imageNamed:@"app_anniu_red"] forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(loginBtn.mas_bottom).offset(22.5f);
    }];
}

- (void)loginAction:(UIButton *)btn {
    KTVLoginController *loginVC = [[KTVLoginController alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (void)registerAction:(UIButton *)btn {
    KTVRegisterController *registerVC = [[KTVRegisterController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

@end
