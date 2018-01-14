//
//  KTVChatSessionController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/11/29.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVChatSessionController.h"
#import "KTVConversationController.h"
#import "KTVLoginGuideController.h"
#import "KTVAlertController.h"

@interface KTVChatSessionController ()

@end

@implementation KTVChatSessionController

#pragma mark - 控制器的生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"聊天";
    
    //设置需要显示哪些类型的会话
    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE)]];
    
    // 会话列表没有会话的时候显示
    if (!self.conversationListDataSource.count) {
        [self.conversationListTableView setBackgroundColor:[UIColor ktvBG]];
        self.conversationListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (![KTVCommon isLogin]) {
        [KTVAlertController alertMessage:@"您尚未登陆，请登录后才能看到消息" confirmHandler:^(UIAlertAction *action) {
            [self login];
        } cancleHandler:^(UIAlertAction *action) {}];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 会话列表选中聊天代理

//重写RCConversationListViewController的onSelectedTableRow事件
- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath {
    KTVConversationController *ktvConversationVC = [[KTVConversationController alloc] init];
    ktvConversationVC.conversationType = model.conversationType;
    ktvConversationVC.targetId = model.targetId;
    ktvConversationVC.title = model.conversationTitle ? model.conversationTitle : model.senderUserId;
    [self.navigationController pushViewController:ktvConversationVC animated:YES];
}

#pragma mark - goto login

- (void)login {
    KTVLoginGuideController *guideVC = [[KTVLoginGuideController alloc] init];
    KTVBaseNavigationViewController *nav = [[KTVBaseNavigationViewController alloc] initWithRootViewController:guideVC];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
