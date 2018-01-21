//
//  KTVSimpleFilter.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/27.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KTVSimpleFilter : UIView

@property (strong, nonatomic) NSArray<NSString *> *filters;
@property (nonatomic, copy) void (^filterCallfback)(NSInteger index);

@end
