//
//  KTVMainController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/7/13.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVMainController.h"
#import "KTVLoginGuideController.h"

@interface KTVMainController ()

@end

@implementation KTVMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)loginAction:(UIButton *)sender {
    KTVLoginGuideController *guideVC = [[KTVLoginGuideController alloc] init];
    guideVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:guideVC animated:YES];
}

@end
