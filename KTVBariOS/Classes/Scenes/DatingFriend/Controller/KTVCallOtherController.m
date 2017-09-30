//
//  KTVCallOtherController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/30.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVCallOtherController.h"
#import "KTVPhotoPicker.h"

@interface KTVCallOtherController ()

@end

@implementation KTVCallOtherController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 事件

- (IBAction)shareToBarAction:(UIButton *)sender {
    CLog(@"-->> 分享到酒吧");
}

- (IBAction)shareToWechatAction:(id)sender {
    CLog(@"-->> 分享到微信");
}

- (IBAction)shareToMomentAction:(id)sender {
    CLog(@"-->> 分享到朋友圈");
}

- (IBAction)shareToQQAction:(id)sender {
    CLog(@"-->> 分享到QQ");
    [KTVPhotoPicker pickPhoto];
}
@end
