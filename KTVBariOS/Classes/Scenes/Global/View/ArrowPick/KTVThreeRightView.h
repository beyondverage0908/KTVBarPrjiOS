//
//  ThreeRightView.h
//  Frame
//
//  Created by 栗子 on 2017/9/7.
//  Copyright © 2017年 http://www.cnblogs.com/Lrx-lizi/. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KTVThreeRightView : UIView

@property(nonatomic,copy)void (^selectRowBlock)(NSInteger row);

//点击空白部分隐藏
@property (nonatomic, assign) BOOL closeOnTouchUpOutside;

- (instancetype)initCustomImageArray:(NSArray *)imageArr textArray:(NSArray *)textArr selfFrame:(CGRect)frame;

- (void)show:(BOOL)animated;
- (void)hide:(BOOL)animated;

@end
