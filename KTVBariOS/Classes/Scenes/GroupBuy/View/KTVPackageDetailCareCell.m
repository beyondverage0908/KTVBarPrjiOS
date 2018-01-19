//
//  KTVPackageDetailCareCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/24.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVPackageDetailCareCell.h"

@interface KTVPackageDetailCareCell ()

@property (weak, nonatomic) IBOutlet UILabel *carefulNameLabel; // 有效期
@property (weak, nonatomic) IBOutlet UILabel *carefulDetailLabel; //

@end

@implementation KTVPackageDetailCareCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setPackage:(KTVPackage *)package {
    _package = package;
    
    self.carefulNameLabel.text = @"套餐使用时长";
    self.carefulDetailLabel.text = _package.belong;
}

@end
