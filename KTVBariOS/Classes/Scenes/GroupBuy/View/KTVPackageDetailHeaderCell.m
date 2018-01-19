//
//  KTVPackageDetailHeaderCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/24.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVPackageDetailHeaderCell.h"

@interface KTVPackageDetailHeaderCell ()

@property (weak, nonatomic) IBOutlet UIImageView *packageDetailPlaceholderImageView;
@property (weak, nonatomic) IBOutlet UILabel *packageNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *packageMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *oldMoneyLabel;

@end

@implementation KTVPackageDetailHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setPackage:(KTVPackage *)package {
    if (_package != package) {
        _package = package;
        
        self.packageNameLabel.text = _package.packageName;
        self.packageMoneyLabel.text = [NSString stringWithFormat:@"¥%@", _package.price];
        self.oldMoneyLabel.text = [NSString stringWithFormat:@"门市价:%@", _package.realPrice];
    }
}

@end
