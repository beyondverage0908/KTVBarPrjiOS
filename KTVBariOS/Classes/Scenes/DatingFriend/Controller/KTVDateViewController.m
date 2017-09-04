//
//  KTVDateViewController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/7/31.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVDateViewController.h"

#import "KTVYaoYueUserCell.h"
#import "KTVFilterView.h"
#import "KTVAddYaoYueView.h"

@interface KTVDateViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *locationTapView;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *fufeiYueBtn;

@end

@implementation KTVDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self setupUI];
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
        if ([sign isEqualToString:@"bar"]) {
            CLog(@"-- bar邀约");
        } else if ([sign isEqualToString:@"ktv"]) {
            CLog(@"-- ktv邀约");
        }
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
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KTVYaoYueUserCell *cell = (KTVYaoYueUserCell *)[tableView dequeueReusableCellWithIdentifier:@"KTVYaoYueUserCell"];
    return cell;
}

@end
