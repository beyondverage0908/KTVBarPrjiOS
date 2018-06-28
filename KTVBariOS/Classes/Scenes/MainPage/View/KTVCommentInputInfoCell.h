//
//  KTVCommentInputInfoCell.h
//  AFNetworking
//
//  Created by pingjun lin on 2018/6/12.
//

#import <UIKit/UIKit.h>

@interface KTVCommentInputInfoCell : UITableViewCell

@property (nonatomic, copy) void (^starNumberCallback)(NSInteger number);
@property (nonatomic, copy) void (^imageTapCallback)(NSInteger imageTag);
@property (nonatomic, copy) void (^contentCallback)(NSString *content);

@end
