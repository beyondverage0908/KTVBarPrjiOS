//
//  KTVDynamicPictureCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/10/19.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVDynamicPictureCell.h"

@interface KTVDynamicPictureCell()

@property (weak, nonatomic) IBOutlet UITextView *dynamicExplainTextView;
@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondBtn;
@property (weak, nonatomic) IBOutlet UIButton *thirdBtn;

@end

@implementation KTVDynamicPictureCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.firstBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.firstBtn.layer.borderWidth = 1.0;
    self.firstBtn.layer.cornerRadius = 3;
    self.secondBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.secondBtn.layer.borderWidth = 1.0;
    self.secondBtn.layer.cornerRadius = 3;
    self.thirdBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.thirdBtn.layer.borderWidth = 1.0;
    self.thirdBtn.layer.cornerRadius = 3;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - 事件

- (IBAction)firstAction:(UIButton *)sender {
    CLog(@"-->> 第一个按钮");
}

- (IBAction)secondAction:(UIButton *)sender {
    CLog(@"-->> 第二个按钮");
}

- (IBAction)thirdAction:(UIButton *)sender {
    CLog(@"-->> 第三个按钮");
}


@end
