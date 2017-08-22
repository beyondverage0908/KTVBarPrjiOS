//
//  UIButton+KTVExtension.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/7/19.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (KTVExtension)

- (void)countDownWithSeconds:(NSInteger)seconds;

- (void)countDownWithSeconds:(NSInteger)seconds description:(NSString *)des;

- (void)countDownWithSeconds:(NSInteger)seconds description:(NSString *)des countEndBlock:(void (^)())downBlock;

@end
