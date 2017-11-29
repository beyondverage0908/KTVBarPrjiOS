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

// 点击上传图片/视频回调
@property (nonatomic, copy) void (^pickImageCallback)(KTVMediaType mediaType);
// 显示/播放 图片，视频回调
@property (nonatomic, copy) void (^showMediaCallback)(id media);
// 长按视频回调
@property (nonatomic, copy) void (^longPressMediaCallback)(KTVVideo *media);

- (instancetype)initWithMediaList:(NSArray *)mediaList style:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
