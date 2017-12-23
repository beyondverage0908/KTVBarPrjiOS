//
//  KTVBaseTabBarViewController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/7/10.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVBaseTabBarViewController.h"
#import "KTVBaseNavigationViewController.h"
#import "KTVLoginGuideController.h"
#import "KTVChatSessionController.h"
#import "UINavigationBar+background.h"

@interface KTVBaseTabBarViewController ()

@end

@implementation KTVBaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewControllerWithStoryboard:@"MainPage"
                          storyboardIdentifier:@"KTVMainController"
                               tabBarItemTitle:@"首页"
                                         image:@"app_mainpage_icon_unselect"
                                andSelectImage:@"app_mainpage_icon_select"];
    
    [self addChildViewControllerWithStoryboard:@"NearPage"
                          storyboardIdentifier:@"KTVNearbyController"
                               tabBarItemTitle:@"附近"
                                         image:@"app_nearby_icon_unselect"
                                andSelectImage:@"app_nearby_icon_select"];
    
    KTVChatSessionController *chatSessionVC = [[KTVChatSessionController alloc] init];
    [self addChildViewController:chatSessionVC
                           title:@"消息"
                           image:@"app_tab_yuepao_unselect"
                     selectImage:@"app_tab_mine_select"];
//    [self addChildViewControllerWithStoryboard:@"DatingFriend"
//                          storyboardIdentifier:@"KTVDateViewController"
//                               tabBarItemTitle:@"邀约"
//                                         image:@"app_tab_yuepao_unselect"
//                                andSelectImage:@"app_tab_yuepao_select"];
    
    [self addChildViewControllerWithStoryboard:@"MePage"
                          storyboardIdentifier:@"KTVMineController"
                               tabBarItemTitle:@"我的"
                                         image:@"app_tab_mine_unselect"
                                andSelectImage:@"app_tab_mine_select"];
    
    // 检测token失效
    [KtvNotiCenter addObserver:self selector:@selector(notiInvalidateToken) name:ktvInvalidateToken object:nil];
}


/**
 *  为tabBar控制器添加子控制器
 *
 *  @param sb         控制器所在的故事板
 *  @param identifier 控制器在故事板的标识符
 *  @param title      tabBarItem上的标题
 *  @param imageName  tabBarItem上的默认图片
 *  @param selectName tabBarItem上的选中图片
 */

- (void)addChildViewControllerWithStoryboard:(NSString *)sb
                        storyboardIdentifier:(NSString *)identifier
                             tabBarItemTitle:(NSString *)title
                                       image:(NSString *)imageName
                              andSelectImage:(NSString *)selectName {
    
    UIViewController *targetvc = [UIViewController storyboardName:sb storyboardId:identifier];
    
    targetvc.tabBarItem = [[UITabBarItem alloc] initWithTitle:title
                                                        image:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                selectedImage:[[UIImage imageNamed:selectName]
                                                         imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    //设置字体
    [targetvc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor ktvGray]} forState:UIControlStateNormal];
    [targetvc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor ktvRed]} forState:UIControlStateSelected];
    
    KTVBaseNavigationViewController *nav = [[KTVBaseNavigationViewController alloc] initWithRootViewController:targetvc];
    [self addChildViewController:nav];
    
}

- (void)addChildViewController:(UIViewController *)childController
                         title:(NSString *)title
                         image:(NSString *)imageName
                   selectImage:(NSString *)selectImageName {
    childController.tabBarItem = [[UITabBarItem alloc] initWithTitle:title
                                                               image:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                       selectedImage:[[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    //设置字体
    [childController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor ktvGray]} forState:UIControlStateNormal];
    [childController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor ktvRed]} forState:UIControlStateSelected];
    
    KTVBaseNavigationViewController *nav = [[KTVBaseNavigationViewController alloc] initWithRootViewController:childController];
    [nav.navigationBar setColor:[UIColor ktvBG]];
    [nav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self addChildViewController:nav];
}

#pragma mark - 通知

- (void)notiInvalidateToken {
    // 移除本地的token
    [KTVCommon removeKtvToken];
    
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
