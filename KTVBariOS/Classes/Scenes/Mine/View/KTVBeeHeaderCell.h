//
//  KTVBeeHeaderCell.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/10/31.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTVUser.h"

@interface KTVBeeHeaderCell : UITableViewCell

@property (nonatomic, strong) KTVUser * user;

@property (nonatomic, copy) void (^userImageTapCallback)(NSInteger index, NSArray<KTVPicture *> *pictureList);

@end
