//
//  KTVRequestMessage.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/1.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, KtvRequestType) {
    KtvGET = 0,      // get
    KtvPOST,         // post
    KtvPUT,          // Put
    KtvUpload,        // 上传文件
    KtvUploadStream     // 上传流视频
};

@interface KTVRequestMessage : NSObject

@property (nonatomic, copy)     NSString            *path;                      // 服务器路径
@property (nonatomic, assign)   KtvRequestType      httpType;                   // 提交服务器方式
// 格式
// imageMap = {@"imageName" : image}
@property (nonatomic, copy)     NSDictionary        *imageMap;                  // 上传图片集合
@property (nonatomic, copy)     NSArray             *imageList;                 // 图片数组集合
@property (nonatomic, assign)   NSTimeInterval      timeout;                    // 请求服务器超时时间
@property (nonatomic, strong)   id                  params;                     // body参数
@property (nonatomic, strong)   NSURL               * videoUrl;                 // 视频地址

@property (nonatomic, strong)   NSString            *sign;                      // 加密，关键参数签名
@property (nonatomic, strong)   NSString            *aesKey;                    // 用于解密服务器返回已经加密的数据

@end
