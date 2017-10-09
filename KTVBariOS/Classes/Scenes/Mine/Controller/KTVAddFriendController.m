//
//  KTVAddFriendController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/10/9.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVAddFriendController.h"

#import "KTVFriendCell.h"
#import "KTVThreeRightView.h"
#import "KTVTableHeaderView.h"

@interface KTVAddFriendController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation KTVAddFriendController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self setupUI];
}

- (void)setupUI {
    self.tableView.backgroundColor = [UIColor ktvBG];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self hideNavigationBar:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self hideNavigationBar:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 事件

- (IBAction)navigationBackClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addFriendClick:(UIButton *)sender {
    CLog(@"--->>> 添加好友");
    KTVThreeRightView *rightView = [[KTVThreeRightView alloc] initCustomImageArray:nil
                                                                         textArray:@[@"添加好友",@"扫一扫"]
                                                                         selfFrame:CGRectMake(SCREENW - 160, 50, 145, 176)];
    rightView.selectRowBlock = ^(NSInteger row) {
        CLog(@"-->> 选中了第%@行", @(row));
    };
    [rightView show:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KTVFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KTVFriendCell"];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:nil
                                                                            title:@"推荐好友"
                                                                     headerImgUrl:@"app_change_batch"
                                                                        remarkUrl:nil
                                                                           remark:nil];
    headerView.headerActionBlock = ^(KTVHeaderType headerType) {
        CLog(@"--->>>> 添加好友，换一批");
    };
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

@end
