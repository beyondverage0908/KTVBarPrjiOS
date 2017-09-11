//
//  KTVTableHeaderView.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/13.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, KTVHeaderType) {
    HeaderType,
    RemarkType,
    BGType
};

@interface KTVTableHeaderView : UIView

@property (nonatomic, copy)void (^headerActionBlock)(KTVHeaderType headerType);
@property (nonatomic, copy)void (^bgActionBlock)(KTVHeaderType headerType);

/**
 *  @param leadingImgUrl 头部侧边图片地址
 *  @param headerTitle 头部左侧标题
 *  @param headerUrl 头部图片url
 *  @param remarkUrl 右侧图片
 *  @param headerRemark 右侧备注
 *
 */
- (instancetype)initWithImageUrl:(NSString *)leadingImgUrl title:(NSString *)headerTitle headerImgUrl:(NSString *)headerUrl remarkUrl:(NSString *)remarkUrl remark:(NSString *)headerRemark;

- (instancetype)initWithImageUrl:(NSString *)leadingImgUrl title:(NSString *)headerTitle headerImgUrl:(NSString *)headerUrl remark:(NSString *)headerRemark;

- (instancetype)initWithImageUrl:(NSString *)leadingImgUrl title:(NSString *)headerTitle remark:(NSString *)headerRemark;

@end
