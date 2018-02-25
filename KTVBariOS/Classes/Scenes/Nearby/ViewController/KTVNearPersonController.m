//
//  KTVNearPersonController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2018/1/14.
//  Copyright © 2018年 Lin. All rights reserved.
//

#import "KTVNearPersonController.h"
#import "KTVBarKtvDetailController.h"
#import "KTVGuessLikeCell.h"
#import "KTVBeeCell.h"
#import "KTVMainService.h"
#import "KTVNearUser.h"

@interface KTVNearPersonController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *nearWarmerList;

@end

@implementation KTVNearPersonController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor ktvBG];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor ktvBG];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self loadNearWarmerUser];
}

#pragma mark - override getter or setter

- (NSMutableArray *)nearWarmerList {
    if (!_nearWarmerList) {
        _nearWarmerList = [NSMutableArray array];
    }
    return _nearWarmerList;
}

#pragma mark - 网络

/// 获取附近的暖场人
- (void)loadNearWarmerUser {
    KTVAddress *address = [KTVCommon getUserLocation];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@(121.48789949), @"latitude", @(31.24916171), @"longitude", nil];
    [KTVMainService postNearWarmerUser:params result:^(NSDictionary *result) {
        if ([result[@"code"] isEqualToString:ktvCode]) {
            if ([result[@"data"] count]) {
                for (NSDictionary *userDic in result[@"data"]) {
                    KTVNearUser *warmer = [KTVNearUser yy_modelWithDictionary:userDic];
                    [self.nearWarmerList addObject:warmer];
                }
                [self.tableView reloadData];
            } else {
                [KTVToast toast:@"附近暂无暖场人"];
            }
        } else {
            [KTVToast toast:@"暂无法获取附近的人"];
        }
    }];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.nearWarmerList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KTVBeeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KTVBeeCell"];
    if (!cell) {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"KTVBeeCell" owner:self options:nil];
        cell = nibs.count > 0 ? [nibs objectAtIndex:0] : [UITableViewCell new];
    }
    KTVNearUser *nearUser = self.nearWarmerList[indexPath.row];
    cell.nearUser = nearUser;
    @WeakObj(self);
    cell.enterStoreCallback = ^(KTVNearUser *nearUser) {
        [MBProgressHUD showMessage:@"获取门店信息"];
        [KTVMainService getStore:nearUser.storeId result:^(NSDictionary *result) {
            [MBProgressHUD hiddenHUD];
            if ([result[@"code"] isEqualToString:ktvCode]) {
                KTVStore *store = [KTVStore yy_modelWithDictionary:result[@"data"]];
                KTVBarKtvDetailController *vc = (KTVBarKtvDetailController *)[UIViewController storyboardName:@"MainPage" storyboardId:@"KTVBarKtvDetailController"];
                vc.store = store;
                [weakself.navigationController pushViewController:vc animated:YES];
            } else {
                [KTVToast toast:@"无法获取门店的信息"];
            }
        }];
    };
    return cell;
}

@end
