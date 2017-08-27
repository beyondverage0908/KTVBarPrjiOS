//
//  KTVBuycarSummaryCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/27.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVBuycarSummaryCell.h"

@interface KTVBuycarSummaryCell ()

@property (weak, nonatomic) IBOutlet UIImageView *itemImageview;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *summaryMoneyLabel;
@property (weak, nonatomic) IBOutlet UIView *counterView;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@end

@implementation KTVBuycarSummaryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.counterView.layer.borderWidth = 0.5f;
    self.counterView.layer.borderColor = [UIColor ktvPlaceHolder].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
- (IBAction)reduceAction:(UIButton *)sender {
    CLog(@"--->>> 减少一");
    NSInteger number = self.numberLabel.text.integerValue;
    --number;
    self.numberLabel.text = @(number).stringValue;
}

- (IBAction)incrementAction:(UIButton *)sender {
    CLog(@"--->>> 增加一");
    NSInteger number = self.numberLabel.text.integerValue;
    ++number;
    self.numberLabel.text = @(number).stringValue;
}
@end
