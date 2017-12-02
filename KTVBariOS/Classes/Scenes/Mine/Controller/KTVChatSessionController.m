//
//  KTVChatSessionController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/11/29.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVChatSessionController.h"
#import "KTVConversationController.h"

@interface KTVChatSessionController ()

@end

@implementation KTVChatSessionController

#pragma mark - 控制器的生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的消息";
    
    //设置需要显示哪些类型的会话
    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE)]];
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

@end
