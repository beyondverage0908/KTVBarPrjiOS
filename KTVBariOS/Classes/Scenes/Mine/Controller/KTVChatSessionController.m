//
//  KTVChatSessionController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/11/29.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVChatSessionController.h"

@interface KTVChatSessionController ()

@end

@implementation KTVChatSessionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的消息";
    
    //设置需要显示哪些类型的会话
    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE)]];
    self.cellBackgroundColor = [UIColor yellowColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//重写RCConversationListViewController的onSelectedTableRow事件
- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath {
    RCConversationViewController *conversationVC = [[RCConversationViewController alloc] init];
    conversationVC.conversationType = model.conversationType;
    conversationVC.targetId = model.targetId;
    conversationVC.title = @"想显示的会话标题";
    [self.navigationController pushViewController:conversationVC animated:YES];
}

@end
