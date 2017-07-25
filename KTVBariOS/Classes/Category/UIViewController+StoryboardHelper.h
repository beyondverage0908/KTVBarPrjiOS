//
//  UIViewController+StoryboardHelper.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/7/19.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (StoryboardHelper)

+ (UIViewController *)storyboardName:(NSString *)name storyboardId:(NSString *)sbid;

@end
