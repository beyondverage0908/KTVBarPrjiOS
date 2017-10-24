//
//  KTVAddMediaCell.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/10/19.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KTVAddMediaCell : UITableViewCell

@property (nonatomic, copy) void (^pickImageCallback)(void);

- (instancetype)initWithMediaList:(NSArray *)mediaList style:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
