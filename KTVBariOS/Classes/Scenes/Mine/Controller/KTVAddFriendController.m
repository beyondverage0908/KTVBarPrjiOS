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
#import "KTVMainService.h"

@interface KTVAddFriendController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (assign, nonatomic) NSInteger currentPage;
@property (strong, nonatomic) NSMutableArray<KTVUser *> *userList;

@end

@implementation KTVAddFriendController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self setupUI];
    [self loadCommonNearFriend];
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

#pragma mark - 方法重写

- (NSMutableArray<KTVUser *> *)userList {
    if (!_userList) {
        _userList = [NSMutableArray array];
    }
    return _userList;
}

#pragma mark - 网络

/// 获取附近的用户
- (void)loadCommonNearFriend {
    //?latitude=121.48789949&longitude=31.24916171&sex=0&distance=1000&currentPage=1&pageSize=5
    
    KTVAddress *userLocation = [KTVCommon getUserLocation];
    NSString *latitude = @(userLocation.latitude).stringValue;
    NSString *longitude = @(userLocation.longitude).stringValue;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    // latitude : 121.48789949 longitude : 31.24916171
    [params setObject:latitude forKey:@"latitude"];
    [params setObject:longitude forKey:@"longitude"];
    [params setObject:@"100000" forKey:@"distance"];
    [params setObject:@(self.currentPage) forKey:@"currentPage"];
    [params setObject:@"20" forKey:@"pageSize"];
    [KTVMainService getCommonNearUser:params result:^(NSDictionary *result) {
        if ([result[@"code"] isEqualToString:ktvCode]) {
            if (![result[@"data"] count]) {
                [KTVToast toast:TOAST_NEAR_NO_FRIEND];
            } else {
                [self.userList removeAllObjects];
                for (NSDictionary *dic in result[@"data"]) {
                    KTVUser *user = [KTVUser yy_modelWithDictionary:dic];
                    [self.userList addObject:user];
                }
                self.currentPage++;
                [self.tableView reloadData];
            }
        }
    }];
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
    return [self.userList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KTVFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KTVFriendCell"];
    KTVUser *user = self.userList[indexPath.row];
    cell.user = user;
    cell.friendType = FriendAddType;
    cell.addFriendCallback = ^(KTVUser *user) {
        CLog(@"-->> 点击添加好友了");
    };
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
        [self loadCommonNearFriend];
    };
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

#pragma mark - dealloc

- (void)dealloc {
    CLog(@"--->>> dealloc");
}

@end
