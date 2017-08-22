//
//  KTVGroupBuyDetailController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/21.
//  Copyright © 2017年 Lin. All rights reserved.
//
//  团购详情

#import "KTVGroupBuyDetailController.h"
#import "KTVGroupBuyHeaderCell.h"
#import "KTTimeFilterCell.h"
#import "KTVPositionFilterCell.h"

@interface KTVGroupBuyDetailController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation KTVGroupBuyDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self hideNavigationBar:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - UITableViewDelegate


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 220.0f;
    } else if (indexPath.section == 1) {
        return 50.0f;
    }
    return 0;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1){
        return 2;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        KTVGroupBuyHeaderCell *cell = (KTVGroupBuyHeaderCell *)[tableView dequeueReusableCellWithIdentifier:@"KTVGroupBuyHeaderCell"];
        return cell;
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            NSString *KTTimeFilterCellIdentifer = @"KTTimeFilterCell";
            KTTimeFilterCell *cell = [tableView dequeueReusableCellWithIdentifier:KTTimeFilterCellIdentifer];
            if (!cell) {
                cell = [[KTTimeFilterCell alloc] initWithItems:@[@"今天;06-28",
                                                                 @"周四;06-29",
                                                                 @"周五;06-30",
                                                                 @"周六;07-01",
                                                                 @"周日;07-02",
                                                                 @"周一;07-03",
                                                                 @"周二;07-04",
                                                                 @"周三;07-05"]
                                               reuseIdentifier:KTTimeFilterCellIdentifer];
            }
            return cell;
        } else {
            NSString *KTVPositionFilterCellIdentifier = @"KTVPositionFilterCell";
            KTVPositionFilterCell *cell = [tableView dequeueReusableCellWithIdentifier:KTVPositionFilterCellIdentifier];
            if (!cell) {
                cell = [[KTVPositionFilterCell alloc] initWithPositionFilterItems:@[@"卡座(4-6人)",
                                                                                    @"VIP位置(8-10人)",
                                                                                    @"吧台¥(4-6人)",
                                                                                    @"包厢(15-20人)",
                                                                                    @"阳台(1-2人)",
                                                                                    @"沙发(2-3人)",
                                                                                    @"床上(2人)",]
                                                                  reuseIdentifier:KTVPositionFilterCellIdentifier];
            }
            return cell;
        }
    }
    return 0;
}

@end
