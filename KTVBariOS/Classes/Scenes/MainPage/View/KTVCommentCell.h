//
//  KTVCommonCell.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/13.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTVComment.h"

@interface KTVCommentCell : UITableViewCell

@property (nonatomic, strong) KTVComment *comment;

@property (nonatomic, copy) void (^commentImageBrowsingCallBack)(NSInteger idx, KTVComment *comment);

@end
