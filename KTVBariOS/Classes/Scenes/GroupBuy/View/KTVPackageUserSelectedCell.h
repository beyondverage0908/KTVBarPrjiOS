//
//  KTVPackageUserSelectedCell.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/24.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KTVPackageUserSelectedCell : UITableViewCell

// goods应该是用户选中商品的一个列表，商品是一个对象model，现在没有建，先用字典代替
- (instancetype)initBuyGoods:(NSArray<NSDictionary *> *)goods reuseIdentifier:(NSString *)reuseIdentifier;

@end
