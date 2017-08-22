//
//  KTVLoginInputView.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/7/15.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KTVLoginInputView;

typedef NS_ENUM(NSUInteger, KTVInputType) {
    KTVInputAccountType,
    KTVInputMobileType,
    KTVInputLockType,
    KTVInputVerfiyType
};

@protocol KTVLoginInputViewDelegate <NSObject>

- (void)inputView:(KTVLoginInputView *)inputView inputType:(KTVInputType)type inputValue:(NSString *)inputValue;

@end

@interface KTVLoginInputView : UIView

- (instancetype)init;

@property (assign, nonatomic)KTVInputType inputType;

@property (weak, nonatomic)id<KTVLoginInputViewDelegate> delegate;

@property (strong, nonatomic)NSString *inputValue;

@end
