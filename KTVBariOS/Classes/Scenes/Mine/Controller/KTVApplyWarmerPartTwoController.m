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
#import "KTVMainService.h"

@interface KTVApplyWarmerPartTwoController ()

@property (assign, nonatomic) BOOL isAgreeBecomeWarmer;
@property (strong, nonatomic) NSMutableDictionary *warmerInfoSecondPart;

@end

@implementation KTVApplyWarmerPartTwoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"申请成为暖场人";
    [self initUI];
    
    self.warmerInfoSecondPart = [NSMutableDictionary dictionaryWithCapacity:7];
    
    [self.warmerInfoSecondPart setObject:@([KTVCommon getUserLocation].latitude) forKey:@"latitude"];
    [self.warmerInfoSecondPart setObject:@([KTVCommon getUserLocation].longitude) forKey:@"longitude"];
    [self.warmerInfoSecondPart setObject:@"南昌市" forKey:@"cityName"];
}

- (void)initUI {
    KTVApplyWarmerParttwoView *applyTwoView = [[[NSBundle mainBundle] loadNibNamed:@"KTVApplyWarmerParttwoView" owner:self options:nil] firstObject];
    CGRect frame = self.view.frame;
    frame.size.height = frame.size.height - 64;
    applyTwoView.frame = frame;
    [self.view addSubview:applyTwoView];
    
    // 0;管理员（ROLE_ADMIN） 1普通用户(ROLE_USER)，2:商家(ROLE_SELLER)，3:服务者(ROLE_SERVER)（暖场人  公主等,只是酒吧内部员工（也就是固定）） 4 常驻暖场人  5 兼职暖场人
    @WeakObj(self);
    applyTwoView.parttimeOrlongtimeCallback = ^(BOOL isLongtime) {
        if (isLongtime) {
            CLog(@"-- 全职");
            [weakself.warmerInfoSecondPart setObject:@4 forKey:@"type"];
        } else {
            CLog(@"-- 兼职");
            [weakself.warmerInfoSecondPart setObject:@5 forKey:@"type"];
        }
    };
    
    applyTwoView.weekCallback = ^(NSDictionary *selectedDic) {
        CLog(@"选中这几天兼职-->> %@", selectedDic);
        NSString *timeStr = [selectedDic.allValues componentsJoinedByString:@","];
        [weakself.warmerInfoSecondPart setObject:timeStr forKey:@"time"];
    };
    
    applyTwoView.permissCallback = ^(BOOL isAgree) {
        if (isAgree) {
            CLog(@"同意");
        } else {
            CLog(@"不同意");
        }
        weakself.isAgreeBecomeWarmer = isAgree;
    };
    
    applyTwoView.everydayMoneyCallback = ^(NSString *money) {
        [weakself.warmerInfoSecondPart setObject:money forKey:@"price"];
    };
    
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
    
    if (!self.isAgreeBecomeWarmer) {
        [KTVToast toast:@"请同意协议"];
        return;
    }
    if (self.warmerInfoSecondPart.allKeys.count < 3) {
        [KTVToast toast:@"请补充好资料"];
        return;
    }
    
    NSMutableDictionary *warmerInfo = [NSMutableDictionary dictionaryWithDictionary:self.warmerParams];
    for (NSString *key in self.warmerInfoSecondPart.allKeys) {
        [warmerInfo setObject:self.warmerInfoSecondPart[key] forKey:key];
    }
    
    @WeakObj(self);
    [MBProgressHUD showMessage:@"申请中，请稍后..."];
    [KTVMainService postApplyWarmer:warmerInfo result:^(NSDictionary *result) {
        [MBProgressHUD hiddenHUD];
        if ([result[@"code"] isEqualToString:ktvCode]) {
            [KTVToast toast:@"申请成功"];
            KTVWarmerApplyWaittingController *vc = [UIViewController storyboardName:@"MePage" storyboardId:@"KTVWarmerApplyWaittingController"];
            [weakself.navigationController pushViewController:vc animated:YES];
        } else {
            CLog(@"-->> 失败")
            [KTVToast toast:@"申请失败"];
        }
    }];
}

@end
