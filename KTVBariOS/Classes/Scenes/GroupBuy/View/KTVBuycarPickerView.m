//
//  KTVBuycarPickerView.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/27.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVBuycarPickerView.h"

@interface KTVBuycarPickerView ()

@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UIView *counterNumberView;

@end

@implementation KTVBuycarPickerView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.counterNumberView.layer.borderWidth = 0.5f;
    self.counterNumberView.layer.borderColor = [UIColor ktvPlaceHolder].CGColor;
}

- (IBAction)reduceNumberAction:(UIButton *)sender {
    NSInteger number = self.numberLabel.text.integerValue;
    --number;
    self.numberLabel.text = @(number).stringValue;
    CLog(@"--->>> 数量减少");
}

- (IBAction)incrementNumberAction:(UIButton *)sender {
    NSInteger number = self.numberLabel.text.integerValue;
    ++number;
    self.numberLabel.text = @(number).stringValue;
    CLog(@"--->>> 数量增加");
}

- (IBAction)cancelAction:(UIButton *)sender {
    CLog(@"--->>> 单点取消");
    [self removeFromSuperview];
}

- (IBAction)confirmAction:(UIButton *)sender {
    CLog(@"--->>> 单点确定");
}

@end
