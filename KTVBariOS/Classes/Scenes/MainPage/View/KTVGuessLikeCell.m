//
//  KTVGuessLikeCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/3.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVGuessLikeCell.h"
#import "KTVStarView.h"

@interface KTVGuessLikeCell ()

@property (weak, nonatomic) IBOutlet UIImageView *likeImageView;
@property (weak, nonatomic) IBOutlet UILabel *store;
@property (weak, nonatomic) IBOutlet KTVStarView *starView;
@property (weak, nonatomic) IBOutlet UILabel *appointment;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UIButton *placeOrderBtn;
@property (weak, nonatomic) IBOutlet UIButton *lookDetailBtn;

@end

@implementation KTVGuessLikeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupView];
    self.starView.stars = 4;
}

- (void)setupView {
    UIView *bottomLine = [[UIView alloc] init];
    [self.contentView addSubview:bottomLine];
    bottomLine.layer.shadowOffset = CGSizeMake(1.0, 2.0);
    bottomLine.layer.shadowColor = [UIColor yellowColor].CGColor;
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1.0f);
        make.left.and.right.and.bottom.equalTo(self.contentView);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

// 下订单 - 订座
- (IBAction)placeOrderAction:(UIButton *)sender {
    CLog(@"首页-猜你喜欢-下订单-订座");
    [KTVUtil tellphone:@"18516133629"];
}

// 查看详情
- (IBAction)lookDetailAction:(id)sender {
    CLog(@"首页-猜你喜欢-查看详情");
}


#pragma mark - 设值

- (void)setStoreContainer:(KTVStoreContainer *)storeContainer {
    _storeContainer = storeContainer;
    
    self.store.text = _storeContainer.store.storeName;
    self.starView.stars = _storeContainer.store.star;
    self.location.text = [NSString stringWithFormat:@"%@ %@km", _storeContainer.store.address.addressName, @(_storeContainer.distance)];
    self.appointment.text = [NSString stringWithFormat:@"在约的小伙伴%@人", @([_storeContainer.userList count])];;
}


@end
