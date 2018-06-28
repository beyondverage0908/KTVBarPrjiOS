//
//  KTVAddCommentController.m
//  AFNetworking
//
//  Created by pingjun lin on 2018/6/12.
//

#import "KTVAddCommentController.h"
#import "KTVCommentHeaderCell.h"
#import "KTVCommentInputInfoCell.h"
#import "KTVMainService.h"

@interface KTVAddCommentController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (assign, nonatomic) NSInteger starNumber;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSMutableDictionary *imageContainer;

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
    [self postComment];
}

#pragma mark - 网络

- (void)postComment {
    if (!self.content) {
        [KTVToast toast:@"请填写服务评价"];
        return;
    }
    if (self.starNumber == 0) {
        self.starNumber = 5;
    }
    if (self.commentType == KtvCommentStoreType) {
        NSDictionary *commentDict = @{@"orderId" : self.beCommentId, @"star" : @(self.starNumber), @"content" : self.content};
        [KTVMainService postCreatStoreComment:commentDict result:^(NSDictionary *result) {
            if ([result[@"code"] isEqualToString:ktvCode]) {
                [KTVToast toast:@"评论成功"];
                [self.navigationController popViewControllerAnimated:YES];
            } else {
                [KTVToast toast:result[@"detail"]];
            }
        }];
    } else {
        NSDictionary *commentDict = @{@"userId" : self.beCommentId, @"star" : @(self.starNumber), @"content" : self.content};
        [KTVMainService postCreateActorComment:commentDict result:^(NSDictionary *result) {
            if ([result[@"code"] isEqualToString:ktvCode]) {
                [KTVToast toast:@"评论成功"];
                [self.navigationController popViewControllerAnimated:YES];
            } else {
                [KTVToast toast:result[@"detail"]];
            }
        }];
    }
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
        @WeakObj(self);
        cell.starNumberCallback = ^(NSInteger number) {
            weakself.starNumber = number;
        };
        cell.contentCallback = ^(NSString *content) {
            weakself.content = content;
        };
        cell.imageTapCallback = ^(NSInteger imageTag) {
            // imageTag 1: 第一张图片 2: 第二张图片 3: 第三张图片
        };
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
