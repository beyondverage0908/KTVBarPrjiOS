//
//  KTVNearbyController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/7/31.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVNearbyController.h"
#import "KTVGuessLikeCell.h"
#import "KTVSimpleFilter.h"
#import "KTVBarKtvDetailController.h"
#import "KTVNearStoreController.h"
#import "KTVNearPersonController.h"

@interface KTVNearbyController ()

//@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation KTVNearbyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"附近";

    self.view.backgroundColor = [UIColor ktvBG];
    
    KTVSimpleFilter *filterView = [[KTVSimpleFilter alloc] init];
    [self.view addSubview:filterView];
    filterView.filters = @[@"附近的商家", @"附近的人"];
    [filterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);
        make.height.equalTo(@44.0f);
    }];
    // 默认初始化一个子视图
    KTVNearStoreController *vc = (KTVNearStoreController *)[UIViewController storyboardName:@"NearPage" storyboardId:@"KTVNearStoreController"];
    [self displayContentController:vc];
    filterView.filterCallfback = ^(NSInteger index) {
        if (index == 0) {
            if (![self isContainerViewController:KTVNearStoreController.class]) {
                KTVNearStoreController *vc = (KTVNearStoreController *)[UIViewController storyboardName:@"NearPage" storyboardId:@"KTVNearStoreController"];
                [self displayContentController:vc];
                [self displayContentController:vc];
            }
        } else if (index == 1) {
            if (![self isContainerViewController:KTVNearPersonController.class]) {
                KTVNearPersonController *vc = [[KTVNearPersonController alloc] init];
                [self displayContentController:vc];
            }
        }
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 添加子视图控制器

- (BOOL)isContainerViewController:(Class)VC {
    for (UIViewController *vc in self.childViewControllers) {
        if ([[vc class] isEqual:VC]) {
            return YES;
        }
    }
    return NO;
}

- (void)displayContentController:(UIViewController*)content {
    if (self.childViewControllers.count) {
        UIViewController *childVc = self.childViewControllers[0];
        [self hideContentController:childVc];
    }
    [self addChildViewController:content];
    CGRect frame = self.view.frame;
    frame.origin.y = 108;
    frame.size.height = frame.size.height - 108;
    content.view.frame = frame;
    [self.view addSubview:content.view];
    [content didMoveToParentViewController:self];
}

- (void)hideContentController:(UIViewController*) content {
    [content willMoveToParentViewController:nil];
    [content.view removeFromSuperview];
    [content removeFromParentViewController];
}

@end
