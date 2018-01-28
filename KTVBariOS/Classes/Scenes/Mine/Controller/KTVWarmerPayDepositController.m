//
//  KTVWarmerPayDepositController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2018/1/28.
//  Copyright © 2018年 Lin. All rights reserved.
//

#import "KTVWarmerPayDepositController.h"

@interface KTVWarmerPayDepositController ()

@property (weak, nonatomic) IBOutlet UILabel *depositLabel; // 押金数量
@property (weak, nonatomic) IBOutlet UILabel *warmerTypeLabel; // 暖场人类型

@end

@implementation KTVWarmerPayDepositController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)payAction:(UIButton *)sender {
    CLog(@"付款");
}
@end
