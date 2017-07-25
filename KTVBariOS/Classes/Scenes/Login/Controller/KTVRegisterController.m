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

@interface KTVRegisterController ()<UIScrollViewDelegate>

@property (strong, nonatomic) UIImageView *tabBgView;
@property (strong, nonatomic) NSArray *titleArray;
@property (strong, nonatomic) UIScrollView *pageView;

@end

@implementation KTVRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    
    [self initRegisterUI];
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
        [btn addTarget:self action:@selector(registerTabAction:) forControlEvents:UIControlEventTouchUpInside];
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
    self.pageView.alwaysBounceHorizontal = YES;
    self.pageView.showsHorizontalScrollIndicator = NO;
    self.pageView.scrollEnabled = NO;
    self.pageView.delegate = self;
    [self.pageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tabBgView.mas_bottom);
        make.left.and.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-99);
    }];
    
    UIView *containerView = [[UIView alloc] init];
    [self.pageView addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.pageView);
    }];
    
    //  第一个
    UIView *firstPageView = [[UIView alloc] init];
    [containerView addSubview:firstPageView];
    firstPageView.backgroundColor = [UIColor cyanColor];
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
    secondPageView.backgroundColor = [UIColor cyanColor];
    [secondPageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(containerView);
        make.size.equalTo(firstPageView);
        make.left.equalTo(firstPageView.mas_right);
    }];
    [self generateSecondPage:secondPageView];
    
    // 第三个
    UIView *thirdPageView = [[UIView alloc] init];
    [containerView addSubview:thirdPageView];
    thirdPageView.backgroundColor = [UIColor grayColor];
    [thirdPageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(containerView);
        make.size.equalTo(firstPageView);
        make.left.equalTo(secondPageView.mas_right);
        make.right.equalTo(containerView);
    }];
    [self generateThirdPage:thirdPageView];
}

- (void)generateFirstPage:(UIView *)superView {
    UIImageView *firstBgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_input"]];
    [superView addSubview:firstBgView];
    [firstBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView).offset(67.5);
        make.left.equalTo(superView).offset(30);
        make.right.equalTo(superView).offset(-30);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [firstBgView addSubview:titleLabel];
    titleLabel.text = @"生日";
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.textColor = [UIColor whiteColor];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(firstBgView).offset(10);
        make.top.and.bottom.equalTo(firstBgView);
    }];
    
    UILabel *borthdayLabel = [[UILabel alloc] init];
    [firstBgView addSubview:borthdayLabel];
    borthdayLabel.text = @"1990-08-21";
    borthdayLabel.font = [UIFont boldSystemFontOfSize:17];
    borthdayLabel.textColor = [UIColor whiteColor];
    [borthdayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel.mas_right).mas_offset(35);
        make.top.and.bottom.equalTo(firstBgView);
    }];
    
    UIImageView *arrowRightImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_arrow_right"]];
    [firstBgView addSubview:arrowRightImgView];
    [arrowRightImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(firstBgView);
        make.right.equalTo(firstBgView).offset(-13.5);
    }];
    
    UIImageView *secondBgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_input"]];
    [superView addSubview:secondBgView];
    [secondBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstBgView.mas_bottom).offset(17.5);
        make.left.equalTo(superView).offset(30);
        make.right.equalTo(superView).offset(-30);
    }];
    
    UILabel *stitleLabel = [[UILabel alloc] init];
    [secondBgView addSubview:stitleLabel];
    stitleLabel.text = @"性别";
    stitleLabel.font = [UIFont boldSystemFontOfSize:17];
    stitleLabel.textColor = [UIColor whiteColor];
    [stitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(secondBgView).offset(10);
        make.top.and.bottom.equalTo(secondBgView);
    }];
    
    UILabel *genderLabel = [[UILabel alloc] init];
    [secondBgView addSubview:genderLabel];
    genderLabel.text = @"男";
    genderLabel.font = [UIFont boldSystemFontOfSize:17];
    genderLabel.textColor = [UIColor whiteColor];
    [genderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(stitleLabel.mas_right).mas_offset(35);
        make.top.and.bottom.equalTo(secondBgView);
    }];
    
    UILabel *declareLabel = [[UILabel alloc] init];
    [superView addSubview:declareLabel];
    declareLabel.text = @"注册成功后，性别不可更改";
    declareLabel.font = [UIFont boldSystemFontOfSize:14];
    declareLabel.textColor = [UIColor whiteColor];
    [declareLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(superView);
        make.top.equalTo(secondBgView.mas_bottom).mas_offset(15);
    }];

    UIButton *nextBtn = [[UIButton alloc] init];
    [superView addSubview:nextBtn];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn setBackgroundImage:[UIImage imageNamed:@"app_anniu_red"] forState:UIControlStateNormal];
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
    
    UIImageView *selectedImageView = [[UIImageView alloc] init];
    [superView addSubview:selectedImageView];
    selectedImageView.image = [UIImage imageNamed:@"app_gou_red"];
    [selectedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(protocolLabel.mas_right).offset(5);
        make.centerY.equalTo(protocolLabel);
    }];
}

- (void)generateSecondPage:(UIView *)superView {
    KTVLoginInputView *mobileInputView = [[KTVLoginInputView alloc] init];
    [superView addSubview:mobileInputView];
    mobileInputView.inputType = KTVInputMobileType;
    [mobileInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView.mas_top).mas_offset(67.5);
        make.left.equalTo(superView).offset(30);
        make.right.equalTo(superView).offset(-30);
    }];
    
    KTVLoginInputView *psdInputView = [[KTVLoginInputView alloc] init];
    [superView addSubview:psdInputView];
    psdInputView.inputType = KTVInputLockType;
    [psdInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mobileInputView.mas_bottom).mas_offset(22.5);
        make.left.equalTo(superView).offset(30);
        make.right.equalTo(superView).offset(-30);
    }];
    
    UIButton *secondNextBtn = [[UIButton alloc] init];
    [superView addSubview:secondNextBtn];
    [secondNextBtn setBackgroundImage:[UIImage imageNamed:@"app_anniu_red"] forState:UIControlStateNormal];
    [secondNextBtn setTitle:@"下一步" forState:UIControlStateNormal];
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
    
    UIImageView *selectedImageView = [[UIImageView alloc] init];
    [superView addSubview:selectedImageView];
    selectedImageView.image = [UIImage imageNamed:@"app_gou_red"];
    [selectedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
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

- (void)changeButtonStatusBy:(NSInteger)tag {
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

#pragma mark - UIScrollViewDelegate



@end
