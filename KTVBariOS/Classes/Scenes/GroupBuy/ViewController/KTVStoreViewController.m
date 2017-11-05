//
//  KTVStoreViewController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/3.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVStoreViewController.h"

#import "KTVStoreCell.h"

#import "KTVMainService.h"

@interface KTVStoreViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray<KTVStore *> *storeList;

@end

@implementation KTVStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"店铺";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor ktvBG];
    
    [self initData];
    
    [self loadStoresBySearch];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initData {
    self.storeList = [NSMutableArray array];
}

#pragma mark - 网络

- (void)loadStoresBySearch {
    
    KTVAddress *address = [KTVCommon getUserLocation];
    NSDictionary *params =@{@"storeType" : @(self.storeType),
                            @"distance" :@(1000.0),
                            @"latitude" : @(address.latitude),
                            @"longitude" : @(address.longitude)};
    [KTVMainService postLocalStore:params result:^(NSDictionary *result) {
        if (![result[@"code"] isEqualToString:ktvCode]) {
            [KTVToast toast:result[@"detail"]];
            return;
        }
        if ([result[@"data"] count]) {
            for (NSDictionary *dict in result[@"data"]) {
                KTVStore *store = [KTVStore yy_modelWithDictionary:dict];
                [self.storeList addObject:store];
            }
            [self.tableView reloadData];
        } else {
            [KTVToast toast:TOAST_STORE_EMPTY];
        }
    }];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120.0f;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.storeList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KTVStoreCell *cell = (KTVStoreCell *)[tableView dequeueReusableCellWithIdentifier:@"KTVStoreCell"];
    KTVStore *store = self.storeList[indexPath.row];
    cell.store = store;
    cell.callBack = ^(KTVStore *store) {
        CLog(@"-->> 花生酒店");
        if (self.selectedStoreCallback) {
            self.selectedStoreCallback(store);
        }
        [self.navigationController popViewControllerAnimated:YES];
    };
    return cell;
}

@end
