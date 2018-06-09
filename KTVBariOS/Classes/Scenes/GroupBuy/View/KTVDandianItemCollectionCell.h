//
//  KTVDandianItemCollectionCell.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/27.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTVGood.h"

@interface KTVDandianItemCollectionCell : UICollectionViewCell

@property (nonatomic, copy) void (^buyCarCallBack)(BOOL buyIn, KTVGood *good);

@property (nonatomic, strong) KTVGood *good;

@end
