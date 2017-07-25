//
//  KTVLoginBaseController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/7/12.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVLoginBaseController.h"

@interface KTVLoginBaseController ()

@end

@implementation KTVLoginBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initbaseUI];
}

- (void)initbaseUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *allBgImage = [[UIImageView alloc] init];
    [self.view addSubview:allBgImage];
    allBgImage.backgroundColor = [UIColor redColor];
    [allBgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.and.left.equalTo(self.view);
    }];
    
    UIView *loginIconBgView = [[UIView alloc] init];
    [self.view addSubview:loginIconBgView];
    [loginIconBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(99);
        make.left.bottom.and.right.equalTo(self.view);
    }];
    
    for (NSInteger i = 0; i < 3; i++) {
        UIButton *otherLoginBtn = [[UIButton alloc] init];
        switch (i) {
            case 0:
                [otherLoginBtn setBackgroundImage:[UIImage imageNamed:@"app_login_wechat"] forState:UIControlStateNormal];
                break;
            case 1:
                [otherLoginBtn setBackgroundImage:[UIImage imageNamed:@"app_login_qq_icon"] forState:UIControlStateNormal];
                break;
            case 2:
                [otherLoginBtn setBackgroundImage:[UIImage imageNamed:@"app_login_weibo"] forState:UIControlStateNormal];
                break;
            default:
                break;
        }
        [loginIconBgView addSubview:otherLoginBtn];
        [otherLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(loginIconBgView);
            switch (i) {
                case 0:
                    make.left.mas_equalTo(loginIconBgView.mas_left).offset(87.5);
                    break;
                case 1:
                    make.centerX.equalTo(loginIconBgView);
                    break;
                case 2:
                    make.right.mas_equalTo(loginIconBgView.mas_right).offset(-87.5);
                    break;
                default:
                    break;
            }
        }];
    }
    
    UILabel *otherLoginLabel = [[UILabel alloc] init];
    [loginIconBgView addSubview:otherLoginLabel];
    otherLoginLabel.text = @"· 其他登陆方式 ·";
    otherLoginLabel.textColor = [UIColor whiteColor];
    otherLoginLabel.backgroundColor = [UIColor clearColor];
    otherLoginLabel.textAlignment = NSTextAlignmentCenter;
    otherLoginLabel.font = [UIFont boldSystemFontOfSize:14];
    [otherLoginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(loginIconBgView);
        make.top.equalTo(loginIconBgView);
    }];
}

@end
