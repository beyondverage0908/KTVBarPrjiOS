//
//  KTVPackageController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/14.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVPackageController.h"
#import "KTVBarKtvDetailHeaderCell.h"
#import "KTVIntroduceCell.h"
#import "KTVPackageDetailCell.h"
#import "KTVYuePaoUserCell.h"

#import "KTVTableHeaderView.h"

@interface KTVPackageController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation KTVPackageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self hideNavigationBar:NO];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 225;
    } else if (indexPath.section == 1) {
        return 70;
    } else if (indexPath.section == 2) {
        return 50;
    } else if (indexPath.section == 3) {
        return 90;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:@"app_order_ding" title:@"座位信息" remark:nil];
        return headerView;
    } else if (section == 2) {
        KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:nil title:@"套餐详情" remark:nil];
        return headerView;
    } else if (section == 3) {
        KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:nil title:@"邀请她暖场" remark:nil];
        return headerView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1 || section == 2 || section == 3) {
        return 28;
    }
    return 0;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 1;
    } else if (section == 2) {
        return 3;
    } else if (section == 3) {
        return 3;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        KTVBarKtvDetailHeaderCell *cell = (KTVBarKtvDetailHeaderCell *)[tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVBarKtvDetailHeaderCell)];
        return cell;
    } else if (indexPath.section == 1) {
        KTVIntroduceCell *cell = (KTVIntroduceCell *)[tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVIntroduceCell)];
        return cell;
    } else if (indexPath.section == 2) {
        KTVPackageDetailCell *cell = (KTVPackageDetailCell *)[tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVPackageDetailCell)];
        return cell;
    } else if (indexPath.section == 3) {
        KTVYuePaoUserCell *cell = (KTVYuePaoUserCell *)[tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVYuePaoUserCell)];
        return cell;
    }
    return nil;
}


@end
