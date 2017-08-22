//
//  KTVLoginInputView.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/7/15.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVLoginInputView.h"
#import "KTVLoginService.h"

@interface KTVLoginInputView ()<UITextFieldDelegate>

@property (strong, nonatomic) UIImageView *logoImgView;
@property (strong, nonatomic) UITextField *inputTextField;
@property (strong, nonatomic) UIButton *verfiyBtn;

@end

@implementation KTVLoginInputView

- (instancetype)init {
    if (self = [super init]) {
        UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_input"]];
        [self addSubview:bgImageView];
        [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(self);
        }];
        
        self.logoImgView = [[UIImageView alloc] init];
        [self addSubview:self.logoImgView];
        
        self.inputTextField = [[UITextField alloc] init];
        [self addSubview:self.inputTextField];
        self.inputTextField.textColor = [UIColor whiteColor];
        self.inputTextField.delegate = self;
        
    }
    return self;
}

- (void)setInputValue:(NSString *)inputValue {
    _inputValue = inputValue;
    if ([KTVUtil isNullString:inputValue]) {
        _inputValue = @"";
    }
    self.inputTextField.text = _inputValue;
}

- (void)setInputType:(KTVInputType)inputType {
    _inputType = inputType;

    // 输入框logo
    switch (inputType) {
        case KTVInputAccountType:
        {
            self.logoImgView.image = [UIImage imageNamed:@"app_login_account"];
            self.inputTextField.placeholder = @"请输入账号";
        }
            break;
        case KTVInputMobileType:
        {
            self.logoImgView.image = [UIImage imageNamed:@"app_login_account"];
            self.inputTextField.placeholder = @"请输入手机号";
        }
            break;
        case KTVInputVerfiyType:
        {
            self.logoImgView.image = [UIImage imageNamed:@"app_login_verfiy"];
            self.inputTextField.placeholder = @"请输入验证码";
        }
            break;
        case KTVInputLockType:
        {
            self.logoImgView.image = [UIImage imageNamed:@"app_password_lock"];
            self.inputTextField.placeholder = @"请输入密码";
        }
            break;
        default:
            break;
    }
    [self.logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(10);
        make.width.mas_offset(23.5f);
        make.height.mas_offset(22.0f);
    }];
    
    // 文本输入框
    self.inputTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.inputTextField.placeholder attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14], NSForegroundColorAttributeName : [UIColor ktvPlaceHolder]}];
    [self.inputTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.logoImgView.mas_right).mas_offset(10);
        make.top.and.bottom.equalTo(self);
        if (inputType == KTVInputMobileType) {
            make.right.mas_equalTo(self.mas_right).mas_offset(-85);
        } else {
            make.right.mas_equalTo(self.mas_right).mas_offset(-10);
        }
    }];
    
    // 更具类型显示发送验证码
    if (inputType == KTVInputMobileType) {
        self.verfiyBtn = [[UIButton alloc] init];
        [self addSubview:self.verfiyBtn];
        [self.verfiyBtn setBackgroundImage:[UIImage imageNamed:@"app_get_verfiy_code_anniu"] forState:UIControlStateNormal];
        [self.verfiyBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.verfiyBtn.titleLabel.font = [UIFont bold14];
        [self.verfiyBtn addTarget:self action:@selector(getVerfiyAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.verfiyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.inputTextField.mas_right).mas_offset(1);
            make.right.equalTo(self).mas_offset(-5);
            make.height.equalTo(self).multipliedBy(.7f);
            make.centerY.equalTo(self);
        }];
    } else {
        [self.verfiyBtn removeFromSuperview];
        self.verfiyBtn = nil;
    }
}

- (void)getVerfiyAction:(UIButton *)btn {
    CLog(@"--->>>获取验证码");
    [self getIdentifyingCode];
    [btn countDownWithSeconds:120];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    NSString *value = textField.text;
    
    if ([KTVUtil isNullString:value]) {
        value = @"";
    }
    if ([self.delegate respondsToSelector:@selector(inputView:inputType:inputValue:)]) {
        [self.delegate inputView:self inputType:self.inputType inputValue:value];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
}

#pragma mark - 获取验证码请求

- (void)getIdentifyingCode {
    NSString *phone = self.inputTextField.text;
    if ([KTVUtil isNullString:phone]) {
        [KTVToast toast:TOAST_MOBILE_CANT_NULL];
        return;
    }
    NSDictionary *param = @{@"phone" : phone};
    [KTVLoginService getIdentifyingCodeParams:param result:^(NSDictionary *result) {
        [KTVToast toast:result[@"detail"]];
    }];
}

@end
