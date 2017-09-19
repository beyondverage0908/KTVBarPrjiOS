//
//  KTVForgetPasswordController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/7/19.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVForgetPasswordController.h"
#import "KTVLoginService.h"

@interface KTVForgetPasswordController ()

@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UITextField *veryfitTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIButton *verfitBtn;

@property (strong, nonatomic) NSMutableDictionary *forgetParams;

@end

@implementation KTVForgetPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找回密码";
    
    self.forgetParams = [NSMutableDictionary dictionaryWithCapacity:3];
    [self setupUI];
}

- (void)setupUI {
    NSDictionary *attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:14], NSForegroundColorAttributeName : [UIColor ktvPlaceHolder]};
    
    self.accountTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.accountTF.placeholder attributes:attrs];
    self.veryfitTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.veryfitTF.placeholder attributes:attrs];
    self.passwordTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.passwordTF.placeholder attributes:attrs];
    
    self.accountTF.font = [UIFont bold14];
    self.veryfitTF.font = [UIFont bold14];
    self.passwordTF.font = [UIFont bold14];
}

- (IBAction)getVerfitAction:(UIButton *)sender {
    [sender countDownWithSeconds:60];
    [self getIdentifyingCode];
}

- (IBAction)nextStepAction:(UIButton *)sender {
    CLog(@"next step");
    
    NSString *phone = self.accountTF.text;
    NSString *verfiyCode = self.veryfitTF.text;
    NSString *password = self.passwordTF.text;
    
    if (phone) {
        [self.forgetParams setObject:phone forKey:@"phone"];
    }
    if (verfiyCode) {
        [self.forgetParams setObject:verfiyCode forKey:@"verfiyCode"];
    }
    if (password) {
        [self.forgetParams setObject:password forKey:@"password"];
        [self.forgetParams setObject:password forKey:@"confirmPassword"];
    }
    
    [KTVLoginService postChangePassword:self.forgetParams result:^(NSDictionary *result) {
        if ([result[@"code"] isEqualToString:ktvCode]) {
            [KTVToast toast:TOAST_MODIFIED_SUCCESS];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [KTVToast toast:result[@"detail"]];
        }
    }];
}

// 获取验证码
- (void)getIdentifyingCode {
    NSString *phone = self.accountTF.text;
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
