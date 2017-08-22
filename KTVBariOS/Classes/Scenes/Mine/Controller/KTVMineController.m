//
//  KTVMineController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/7/31.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVMineController.h"
#import "KTVUserHeaderCell.h"
#import "KTVLoginGuideController.h"

@interface KTVMineController ()<UITableViewDelegate, UITableViewDataSource, KTVUserHeaderCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation KTVMineController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KTVUserHeaderCell *cell = (KTVUserHeaderCell *)[tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVUserHeaderCell)];
    cell.delegate = self;
    return cell;
}

#pragma mark - KTVUserHeaderCellDelegate

// login
- (void)gotoLogin {
    KTVLoginGuideController *guideVC = [[KTVLoginGuideController alloc] init];
    KTVBaseNavigationViewController *nav = [[KTVBaseNavigationViewController alloc] initWithRootViewController:guideVC];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
