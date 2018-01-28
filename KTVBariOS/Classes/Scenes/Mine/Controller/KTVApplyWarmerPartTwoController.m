//
//  KTVApplyWarmerPartTwoController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2018/1/27.
//  Copyright © 2018年 Lin. All rights reserved.
//

#import "KTVApplyWarmerPartTwoController.h"
#import "KTVApplyWarmerParttwoView.h"
#import "KTVWarmerApplyWaittingController.h"

@interface KTVApplyWarmerPartTwoController ()

@end

@implementation KTVApplyWarmerPartTwoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"申请成为暖场人";
    [self initUI];
}

- (void)initUI {
    KTVApplyWarmerParttwoView *applyTwoView = [[[NSBundle mainBundle] loadNibNamed:@"KTVApplyWarmerParttwoView" owner:self options:nil] firstObject];
    CGRect frame = self.view.frame;
    frame.size.height = frame.size.height - 64;
    applyTwoView.frame = frame;
    [self.view addSubview:applyTwoView];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 64, self.view.frame.size.width, 64)];
    [self.view addSubview:bgView];
    bgView.backgroundColor = [UIColor ktvBG];
    
    UIButton *nextBtn = [[UIButton alloc] init];
    [bgView addSubview:nextBtn];
    [nextBtn setTitle:@"完成" forState:UIControlStateNormal];
    [nextBtn setBackgroundColor:[UIColor ktvRed]];
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(bgView);
        make.height.equalTo(bgView).multipliedBy(0.7);
        make.width.equalTo(bgView).multipliedBy(0.7);
    }];
    nextBtn.layer.cornerRadius = 8;
    [nextBtn addTarget:self action:@selector(completedAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)completedAction:(UIButton *)btn {
    KTVWarmerApplyWaittingController *vc = [UIViewController storyboardName:@"MePage" storyboardId:@"KTVWarmerApplyWaittingController"];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
