//
//  KTVFilterView.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/12.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KTVFilterView : UIView

@property (nonatomic, copy) void (^filterCallback)(NSDictionary *filterMap);
@property (nonatomic, copy) void (^filterDitailCallback)(NSString *filterDetailKey);

- (instancetype)initWithFilter:(NSArray<NSDictionary<NSString *, NSArray *> *> *)filters;

@end
