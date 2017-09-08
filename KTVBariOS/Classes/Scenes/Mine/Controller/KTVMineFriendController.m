//
//  KTVMineFriendController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/7.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVMineFriendController.h"

#import "KTVFriendCell.h"
#import "KTVThreeRightView.h"

@interface KTVMineFriendController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation KTVMineFriendController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的好友";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor ktvBG];
    
    [self customRightNavigation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)customRightNavigation {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 52, 18);
    [btn setImage:[UIImage imageNamed:@"app_add_friend"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addFriendAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
}

#pragma mark - 事件

- (void)addFriendAction:(UIButton *)btn {
    CLog(@"-->> 添加好友");
    KTVThreeRightView *rightView = [[KTVThreeRightView alloc] initCustomImageArray:nil textArray:@[@"游戏源码",@"户等场景",@"于选择",@"虽然"] selfFrame:CGRectMake(SCREENW - 160, 50, 145, 176)];
    rightView.selectRowBlock = ^(NSInteger row) {
        CLog(@"-->> 选中了第%@行", @(row));
    };
    [rightView show:YES];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 90;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        CLog(@"-- 查看好友信息");
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 10;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        KTVFriendCell *cell = (KTVFriendCell *)[tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVFriendCell)];
        cell.friendType = FriendChatType;
        return cell;
    }
    return nil;
}

@end
