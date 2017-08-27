//
//  KTVPackageDetailCareCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/24.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVPackageDetailCareCell.h"

@interface KTVPackageDetailCareCell ()

@property (weak, nonatomic) IBOutlet UILabel *carefulNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *carefulDetailLabel;

@end

@implementation KTVPackageDetailCareCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
