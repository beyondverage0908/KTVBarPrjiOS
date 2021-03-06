//
//  KTVUserPhotoCollectionCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/5.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVUserPhotoCollectionCell.h"

@interface KTVUserPhotoCollectionCell ()

@property (weak, nonatomic) IBOutlet UIImageView *photoImgView;

@end

@implementation KTVUserPhotoCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setPicture:(KTVPicture *)picture {
    if (_picture != picture) {
        _picture = picture;
        
        [self.photoImgView sd_setImageWithURL:[NSURL URLWithString:_picture.pictureUrl] placeholderImage:[UIImage imageNamed:@"user_info_placeholder"]];
    }
}

@end
