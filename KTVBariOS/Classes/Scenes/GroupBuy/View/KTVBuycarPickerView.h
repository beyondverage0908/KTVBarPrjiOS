//
//  KTVBuycarPickerView.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/27.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTVGood.h"

@interface KTVBuycarPickerView : UIView

@property (nonatomic, strong) KTVGood *tempGood;
@property (nonatomic, strong) NSMutableDictionary<NSString *, id> *shopCart;

@property (nonatomic, copy) void (^operateShoppingCartCallBack)(BOOL isIn, KTVGood *good);
@property (nonatomic, copy) void (^operateShoppingCartCompeletion)(BOOL isConfirm, NSMutableDictionary *shopCart);

@end
