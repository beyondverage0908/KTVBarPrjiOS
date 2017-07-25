//
//  KTVLoginInputView.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/7/15.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, KTVInputType) {
    KTVInputAccountType,
    KTVInputMobileType,
    KTVInputLockType,
    KTVInputVerfiyType
};

@interface KTVLoginInputView : UIView

- (instancetype)init;

@property (assign, nonatomic)KTVInputType inputType;

@end
