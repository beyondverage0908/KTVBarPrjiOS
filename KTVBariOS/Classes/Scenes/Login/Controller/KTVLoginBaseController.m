//
//  KTVLoginBaseController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/7/12.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVLoginBaseController.h"
#import "KTVShareSDKManager.h"

@interface KTVLoginBaseController ()

@end

@implementation KTVLoginBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initbaseUI];
    
    [self tapViewKeyboard];
}

- (void)initbaseUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *allBgImage = [[UIImageView alloc] init];
    allBgImage.image = [UIImage imageNamed:@"app_login_all_bg"];
    [self.view addSubview:allBgImage];
    allBgImage.userInteractionEnabled = YES;
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
        otherLoginBtn.tag = 1000 + i;
        [otherLoginBtn addTarget:self action:@selector(thirdLoginAction:) forControlEvents:UIControlEventTouchUpInside];
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

- (void)thirdLoginAction:(UIButton *)btn {
    if (btn.tag == 1000) {
        CLog(@"-->>微信 login");
        [KTVShareSDKManager thirdpartyLogin:KTVShareSDKWeChatLoginType];
    }
    else if (btn.tag == 1001) {
        CLog(@"-->>qq login");
        [KTVShareSDKManager thirdpartyLogin:KTVShareSDKQQLoginType];
    }
    else if (btn.tag == 1002) {
        CLog(@"-->>sina login");
        [KTVShareSDKManager thirdpartyShareTitle:@"今天上海又高温了"
                                            text:@"以新发展理念为指导、以供给侧结构性改革为主线的政策体系，为中国经济“干什么”勾勒了前行路径。今年上半年，中国经济交出GDP增长6．9％的满意答卷。下半年，中国如何延续稳中向好态势"
                                          images:@[@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1501079289&di=dda2b5b4a13497ee5340f2f4d3bba027&src=http://www.zhlzw.com/UploadFiles/Article_UploadFiles/201204/20120412123914329.jpg"]
                                       targetUrl:[NSURL URLWithString:@"http://cpc.people.com.cn/xuexi/n1/2017/0725/c385474-29427420.html"]];
        
    }
}

- (void)tapViewKeyboard {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fulldownKeyboard)];
    [self.view addGestureRecognizer:tap];
}

- (void)fulldownKeyboard {
    [self.view endEditing:YES];
}

@end
