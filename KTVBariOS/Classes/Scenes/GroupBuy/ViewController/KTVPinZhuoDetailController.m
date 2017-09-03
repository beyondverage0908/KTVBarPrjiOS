//
//  KTVPinZhuoDetailController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/3.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVPinZhuoDetailController.h"

#import "KTVPZUserHeaderCell.h"
#import "KTVPZStoreCell.h"

@interface KTVPinZhuoDetailController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation KTVPinZhuoDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"拼桌详情";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor ktvBG];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 事件

- (IBAction)gotoEnterAction:(UIButton *)sender {
    CLog(@"-- 去报名");
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 100.0f;
    } else if (indexPath.section == 1) {
        return 163.0f;
    }
    return 0;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        KTVPZUserHeaderCell *cell = (KTVPZUserHeaderCell *)[tableView dequeueReusableCellWithIdentifier:@"KTVPZUserHeaderCell"];
        return cell;
    } else if (indexPath.section == 1) {
        KTVPZStoreCell *cell = (KTVPZStoreCell *)[tableView dequeueReusableCellWithIdentifier:@"KTVPZStoreCell"];
        return cell;
    }
    return nil;
}


@end
