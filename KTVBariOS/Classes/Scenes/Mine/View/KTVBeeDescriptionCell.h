//
//  KTVBeeDescriptionCell.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/10/31.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTVUser.h"

@interface KTVBeeDescriptionCell : UITableViewCell

@property (nonatomic, strong) NSString *introduction;
@property (nonatomic, strong) KTVUser *user;

@end
