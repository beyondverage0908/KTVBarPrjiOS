//
//  KTVPhotoBrowerView.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/11/14.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    kTVSeeType,
    KTVEidtType
} KTVOpType;

@interface KTVPhotoBrowerView : UIView

@property (nonatomic, assign) KTVOpType opType;

- (void)showPhotoBrowerConfig:(NSArray<KTVPicture *> *)photoUrlList andDefaultIndex:(NSInteger)index;

@end
