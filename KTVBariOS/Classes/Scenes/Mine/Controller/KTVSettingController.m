//
//  KTVSettingController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/10/23.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVSettingController.h"
#import "KTVAppVersionCell.h"

@interface KTVSettingController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation KTVSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor ktvBG];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)exitAction:(id)sender {
    CLog(@"-->>>退出");
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 50;
    }
    return 0;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        KTVAppVersionCell *cell = (KTVAppVersionCell *)[tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVAppVersionCell)];
        return cell;
    }
    return nil;
}

@end
