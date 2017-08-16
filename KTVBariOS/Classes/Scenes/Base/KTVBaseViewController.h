//
//  KTVBaseViewController.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/7/9.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KTVBaseViewController : UIViewController

/// 是否隐藏导航栏
- (void)hideNavigationBar:(BOOL)isHidden;
/// 添加导航栏按钮
- (void)addBarButtonItems:(NSArray *)itemTitles;
// 设置导航栏和状态栏的背景色
- (void)setNavigationBarColor:(UIColor *)color;

// 系统返回按钮触发方法
- (void)navigationBackAction:(id)action;

@end
