//
//  KTVBindPhoneController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2018/5/12.
//  Copyright © 2018年 Lin. All rights reserved.
//

#import "KTVBindPhoneController.h"
#import "KTVLoginService.h"

@interface KTVBindPhoneController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *verfiyCodeField;

@end

@implementation KTVBindPhoneController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)getVerfiyCodeAction:(id)sender {
    CLog(@"获取验证码");
    
    NSString *phone = self.phoneField.text;
    if (!phone || phone.length < 11) {
        [KTVToast toast:@"请填写手机号码"];
        return;
    }
    
    if ([sender isKindOfClass:[UIButton class]]) {
        UIButton *verfiyBtn = (UIButton *)sender;
        [verfiyBtn countDownWithSeconds:60];
    }
    
    NSDictionary *param = @{@"phone" : phone};
    [KTVLoginService getIdentifyingCodeParams:param result:^(NSDictionary *result) {
        if ([result[@"code"] isEqualToString:ktvCode]) {
            [KTVToast toast:@"验证码发送，请稍等"];
        } else {
            [KTVToast toast:@"无法发送验证码，请联系管理员"];
        }
        
    }];
}
- (IBAction)nextAction:(id)sender {
    if (!self.gender || [self.gender isEqualToString:@"2"]) {
        self.gender = @"1";
    }
    NSString *phone = @"";
    if (self.phoneField.text) {
        phone = self.phoneField.text;
    }
    NSDictionary *param = @{@"type": @(self.type).stringValue,
                            @"thirdUid" : self.uid,
                            @"phone" : phone,
                            @"sex" : self.gender,
                            @"validateCode" : self.verfiyCodeField.text};
    [KTVLoginService postUpdateThird:param result:^(NSDictionary *result) {
        NSLog(@"%@", result);
        if ([result[@"code"] isEqualToString:ktvCode]) {
            [KTVToast toast:TOAST_LOGIN_SUCCESS];
            NSString *ktvToken = result[@"data"][@"token"];
            // 保存token
            [KTVUtil setObject:ktvToken forKey:@"ktvToken"];
            [KTVCommon setUserInfoKey:@"phone" infoValue:phone];
            
            [self dismissCurrentController];
        } else if ([result[@"code"] integerValue] == 10003) {
            [KTVToast toast:@"验证码错误"];
        } else {
            [KTVToast toast:@"无法绑定"];
        }
    }];
}

- (void)dismissCurrentController {
    [self dismissViewControllerAnimated:YES completion:^{
        [KtvNotiCenter postNotificationName:KNotLoginSuccess object:self];
    }];
}

@end
