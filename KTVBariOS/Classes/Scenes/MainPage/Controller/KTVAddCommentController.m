//
//  KTVAddCommentController.m
//  AFNetworking
//
//  Created by pingjun lin on 2018/6/12.
//

#import "KTVAddCommentController.h"
#import "KTVCommentHeaderCell.h"
#import "KTVCommentInputInfoCell.h"

@interface KTVAddCommentController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation KTVAddCommentController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加评论";
    
    self.tableView.backgroundColor = [UIColor ktvBG];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (IBAction)addCommentAction:(UIButton *)sender {
    NSLog(@"添加评论");
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        KTVCommentHeaderCell * cell = [tableView dequeueReusableCellWithIdentifier:@"KTVCommentHeaderCell"];
        return cell;
    } else if (indexPath.row == 1) {
        KTVCommentInputInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KTVCommentInputInfoCell"];
        return cell;
    } else {
        return [UITableViewCell new];
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 305;
    } else if (indexPath.row == 1) {
        return 303;
    } else {
        return 0;
    }
}

@end
