//
//  KTVBeautyGirlCollectionCell.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/30.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "KTVUser.h"

@interface KTVBeautyGirlCollectionCell : UICollectionViewCell

@property (nonatomic, strong) KTVUser *user;

@property (nonatomic, copy) void (^callback)(KTVUser *user);

@end
