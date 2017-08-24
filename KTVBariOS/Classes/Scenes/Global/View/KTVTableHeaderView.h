//
//  KTVTableHeaderView.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/13.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KTVTableHeaderView : UIView

@property (nonatomic, copy)void (^headerActionBlock)(UIButton *headerImgBtn);

- (instancetype)initWithImageUrl:(NSString *)leadingImgUrl title:(NSString *)headerTitle headerImgUrl:(NSString *)headerUrl remark:(NSString *)headerRemark;

- (instancetype)initWithImageUrl:(NSString *)leadingImgUrl title:(NSString *)headerTitle remark:(NSString *)headerRemark;

@end
