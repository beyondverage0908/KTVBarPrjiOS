//
//  LoginOrRegisterController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/7/9.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVLoginOrRegisterController.h"

@interface KTVLoginOrRegisterController ()

@end

@implementation KTVLoginOrRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self hideNavigationBar:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self hideNavigationBar:NO];
}

- (IBAction)closeLoginModualAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
