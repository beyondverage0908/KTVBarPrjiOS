//
//  KTVAddYaoYueView.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/4.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KTVAddYaoYueView : UIView

// sign: bar sign: ktv
@property (copy, nonatomic) void (^yaoYueCallback)(NSString *sign);

@end
