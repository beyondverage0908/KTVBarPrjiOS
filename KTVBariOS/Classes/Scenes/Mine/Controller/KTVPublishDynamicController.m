//
//  KTVPublishDynamicController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/10/19.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVPublishDynamicController.h"
#import "KTVDynamicHeaderCell.h"
#import "KTVDynamicPictureCell.h"
#import "KTVDynamicUserBaseCell.h"
#import "KTVAddMediaCell.h"

#import "KTVTableHeaderView.h"

@interface KTVPublishDynamicController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation KTVPublishDynamicController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor ktvBG];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        KTVDynamicHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVDynamicHeaderCell)];
        return cell;
    } else if (indexPath.section == 1) {
        KTVAddMediaCell *cell = [[KTVAddMediaCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"KTVAddMediaCell"];
        return cell;
    } else if (indexPath.section == 2) {
        KTVAddMediaCell *cell = [[KTVAddMediaCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"KTVAddMediaCell"];
        return cell;
    } else if (indexPath.section == 3) {
        KTVDynamicPictureCell *cell = [tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVDynamicPictureCell)];
        return cell;
    } else if (indexPath.section == 4) {
        KTVDynamicUserBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVDynamicUserBaseCell)];
        return cell;
    }
    return [UITableViewCell new];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 233;
    } else if (indexPath.section == 1) {
        return 90;
    } else if (indexPath.section == 2) {
        return 90;
    } else if (indexPath.section == 3) {
        return 222;
    } else if (indexPath.section == 4) {
        return 628;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:nil title:@"我的相册" remark:nil];
        return headerView;
    } else if (section == 2) {
        KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:nil title:@"我的视频" remark:nil];
        return headerView;
    } else if (section == 3) {
        KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:nil title:@"动态" remark:nil];
        return headerView;
    } else if (section == 4) {
        KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:nil title:@"关于我" remark:nil];
        return headerView;
    }
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1 || section == 2 || section == 3 || section == 4) {
        return 30;
    }
    return 0;
}

@end
