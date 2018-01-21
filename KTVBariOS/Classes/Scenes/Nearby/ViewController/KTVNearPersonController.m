//
//  KTVNearPersonController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2018/1/14.
//  Copyright © 2018年 Lin. All rights reserved.
//

#import "KTVNearPersonController.h"
#import "KTVBarKtvDetailController.h"
#import "KTVGuessLikeCell.h"
#import "KTVBeeCell.h"

@interface KTVNearPersonController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation KTVNearPersonController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor ktvBG];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor ktvBG];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90.0f;
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
    KTVBeeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KTVBeeCell"];
    if (!cell) {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"KTVBeeCell" owner:self options:nil];
        cell = nibs.count > 0 ? [nibs objectAtIndex:0] : [UITableViewCell new];
    }
//    cell.user = 
    return cell;
}

@end
