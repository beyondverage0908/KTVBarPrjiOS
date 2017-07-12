//
//  KTVLaunchController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/6/28.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVLaunchController.h"

@interface KTVLaunchController ()

@end

@implementation KTVLaunchController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
}

@end
