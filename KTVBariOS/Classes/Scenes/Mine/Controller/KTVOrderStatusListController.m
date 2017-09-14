//
//  KTVOrderStatusListController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/11.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVOrderStatusListController.h"
#import "KTVStoreUseOrderController.h"

#import "KTVOrderStatusCell.h"
#import "KTVFilterView.h"


@interface KTVOrderStatusListController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation KTVOrderStatusListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor ktvBG];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    KTVFilterView *filterView = [[KTVFilterView alloc] initWithFilter:@[@"全部", @"待付款", @"待使用", @"待评价"]];
    return filterView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 184.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    KTVStoreUseOrderController *vc = (KTVStoreUseOrderController *)[UIViewController storyboardName:@"MePage" storyboardId:@"KTVStoreUseOrderController"];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -  UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KTVOrderStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVOrderStatusCell)
                                                            forIndexPath:indexPath];
    return cell;
}

@end
