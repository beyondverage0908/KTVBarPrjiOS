//
//  KTVApplyWarmerPartOneController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2018/1/27.
//  Copyright © 2018年 Lin. All rights reserved.
//

#import "KTVApplyWarmerPartOneController.h"
#import "KTVApplyWarmerPartTwoController.h"
#import "ApplyWarmerView.h"

@interface KTVApplyWarmerPartOneController ()

@end

@implementation KTVApplyWarmerPartOneController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"申请成为暖场人";
    self.view.backgroundColor = [UIColor ktvBG];
    
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - init

- (void)initUI {
    ApplyWarmerView *applyView = [[[NSBundle mainBundle] loadNibNamed:@"ApplyWarmerView" owner:self options:nil] firstObject];
    CGRect frame = self.view.frame;
    frame.size.height = frame.size.height - 64;
    applyView.frame = frame;
    [self.view addSubview:applyView];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 64, self.view.frame.size.width, 64)];
    [self.view addSubview:bgView];
    bgView.backgroundColor = [UIColor ktvBG];
    
    UIButton *nextBtn = [[UIButton alloc] init];
    [bgView addSubview:nextBtn];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn setBackgroundColor:[UIColor ktvRed]];
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(bgView);
        make.height.equalTo(bgView).multipliedBy(0.7);
        make.width.equalTo(bgView).multipliedBy(0.7);
    }];
    nextBtn.layer.cornerRadius = 8;
    [nextBtn addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)nextAction:(UIButton *)btn {
    KTVApplyWarmerPartTwoController *vc = [[KTVApplyWarmerPartTwoController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
