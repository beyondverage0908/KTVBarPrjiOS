//
//  KTVForgetPasswordController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/7/19.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVForgetPasswordController.h"

@interface KTVForgetPasswordController ()

@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UITextField *veryfitTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIButton *verfitBtn;

@end

@implementation KTVForgetPasswordController

- (void)viewDidLoad {
    self.title = @"找回密码";
    [super viewDidLoad];
}

- (IBAction)getVerfitAction:(UIButton *)sender {
    [sender countDownWithSeconds:60];
}

- (IBAction)nextStepAction:(UIButton *)sender {
    CLog(@"next step");
}

@end
