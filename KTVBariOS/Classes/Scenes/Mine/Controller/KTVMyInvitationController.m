//
//  KTVMyInvitationController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2018/1/20.
//  Copyright © 2018年 Lin. All rights reserved.
//

#import "KTVMyInvitationController.h"

#import "KTVInvitatingCell.h"
#import "KTVInvitationAcceptCell.h"

@interface KTVMyInvitationController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;

@property (nonatomic, strong) NSMutableArray *invitatingList; // 邀约中
@property (nonatomic, strong) NSMutableArray *invitatedList; // 已经接受邀约的

@end

@implementation KTVMyInvitationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor ktvBG];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.view.backgroundColor = [UIColor ktvBG];
    
    // default -
    [self loadInvitatingService];
}

#pragma mark - getter or setter

- (NSMutableArray *)invitatedList {
    if (!_invitatedList) {
        _invitatedList = [NSMutableArray array];
    }
    return _invitatedList;
}

- (NSMutableArray *)invitatingList {
    if (!_invitatingList) {
        _invitatingList = [NSMutableArray array];
    }
    return _invitatingList;
}

#pragma mark - 事件

- (IBAction)changeSegment:(id)sender {
    UISegmentedControl *segment = (UISegmentedControl *)sender;
    CLog(@"-->> %@", @(segment.selectedSegmentIndex));
    
    if (segment.selectedSegmentIndex == 0) {
        // 加载邀约的酒吧
        [self loadInvitatingService];
    } else {
        // 加载已经接受邀约的酒吧
        [self loadInvitatedService];
    }
}


- (IBAction)setPartTimeJobAction:(UIButton *)sender {
    CLog(@"-->> 设置我的兼职时间");
}

#pragma mark - 逻辑

- (void)loadInvitatedService {
    for (NSInteger i = 0; i < 10; i++) {
        KTVUser *user = [[KTVUser alloc] init];
        [self.invitatedList addObject:user];
    }
    [self.tableView reloadData];
}

- (void)loadInvitatingService {
    for (NSInteger i = 0; i < 5; i++) {
        KTVUser *user = [[KTVUser alloc] init];
        [self.invitatingList addObject:user];
    }
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.segment.selectedSegmentIndex == 0) {
        return self.invitatingList.count;
    } else {
        return self.invitatedList.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.segment.selectedSegmentIndex == 0) {
        KTVInvitatingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KTVInvitatingCell"];
        KTVUser *user = self.invitatingList[indexPath.row];
        cell.user = user;
        return cell;
    } else {
        KTVInvitationAcceptCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KTVInvitationAcceptCell"];
        KTVUser *user = self.invitatedList[indexPath.row];
        cell.user = user;
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 136;
}

@end
