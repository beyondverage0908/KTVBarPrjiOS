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

@interface KTVNearStoreController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;

@end

@implementation KTVNearStoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor ktvBG];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - 事件

- (IBAction)eventChangeAction:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        CLog(@"-->> 获取酒吧数据");
    } else if (sender.selectedSegmentIndex == 1) {
        CLog(@"-->> 获取KTV数据");
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 115.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    KTVBarKtvDetailController *vc = (KTVBarKtvDetailController *)[UIViewController storyboardName:@"MainPage" storyboardId:@"KTVBarKtvDetailController"];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KTVGuessLikeCell *cell = (KTVGuessLikeCell *)[tableView dequeueReusableCellWithIdentifier:@"KTVGuessLikeCell"];
    return cell;
}

@end
