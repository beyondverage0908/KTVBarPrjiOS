//
//  KTVNearbyController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/7/31.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVNearbyController.h"
#import "KTVGuessLikeCell.h"
#import "KTVSimpleFilter.h"
#import "KTVBarKtvDetailController.h"
#import "KTVNearStoreController.h"
#import "KTVNearPersonController.h"

@interface KTVNearbyController ()

//@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation KTVNearbyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"附近";
    //115
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
//    self.tableView.backgroundColor = [UIColor ktvBG];
    self.view.backgroundColor = [UIColor ktvBG];
    
    KTVSimpleFilter *filterView = [[KTVSimpleFilter alloc] init];
    [self.view addSubview:filterView];
    filterView.filters = @[@"附近的商家", @"附近的人"];
    [filterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);
        make.height.equalTo(@44.0f);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//#pragma mark - UITableViewDelegate
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 115.0f;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 44.0f;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    KTVSimpleFilter *filterView = [[KTVSimpleFilter alloc] init];
//    filterView.filters = @[@"附近的商家", @"附近的人"];
//    return filterView;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    KTVBarKtvDetailController *vc = (KTVBarKtvDetailController *)[UIViewController storyboardName:@"MainPage" storyboardId:@"KTVBarKtvDetailController"];
//    [self.navigationController pushViewController:vc animated:YES];
//}
//
//#pragma mark - UITableViewDataSource
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 5;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    KTVGuessLikeCell *cell = (KTVGuessLikeCell *)[tableView dequeueReusableCellWithIdentifier:@"KTVGuessLikeCell"];
//    return cell;
//}

@end
