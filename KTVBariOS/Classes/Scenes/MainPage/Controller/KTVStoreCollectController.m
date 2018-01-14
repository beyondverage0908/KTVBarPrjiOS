//
//  KTVStoreCollectController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2018/1/13.
//  Copyright © 2018年 Lin. All rights reserved.
//

#import "KTVStoreCollectController.h"
#import "KTVStoreCell.h"
#import "KTVMainService.h"
#import "KTVBarKtvDetailController.h"

@interface KTVStoreCollectController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *storeList;

@end

@implementation KTVStoreCollectController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor ktvBG];
    self.tableView.backgroundColor = [UIColor ktvBG];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    safetyArray(self.storeList);
    
    [self getAlreadyUserCollection];
}

#pragma mark - 网络

// 获取店铺是否收藏
- (void)getAlreadyUserCollection {
    NSString *phone = [KTVCommon userInfo].phone;
    safetyString(phone);
    @WeakObj(self);
    [KTVMainService getUserCollect:phone result:^(NSDictionary *result) {
        if ([result[@"code"] isEqualToString:ktvCode]) {
            for (NSDictionary *dic in result[@"data"]) {
                [weakself.storeList addObject:[KTVStore yy_modelWithDictionary:dic[@"storeModel"]]];
            }
            [weakself.tableView reloadData];
        }
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.storeList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KTVStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KTVStoreCell"];
    cell.store = self.storeList[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    KTVBarKtvDetailController *vc = (KTVBarKtvDetailController *)[UIViewController storyboardName:@"MainPage" storyboardId:@"KTVBarKtvDetailController"];
    KTVStore *store = self.storeList[indexPath.row];
    vc.store = store;;
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120.0f;
}

@end
