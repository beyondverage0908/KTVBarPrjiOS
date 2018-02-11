//
//  KTVApplyWarmerParttwoView.h
//  KTVBariOS
//
//  Created by pingjun lin on 2018/1/28.
//  Copyright © 2018年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KTVApplyWarmerParttwoView : UIView

@property (nonatomic, copy) void (^parttimeOrlongtimeCallback)(BOOL isLongtime);
@property (nonatomic, copy) void (^weekCallback)(NSDictionary *selectedDic);
@property (nonatomic, copy) void (^permissCallback)(BOOL isAgree);
@property (nonatomic, copy) void (^everydayMoneyCallback)(NSString *money);

@end
