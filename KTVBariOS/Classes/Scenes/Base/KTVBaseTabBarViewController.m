//
//  KTVBaseTabBarViewController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/7/10.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVBaseTabBarViewController.h"
#import "KTVBaseNavigationViewController.h"

@interface KTVBaseTabBarViewController ()

@end

@implementation KTVBaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewControllerWithStoryboard:@"MainPage" storyboardIdentifier:@"KTVMainController" tabBarItemTitle:@"主页" image:@"icon_dongtai" andSelectImage:@"icon_dongtai"];
    [self addChildViewControllerWithStoryboard:@"NearPage" storyboardIdentifier:@"KTVNearbyController" tabBarItemTitle:@"主页" image:@"icon_dongtai" andSelectImage:@"icon_dongtai"];
    [self addChildViewControllerWithStoryboard:@"DatingFriend" storyboardIdentifier:@"KTVDateViewController" tabBarItemTitle:@"主页" image:@"icon_dongtai" andSelectImage:@"icon_dongtai"];
    [self addChildViewControllerWithStoryboard:@"MePage" storyboardIdentifier:@"KTVMineController" tabBarItemTitle:@"主页" image:@"icon_dongtai" andSelectImage:@"icon_dongtai"];
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
    [targetvc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]} forState:UIControlStateNormal];
    [targetvc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
    
    KTVBaseNavigationViewController *nav = [[KTVBaseNavigationViewController alloc] initWithRootViewController:targetvc];
    [self addChildViewController:nav];
    
}

@end
