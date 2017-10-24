//
//  KTVDynamicHeaderCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/10/19.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVDynamicHeaderCell.h"

@interface KTVDynamicHeaderCell()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UIImageView *userHeaderImageView;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end

@implementation KTVDynamicHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.headerImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickImageAction:)];
    [self.headerImageView addGestureRecognizer:tap];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setHeaderBgImage:(UIImage *)headerBgImage {
    if (headerBgImage) {
        _headerBgImage = headerBgImage;
        self.headerImageView.image = _headerBgImage;
    }
}

- (void)pickImageAction:(UIButton *)btn {
    if (self.pickHeaderBgImageCallback) {
        self.pickHeaderBgImageCallback();
    }
}

@end
