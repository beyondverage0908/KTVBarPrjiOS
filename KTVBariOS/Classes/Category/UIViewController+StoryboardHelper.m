//
//  UIViewController+StoryboardHelper.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/7/19.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "UIViewController+StoryboardHelper.h"

@implementation UIViewController (StoryboardHelper)

+ (UIViewController *)storyboardName:(NSString *)name storyboardId:(NSString *)sbid {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:name bundle:[NSBundle mainBundle]];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:sbid];
    return vc;
}

@end
