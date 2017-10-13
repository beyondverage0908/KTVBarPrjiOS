//
//  KTVPZStoreCell.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/3.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTVPinZhuoDetail.h"

@interface KTVPZStoreCell : UITableViewCell

@property (nonatomic, copy) void (^reportCallback)(KTVPinZhuoDetail *pzDetail);

@property (nonatomic, strong) KTVPinZhuoDetail * pzDetail;

@end
