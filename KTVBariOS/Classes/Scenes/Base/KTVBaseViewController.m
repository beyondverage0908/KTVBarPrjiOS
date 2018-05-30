//
//  KTVBaseViewController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/7/9.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVBaseViewController.h"
#import "UINavigationBar+background.h"
#import "KTVLoginGuideController.h"

@interface KTVBaseViewController ()

@end

@implementation KTVBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self hideNavigationBar:NO];
    
    [self setNavigationBarColor:[UIColor ktvBG]];
    [self setNavigationTitleColor:[UIColor whiteColor]];
    [self setNavigationBackButtonItem];
    
    UITapGestureRecognizer *endEditingTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditingAction)];
    [self.view addGestureRecognizer:endEditingTap];
}

#pragma mark - 事件

- (void)endEditingAction {
    [self.view endEditing:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    CLog(@"--->>> 内存不够了");
}

- (void)clearNavigationbar:(BOOL)isClear {
    if (isClear) {
        //[[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
        [self.navigationController.navigationBar setColor:[UIColor clearColor]];
    } else {
        [self.navigationController.navigationBar setColor:[UIColor ktvBG]];
//        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    }
}

- (void)hideNavigationBar:(BOOL)isHidden {
    [self.navigationController setNavigationBarHidden:isHidden animated:YES];
}

// 设置导航栏和状态栏的背景色
- (void)setNavigationBarColor:(UIColor *)color {
//    [self.navigationController.navigationBar ktv_setBackgroundColor:color];
//    self.navigationController.navigationBar.barTintColor = color;
    
    [self.navigationController.navigationBar setColor:color];
}

// 设置导航栏title的颜色
- (void)setNavigationTitleColor:(UIColor *)color {
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:color}];
}

// 设置返回按钮图片和颜色
- (void)setNavigationBackButtonItem {
    // reference: http://www.jianshu.com/p/c229dc1aa325
    // 方法2:通过父视图NaviController来设置
    // 此处空格是有作用的，用于扩大点击作用域
    UIBarButtonItem *bcItem = [[UIBarButtonItem alloc] initWithTitle:@"  " style:UIBarButtonItemStylePlain target:self action:@selector(navigationBackAction:)];
    self.navigationController.navigationBar.tintColor = [UIColor ktvRed];
    //主要是以下两个图片设置
    [self.navigationController.navigationBar setBackIndicatorImage:[UIImage imageNamed:@"app_navi_back_arrow"]];
    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"app_navi_back_arrow"]];
    self.navigationItem.backBarButtonItem = bcItem;
    
//    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    backBtn.frame = CGRectMake(-20, 0, 40, 40);
//    [backBtn setImage:[UIImage imageNamed:@"app_navi_back_arrow"] forState:UIControlStateNormal];
//    [backBtn addTarget:self action:@selector(navigationBackAction:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
//    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)addBarButtonItems:(NSArray *)itemTitles {

    NSMutableArray *items = [NSMutableArray arrayWithCapacity:itemTitles.count];
    
    for (NSString *title in itemTitles) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
        [btn setTitle:title forState:UIControlStateNormal];
        
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
        [items addObject:item];
    }
    
    self.navigationController.navigationItem.leftBarButtonItems = items;
}

- (void)navigationBackAction:(id)action {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)requestToLogin {
    UIAlertController *alertControler = [UIAlertController alertControllerWithTitle:@"提醒" message:@"您还未登陆，请先登陆后操作" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"登陆" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        KTVLoginGuideController *guideVC = [[KTVLoginGuideController alloc] init];
        KTVBaseNavigationViewController *nav = [[KTVBaseNavigationViewController alloc] initWithRootViewController:guideVC];
        [self presentViewController:nav animated:YES completion:nil];
    }];
    [alertControler addAction:confirmAction];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
    [alertControler addAction:cancelAction];
    
    [self presentViewController:alertControler animated:YES completion:nil];
}

@end
