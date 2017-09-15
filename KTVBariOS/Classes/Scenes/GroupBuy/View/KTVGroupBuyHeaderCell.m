//
//  KTVGroupBuyHeaderCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/21.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVGroupBuyHeaderCell.h"
#import "KTVStarView.h"
#import "UILabel+Ktv.h"

#import "KTVMainService.h"

@interface KTVGroupBuyHeaderCell ()

@property (weak, nonatomic) IBOutlet UILabel *detailInstrLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *oldMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *storeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *yuepaoNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UIImageView *storeImageView;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
@property (weak, nonatomic) IBOutlet KTVStarView *starView;

@end

@implementation KTVGroupBuyHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.starView.stars = 1;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoYueAction:)];
    [self.yuepaoNumberLabel addGestureRecognizer:tap];
    
    [self setupUI];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setupUI {
    [self.yuepaoNumberLabel addUnderlineStyle];
}

#pragma mark - 事件

- (IBAction)buyAction:(UIButton *)sender {
    CLog(@"--->>>团购详情-立即购买");
    if (self.bookedGroupbuyCallback) {
        self.bookedGroupbuyCallback();
    }
}

- (void)gotoYueAction:(UILabel *)sender {
    CLog(@"-- 在约的小伙伴有100人");
}

#pragma mark - 设置值

- (void)setInvitatorList:(NSArray *)invitatorList {
    _invitatorList = invitatorList;
    self.yuepaoNumberLabel.text = [NSString stringWithFormat:@"在约的小伙伴%@人", @([_invitatorList count])];
    [self.yuepaoNumberLabel addUnderlineStyle];
}

- (void)setStore:(KTVStore *)store {
    _store = store;
    
    self.storeNameLabel.text = store.storeName;
    self.starView.stars = store.star;
    self.locationLabel.text = store.address.addressName;
}

- (void)setGroupbuy:(KTVGroupbuy *)groupbuy {
    _groupbuy = groupbuy;
    
    self.moneyLabel.text = [NSString stringWithFormat:@"¥%@", self.groupbuy.totalPrice];
}


@end
