//
//  KTVConversationController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/12/1.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVConversationController.h"
#import "IQKeyboardManager.h"

@interface KTVConversationController ()

@end

@implementation KTVConversationController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[IQKeyboardManager sharedManager] setEnable:NO];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
