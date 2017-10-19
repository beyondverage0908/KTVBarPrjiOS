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

#import "KTVMainService.h"

#import "KTVOrder.h"

@interface KTVOrderStatusListController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *allOrderList;   // 全部
@property (strong, nonatomic) NSMutableArray *allWaitPayList; // 待付款
@property (strong, nonatomic) NSMutableArray *allWaitUseList;   // 待使用
@property (strong, nonatomic) NSMutableArray *allWaitCommentList; // 待评价

@property (assign, nonatomic) NSInteger currentOrderStatus;

@end

@implementation KTVOrderStatusListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor ktvBG];
    
    [self initData];
    
    // 默认获取全部
    self.currentOrderStatus = 99;
    [self loadOrderByOrderStatus:self.currentOrderStatus];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 初始化

- (void)initData {
    self.allOrderList = [NSMutableArray array];
    self.allWaitPayList = [NSMutableArray array];
    self.allWaitUseList = [NSMutableArray array];
    self.allWaitCommentList = [NSMutableArray array];
}

#pragma mark - 网络

- (void)loadOrderByOrderStatus:(NSInteger)orderStatus {
    switch (self.currentOrderStatus) {
        case 99:
        {
            if ([self.allOrderList count]) {
                [self.tableView reloadData];
                return;
            }
        }
            break;
        case -1:
        {
            if ([self.allWaitPayList count]) {
                [self.tableView reloadData];
                return;
            }
        }
            break;
        case 2:
        {
            if ([self.allWaitUseList count]) {
                [self.tableView reloadData];
                return;
            }
        }
            break;
        case 5:
        {
            if ([self.allWaitCommentList count]) {
                [self.tableView reloadData];
                return;
            }
        }
            break;
        default:
            break;
    }
    NSDictionary *params = @{@"username" : [KTVCommon userInfo].phone,
                             @"orderStatus" : [NSNumber numberWithInteger:orderStatus]};
    [KTVMainService postSearchOrder:params result:^(NSDictionary *result) {
        if (![result[@"code"] isEqualToString:ktvCode]) {
            [KTVToast toast:TOAST_GET_ORDER_FAIL];
            return;
        }
        switch (self.currentOrderStatus) {
            case 99:
            {
                for (NSDictionary *dic in result[@"data"]) {
                    KTVOrder *order = [KTVOrder yy_modelWithDictionary:dic];
                    [self.allOrderList addObject:order];
                }
                if (![self.allOrderList count]) {
                    [KTVToast toast:TOAST_GET_ORDER_EMPTY];
                }
            }
                break;
            case -1:
            {
                for (NSDictionary *dic in result[@"data"]) {
                    KTVOrder *order = [KTVOrder yy_modelWithDictionary:dic];
                    [self.allWaitPayList addObject:order];
                }
                if (![self.allWaitPayList count]) {
                    [KTVToast toast:TOAST_GET_ORDER_EMPTY];
                }
            }
                break;
            case 2:
            {
                for (NSDictionary *dic in result[@"data"]) {
                    KTVOrder *order = [KTVOrder yy_modelWithDictionary:dic];
                    [self.allWaitUseList addObject:order];
                }
                if (![self.allWaitUseList count]) {
                    [KTVToast toast:TOAST_GET_ORDER_EMPTY];
                }
            }
                break;
            case 5:
            {
                for (NSDictionary *dic in result[@"data"]) {
                    KTVOrder *order = [KTVOrder yy_modelWithDictionary:dic];
                    [self.allWaitCommentList addObject:order];
                }
                if (![self.allWaitCommentList count]) {
                    [KTVToast toast:TOAST_GET_ORDER_EMPTY];
                }
            }
                break;
            default:
                break;
        }
        [self.tableView reloadData];
    }];
}

#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSArray *dataSource = @[@"全部", @"待付款", @"待使用", @"待评价"];
    KTVFilterView *filterView = [[KTVFilterView alloc] initWithFilter:dataSource];
    filterView.filterCallback = ^(NSString *filterKey) {
        NSInteger idx = [dataSource indexOfObject:filterKey];
        if (idx == 0) {
            self.currentOrderStatus = 99;
        } else if (idx == 1) {
            self.currentOrderStatus = -1;
        } else if (idx == 2) {
            self.currentOrderStatus = 2;
        } else if (idx == 3) {
            self.currentOrderStatus = 5;
        }
        [self loadOrderByOrderStatus:self.currentOrderStatus];
    };
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
    NSInteger row = 0;
    switch (self.currentOrderStatus) {
        case 99:
        {
            row = [self.allOrderList count];
        }
            break;
        case -1:
        {
            row = [self.allWaitPayList count];
        }
            break;
        case 2:
        {
            row = [self.allWaitUseList count];
        }
            break;
        case 5:
        {
            row = [self.allWaitCommentList count];
        }
            break;
        default:
            break;
    }
    return row;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KTVOrderStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVOrderStatusCell)
                                                               forIndexPath:indexPath];
    switch (self.currentOrderStatus) {
        case 99:
        {
            KTVOrder *order = self.allOrderList[indexPath.row];
            cell.order = order;
        }
            break;
        case -1:
        {
            KTVOrder *order = self.allWaitPayList[indexPath.row];
            cell.order = order;
        }
            break;
        case 2:
        {
            KTVOrder *order = self.allWaitUseList[indexPath.row];
            cell.order = order;
        }
            break;
        case 5:
        {
            KTVOrder *order = self.allWaitCommentList[indexPath.row];
            cell.order = order;
        }
            break;
        default:
            break;
    }
    return cell;
}

@end
