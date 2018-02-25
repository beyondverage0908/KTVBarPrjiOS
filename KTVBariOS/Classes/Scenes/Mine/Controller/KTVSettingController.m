//
//  KTVSettingController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/10/23.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVSettingController.h"
#import "KTVAppVersionCell.h"

#import "KTVMainService.h"

@interface KTVSettingController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation KTVSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor ktvBG];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 事件

- (IBAction)exitAction:(id)sender {
    CLog(@"-->>>退出");
    [MBProgressHUD showMessage:@"注销中..."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self logoutAccount];
    });
}

#pragma mark - 网络

- (void)logoutAccount {
    NSString *token = [KTVCommon ktvToken];
    if (!token) {
        [KTVToast toast:TOAST_OUT_OF_LOGIN];
        return;
    }
    NSDictionary *params = @{@"token" : token};
    [KTVMainService postAppExit:params result:^(NSDictionary *result) {
        [MBProgressHUD hiddenHUD];
        if ([result[@"code"] isEqualToString:ktvCode]) {
            [KTVToast toast:TOAST_EXIT_SUCCESS];
            [KTVCommon resignUserInfo];
            [self.navigationController popViewControllerAnimated:YES];
            [KtvNotiCenter postNotificationName:KNotLoginOutOf object:nil];
        } else {
            [KTVToast toast:result[@"detail"]];
        }
    }];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 50;
    }
    return 0;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        KTVAppVersionCell *cell = (KTVAppVersionCell *)[tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVAppVersionCell)];
        return cell;
    }
    return nil;
}

@end
