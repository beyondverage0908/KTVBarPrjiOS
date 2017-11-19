//
//  KTVAddMediaCell.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/10/19.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    KTVMediaPhotoType,
    KTVMediaVideoType,
} KTVMediaType;

@interface KTVAddMediaCell : UITableViewCell

@property (nonatomic, assign) KTVMediaType mediaType;

@property (nonatomic, copy) void (^pickImageCallback)(KTVMediaType mediaType);
@property (nonatomic, copy) void (^showMediaCallback)(id media);

- (instancetype)initWithMediaList:(NSArray *)mediaList style:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
