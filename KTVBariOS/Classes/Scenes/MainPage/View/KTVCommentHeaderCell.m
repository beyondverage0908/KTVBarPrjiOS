//
//  KTVCommentHeaderCell.m
//  AFNetworking
//
//  Created by pingjun lin on 2018/6/12.
//

#import "KTVCommentHeaderCell.h"

@interface KTVCommentHeaderCell()

@property (weak, nonatomic) IBOutlet UILabel *storeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *paymentLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *storeBuyTypeLabel; // 酒吧预定卡座
@property (weak, nonatomic) IBOutlet UILabel *warmmerLabel; // 暖场人列表
@property (weak, nonatomic) IBOutlet UILabel *appointmentTimeLabel; // 预定时间
@property (weak, nonatomic) IBOutlet UILabel *buyInTimeLabel; // 下单时间

@end

@implementation KTVCommentHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

@end
