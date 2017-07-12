//
//  KTVBaseViewController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/7/9.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVBaseViewController.h"

@interface KTVBaseViewController ()

@end

@implementation KTVBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBarColor:RGBCOLOR(33, 33, 42)];
    [self setNavigationTitleColor:[UIColor whiteColor]];
    [self setNavigationBackButtonItem];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)hideNavigationBar:(BOOL)isHidden {
    [self.navigationController setNavigationBarHidden:isHidden animated:YES];
}

// 设置导航栏和状态栏的背景色
- (void)setNavigationBarColor:(UIColor *)color {
    self.navigationController.navigationBar.barTintColor = color;
}
// 设置导航栏title的颜色
- (void)setNavigationTitleColor:(UIColor *)color {
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:color}];
}
// 设置返回按钮图片和颜色
- (void)setNavigationBackButtonItem {
    // reference: http://www.jianshu.com/p/c229dc1aa325
    //方法2:通过父视图NaviController来设置
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.tintColor = COLORHex(@"#F63A82");
    //主要是以下两个图片设置
    self.navigationController.navigationBar.backIndicatorImage = [UIImage imageNamed:@"app_navi_back_arrow.png"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"app_navi_back_arrow.png"];
    self.navigationItem.backBarButtonItem = backItem;
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

@end
