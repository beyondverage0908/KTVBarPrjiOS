//
//  KTVBuycarController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/27.
//  Copyright © 2017年 Lin. All rights reserved.
//
//  购物车

#import "KTVBuycarController.h"
#import "KTVBuycarSummaryCell.h"

@interface KTVBuycarController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *datas;

@end

@implementation KTVBuycarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购物车";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    _datas = [NSMutableArray arrayWithCapacity:10];
    for (NSInteger i = 0; i < 10; i++) {
        [_datas addObject:@(i).stringValue];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 85.0f;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        CLog(@"--->>> 左滑删除操作");
        [self.datas removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KTVBuycarSummaryCell *cell = (KTVBuycarSummaryCell *)[tableView dequeueReusableCellWithIdentifier:@"KTVBuycarSummaryCell"];
    return cell;
}

@end
