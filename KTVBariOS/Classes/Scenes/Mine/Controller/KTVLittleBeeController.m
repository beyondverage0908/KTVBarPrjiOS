//
//  KTVLittleBeeController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/10/31.
//  Copyright © 2017年 Lin. All rights reserved.
//
//  小蜜蜂用户详情

#import "KTVLittleBeeController.h"

#import "KTVBeeHeaderCell.h"
#import "KTVBeeInfoCell.h"
#import "KTVBeeDescriptionCell.h"

@interface KTVLittleBeeController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation KTVLittleBeeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"小蜜蜂详情";
    
    self.tableView.backgroundColor = [UIColor ktvBG];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 287.0f;
    } else if (indexPath.section == 1) {
        return 130.0f;
    } else if (indexPath.section == 2) {
        return 112.0f;
    }
    return 0;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        KTVBeeHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVBeeHeaderCell)];
        cell.user = self.user;
        return cell;
    } else if (indexPath.section == 1) {
        KTVBeeInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVBeeInfoCell)];
        cell.user = self.user;
        return cell;
    } else if (indexPath.section == 2) {
        KTVBeeDescriptionCell *cell = [tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVBeeDescriptionCell)];
        cell.user = self.user;
        return cell;
    }
    return [UITableViewCell new];
}

@end
