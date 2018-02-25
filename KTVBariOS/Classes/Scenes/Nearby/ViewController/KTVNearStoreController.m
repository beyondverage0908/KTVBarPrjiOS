//
//  KTVNearStoreController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2018/1/14.
//  Copyright © 2018年 Lin. All rights reserved.
//

#import "KTVNearStoreController.h"
#import "KTVBarKtvDetailController.h"
#import "KTVGuessLikeCell.h"
#import "KTVMainService.h"

@interface KTVNearStoreController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;

@property (strong, nonatomic) NSMutableArray *barStoreList;
@property (strong, nonatomic) NSMutableArray *ktvStoreList;

@end

@implementation KTVNearStoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor ktvBG];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // by default
    [self loadNearBarStore];
}

#pragma mark - override getter

- (NSMutableArray *)barStoreList {
    if (!_barStoreList) {
        _barStoreList = [NSMutableArray array];
    }
    return _barStoreList;
}

- (NSMutableArray *)ktvStoreList {
    if (!_ktvStoreList) {
        _ktvStoreList = [NSMutableArray array];
    }
    return _ktvStoreList;
}

#pragma mark - 网络

- (void)loadNearBarStore {
    KTVAddress *address = [KTVCommon getUserLocation];
    NSDictionary *params =@{@"storeType" : @(0),
                            @"distance" :@(5000.0),
                            @"latitude" : @(address.latitude),
                            @"longitude" : @(address.longitude)};
    [MBProgressHUD showMessage:@"加载中..."];
    [KTVMainService postLocalStore:params result:^(NSDictionary *result) {
        [MBProgressHUD hiddenHUD];
        if (![result[@"code"] isEqualToString:ktvCode]) {
            [KTVToast toast:result[@"detail"]];
            return;
        }
        if ([result[@"data"] count]) {
            for (NSDictionary *dict in result[@"data"]) {
                KTVStore *store = [KTVStore yy_modelWithDictionary:dict];
                [self.barStoreList addObject:store];
            }
        } else {
            [KTVToast toast:@"附近未查询到酒吧"];
        }
        [self.tableView reloadData];
    }];
}

- (void)loadNearKtvStore {
    KTVAddress *address = [KTVCommon getUserLocation];
    NSDictionary *params =@{@"storeType" : @(1),
                            @"distance" :@(5000.0),
                            @"latitude" : @(address.latitude),
                            @"longitude" : @(address.longitude)};
    [MBProgressHUD showMessage:@"加载中..."];
    [KTVMainService postLocalStore:params result:^(NSDictionary *result) {
        [MBProgressHUD hiddenHUD];
        if (![result[@"code"] isEqualToString:ktvCode]) {
            [KTVToast toast:result[@"detail"]];
            return;
        }
        if ([result[@"data"] count]) {
            for (NSDictionary *dict in result[@"data"]) {
                KTVStore *store = [KTVStore yy_modelWithDictionary:dict];
                [self.ktvStoreList addObject:store];
            }
        } else {
            [KTVToast toast:@"附近未查询到KTV"];
        }
         [self.tableView reloadData];
    }];
}

#pragma mark - 事件

- (IBAction)eventChangeAction:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        if (!self.barStoreList.count) {
            [self loadNearBarStore];
        } else {
            [self.tableView reloadData];
        }
    } else if (sender.selectedSegmentIndex == 1) {
        if (!self.ktvStoreList.count) {
            [self loadNearKtvStore];
        } else {
            [self.tableView reloadData];
        }
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 115.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    KTVStore *store = nil;
    if (self.segment.selectedSegmentIndex == 0) {
        store = self.barStoreList[indexPath.row];
    } else {
        store = self.ktvStoreList[indexPath.row];
    }
    KTVBarKtvDetailController *vc = (KTVBarKtvDetailController *)[UIViewController storyboardName:@"MainPage" storyboardId:@"KTVBarKtvDetailController"];
    vc.store = store;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.segment.selectedSegmentIndex == 0) {
        return [self.barStoreList count];
    } else {
        return [self.ktvStoreList count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KTVStore *store = nil;
    if (self.segment.selectedSegmentIndex == 0) {
        store = self.barStoreList[indexPath.row];
    } else {
        store = self.ktvStoreList[indexPath.row];
    }
    KTVGuessLikeCell *cell = (KTVGuessLikeCell *)[tableView dequeueReusableCellWithIdentifier:@"KTVGuessLikeCell"];
    cell.storee = store;
    return cell;
}

@end
