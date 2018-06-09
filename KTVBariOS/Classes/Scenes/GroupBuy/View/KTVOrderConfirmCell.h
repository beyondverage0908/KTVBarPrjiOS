//
//  KTVOrderConfirmCell.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/29.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTVPackage.h"
#import "KTVShop.h"

@interface KTVOrderConfirmCell : UITableViewCell

@property (nonatomic, strong) NSArray<KTVUser *> *selectedActivitorList;
@property (nonatomic, strong) NSArray<KTVPackage *> *packageList;
@property (nonatomic, copy) NSArray<KTVShop *> *shopCartList;

@end
