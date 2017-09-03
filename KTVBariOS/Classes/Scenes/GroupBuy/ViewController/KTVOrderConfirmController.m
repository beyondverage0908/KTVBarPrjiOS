//
//  KTVOrderConfirmController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/29.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVOrderConfirmController.h"
#import "KTVSelectedBeautyController.h"

#import "KTVOrderConfirmCell.h"
#import "KTVYuePaoUserCell.h"

#import "KTVTableHeaderView.h"

@interface KTVOrderConfirmController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *continuePayBgView;

@end

@implementation KTVOrderConfirmController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"订单确认";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor ktvBG];
    self.continuePayBgView.backgroundColor = [UIColor ktvBG];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 事件

- (IBAction)continuePayActon:(UIButton *)sender {
    CLog(@"确认订单-下一步");
    
    KTVSelectedBeautyController *vc = (KTVSelectedBeautyController *)[UIViewController storyboardName:@"MainPage" storyboardId:@"KTVSelectedBeautyController"];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 110.0f;
    } else if (indexPath.section == 1) {
        return 90.0f;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 35.0f;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:nil title:@"附近的邀约" headerImgUrl:@"app_change_batch" remarkUrl:@"pay_to_yuepao" remark:nil];
        headerView.headerActionBlock = ^(KTVHeaderType headerType) {
            if (headerType == HeaderType) {
                CLog(@"--->>> 换一批泡");
            } else if (headerType == RemarkType) {
                CLog(@"--->>> 付费约");
            }
        };
        return headerView;
    }
    return nil;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 4;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        KTVOrderConfirmCell *cell = (KTVOrderConfirmCell *)[tableView dequeueReusableCellWithIdentifier:@"KTVOrderConfirmCell"];
        return cell;
    } else if (indexPath.section == 1) {
        KTVYuePaoUserCell *cell = (KTVYuePaoUserCell *)[tableView dequeueReusableCellWithIdentifier:@"KTVYuePaoUserCell"];
        return cell;
    }
    return nil;
}

@end
