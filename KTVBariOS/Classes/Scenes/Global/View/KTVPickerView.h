//
//  KTVPickerView.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/1.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KTVPickerView;

@protocol KTVPickerViewDelegate <NSObject>

@required
/// 确定选中
- (void)ktvPickerView:(KTVPickerView *)ktvPickerView selectedTitle:(NSString *)selectedTitle;

@end

@interface KTVPickerView : UIView

@property (weak, nonatomic) id<KTVPickerViewDelegate> delegate;

@property (strong, nonatomic) NSArray<NSString *> *dataSource;

- (instancetype)initWithSelectedCallback:(void (^)(NSString *selectedTitle))selectedCallback;

@end
