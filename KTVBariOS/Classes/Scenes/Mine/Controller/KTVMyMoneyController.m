//
//  KTVMyMoneyController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2018/5/26.
//  Copyright © 2018年 Lin. All rights reserved.
//

#import "KTVMyMoneyController.h"
#import "KTVMainService.h"

@interface KTVMyMoneyController ()

@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@end

@implementation KTVMyMoneyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的余额";
    
    NSString *userId = [KTVCommon userInfo].phone;
    if (userId) {
        [KTVMainService getUserBalance:userId result:^(NSDictionary *result) {
            if ([result[@"code"] isEqualToString:ktvCode]) {
                if ([result[@"data"] isKindOfClass:[NSNull class]]) {
                    self.moneyLabel.text = @"0 元";
                } else {
                    self.moneyLabel.text = [NSString stringWithFormat:@"%@ 元", result[@"data"]];
                }
            }
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
