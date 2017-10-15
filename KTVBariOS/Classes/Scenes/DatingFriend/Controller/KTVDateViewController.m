//
//  KTVDateViewController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/7/31.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVDateViewController.h"
#import "KTVPublishDateController.h"
#import "KTVPinZhuoDetailController.h"

#import "KTVYaoYueUserCell.h"
#import "KTVFilterView.h"
#import "KTVAddYaoYueView.h"

#import "KTVMainService.h"

#import "KTVInvitedUser.h"

@interface KTVDateViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *locationTapView;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *fufeiYueBtn;

@property (strong, nonatomic) NSMutableArray<KTVInvitedUser *> *inviteUserList;

@end

@implementation KTVDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self setupUI];
    [self initData];
    [self loadNearInviteData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self hideNavigationBar:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self hideNavigationBar:NO];
}

- (void)setupUI {
    self.tableView.backgroundColor = [UIColor ktvBG];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLocationViewAction:)];
    [self.locationTapView addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 初始化

- (void)initData {
    self.inviteUserList = [NSMutableArray array];
}

#pragma mark - 网络

- (void)loadNearInviteData {
    KTVAddress *address = [KTVCommon getUserLocation];
    NSString *lat = @(address.latitude).stringValue;
    NSString *lon = @(address.longitude).stringValue;
    NSDictionary *params = @{@"latitude" : lat ? lat : @"121.48789949",
                             @"longitude" : lon ? lon : @"31.24916171",
                             @"distance" : @"1000000000",
                             @"storeType" : @"0"};
    [KTVMainService postNearInvite:params result:^(NSDictionary *result) {
        if (![result[@"code"] isEqualToString:ktvCode]) {
            [KTVToast toast:TOAST_GET_DATA_FAIL];
            return;
        }
        
        for (NSDictionary *dic in result[@"data"]) {
            KTVInvitedUser *inviteUser = [KTVInvitedUser yy_modelWithDictionary:dic];
            [self.inviteUserList addObject:inviteUser];
        }
        [self.tableView reloadData];
    }];
}

#pragma mark - 事件

- (IBAction)fufeiYueAction:(UIButton *)sender {
    CLog(@"-- 邀约大厅 付费约");
}

- (IBAction)addYueAction:(UIButton *)sender {
    CLog(@"-- 添加邀约");
    KTVAddYaoYueView *yueView = [[[NSBundle mainBundle] loadNibNamed:@"KTVAddYaoYueView" owner:self options:nil] lastObject];
    yueView.frame = [[UIScreen mainScreen] bounds];
    [[UIApplication sharedApplication].keyWindow addSubview:yueView];
    yueView.yaoYueCallback = ^(NSString *sign) {
        NSInteger type = 0;
        if ([sign isEqualToString:@"bar"]) {
            CLog(@"-- bar邀约");
            type = 0;
        } else if ([sign isEqualToString:@"ktv"]) {
            CLog(@"-- ktv邀约");
            type = 1;
        }
        KTVPublishDateController *vc = (KTVPublishDateController *)[UIViewController storyboardName:@"DatingFriend" storyboardId:@"KTVPublishDateController"];
        [self.navigationController pushViewController:vc animated:YES];
    };
}

- (void)tapLocationViewAction:(UIButton *)btn {
    CLog(@"-- 邀约 点击地理位置");
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    KTVFilterView *filterView = [[KTVFilterView alloc] initWithFilter:@[@"酒吧", @"附近", @"仅看女", @"筛选"]];
    return filterView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 85.0f;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.inviteUserList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KTVYaoYueUserCell *cell = (KTVYaoYueUserCell *)[tableView dequeueReusableCellWithIdentifier:@"KTVYaoYueUserCell"];
    KTVInvitedUser *inviteUser = self.inviteUserList[indexPath.row];
    cell.inviteUser = inviteUser;
    
    cell.yueTaCallback = ^(KTVInvitedUser *inviteUser) {
        CLog(@"-->>>约他");
    };
    cell.pinzhuoCallback = ^(KTVInvitedUser *inviteUser) {
        KTVPinZhuoDetailController *vc = (KTVPinZhuoDetailController *)[UIViewController storyboardName:@"MainPage" storyboardId:@"KTVPinZhuoDetailController"];
        vc.phone = inviteUser.user.phone;
        [self.navigationController pushViewController:vc animated:YES];
    };
    return cell;
}

@end
