//
//  KTVUserInfoController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/4.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVUserInfoController.h"

#import "KTVUserBannerCell.h"
#import "KTVUserPhontosCell.h"
#import "KTVUserSenseCell.h"

#import "KTVTableHeaderView.h"

@interface KTVUserInfoController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation KTVUserInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self setupUi];
}

- (void)setupUi {
    self.tableView.backgroundColor = [UIColor ktvBG];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self clearNavigationbar:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self clearNavigationbar:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 235;
    } else if (indexPath.section == 1) {
        return 280.0f;
    } else if (indexPath.section == 2) {
        return 122.0f;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1 || section == 2) {
        return 29.0f;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:nil title:@"个人相册" remark:nil];
        return headerView;
    } else if (section == 2) {
        KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:nil title:@"关于TA" remark:nil];
        return headerView;
    }
    return nil;
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 1;
    } else if (section == 2) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        KTVUserBannerCell *cell = (KTVUserBannerCell *)[tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVUserBannerCell)];
        return cell;
    } else if (indexPath.section == 1) {
        KTVUserPhontosCell *cell = (KTVUserPhontosCell *)[tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVUserPhontosCell)];
        return cell;
    } else if (indexPath.section == 2) {
        KTVUserSenseCell *cell = (KTVUserSenseCell *)[tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVUserSenseCell)];
        return cell;
    }
    return nil;
}

@end
