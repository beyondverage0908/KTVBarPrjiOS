//
//  KTVAddCommentController.h
//  AFNetworking
//
//  Created by pingjun lin on 2018/6/12.
//

#import "KTVBaseViewController.h"

typedef NS_ENUM(NSUInteger, KtvCommentType) {
    KtvCommentStoreType,
    KtvCommentActivityType
};


@interface KTVAddCommentController : KTVBaseViewController

@property (nonatomic, assign) KtvCommentType commentType;
@property (nonatomic, strong) NSString *beCommentId; // 被评论的id 包括门店和暖场人

@end
