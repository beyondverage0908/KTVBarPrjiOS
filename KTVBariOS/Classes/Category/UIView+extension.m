//
//  UIView+extension.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/11/4.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "UIView+extension.h"

@implementation UIView (extension)

- (void)cornerRadius {
    self.layer.cornerRadius = CGRectGetWidth(self.frame) / 2.0f;
    self.layer.masksToBounds = YES;
}

@end
