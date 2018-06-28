//
//  KTVComment.h
//  AFNetworking
//
//  Created by pingjun lin on 2018/6/11.
//

#import <Foundation/Foundation.h>
#import "KTVPicture.h"

@interface KTVComment : NSObject

//{
//    "id": 4,
//    "star": 5,
//    "description": "林平君的留言4",
//    "createTime": "2018-06-11 14:40:50",
//    "storeId": 4
//}

@property (nonatomic, strong) NSString *commentId;
@property (nonatomic, strong) NSString *star;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *storeId; // 门店的评论才会有
@property (nonatomic, strong) NSString *userId; // 暖场人的评论会有
@property (nonatomic, strong) NSArray<KTVPicture *>* pictureList;

@end
