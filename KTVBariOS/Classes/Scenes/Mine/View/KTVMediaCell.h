//
//  KTVMediaCell.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/11/19.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KTVMediaCell : UITableViewCell

@property (nonatomic, copy) void (^showMediaCallback)(id media);

- (instancetype)initWithMediaList:(NSArray *)mediaList style:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
