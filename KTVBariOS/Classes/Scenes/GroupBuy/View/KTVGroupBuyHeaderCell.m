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
}

- (void)gotoYueAction:(UILabel *)sender {
    CLog(@"-- 在约的小伙伴有100人");
}

#pragma mark - 设置值

- (void)setActivitorList:(NSArray *)activitorList {
    _activitorList = activitorList;
    self.yuepaoNumberLabel.text = [NSString stringWithFormat:@"在约的小伙伴%@人", @([_activitorList count])];
    
    [self.yuepaoNumberLabel addUnderlineStyle];
}


@end
