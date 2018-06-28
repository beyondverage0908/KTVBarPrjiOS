//
//  KTVInvitingTACell.h
//  KTVBariOS
//
//  Created by pingjun lin on 2018/6/24.
//  Copyright © 2018年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KTVInvitingTACell : UITableViewCell

@property (nonatomic, copy) void (^invitedCallback)(void);

@end
