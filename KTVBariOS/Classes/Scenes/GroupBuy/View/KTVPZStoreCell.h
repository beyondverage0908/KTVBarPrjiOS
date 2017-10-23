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

// 去报名
@property (nonatomic, copy) void (^reportCallback)(KTVPinZhuoDetail *pzDetail);
// 查看已经报名加入拼桌了多少人
@property (nonatomic, copy) void (^enrollCallback)(KTVPinZhuoDetail *pzDetail);

@property (nonatomic, strong) KTVPinZhuoDetail * pzDetail;

@end
