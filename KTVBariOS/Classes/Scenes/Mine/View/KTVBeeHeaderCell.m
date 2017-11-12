//
//  KTVBeeHeaderCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/10/31.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVBeeHeaderCell.h"

@interface KTVBeeHeaderCell()

@property (weak, nonatomic) IBOutlet UIImageView *bigBgImageView;
@property (weak, nonatomic) IBOutlet UIView *photoLibraryBgView; // 相册
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanseLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel; // 今晚是否有约
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *heightLabel;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;

@end

@implementation KTVBeeHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self configRadius:self.heightLabel];
    [self configRadius:self.sexLabel];
    [self configRadius:self.weightLabel];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configRadius:(UIView *)configView {
    configView.layer.cornerRadius = 2.5f;
    configView.layer.masksToBounds = YES;
}

- (void)setUser:(KTVUser *)user {
    if (_user != user) {
        _user = user;
        
        NSString *picUrl = nil;
        if (_user.pictureList.count >= 2) {
            picUrl = _user.pictureList[1].pictureUrl;
        } else if (_user.pictureList.count >= 1) {
            picUrl = _user.pictureList[0].pictureUrl;
        }
        [self.bigBgImageView sd_setImageWithURL:[NSURL URLWithString:picUrl] placeholderImage:[UIImage imageNamed:@"mine_header_placeholder"]];
        [self configPhotoLibrary:_user.pictureList];
        self.addressLabel.text = @"这里是地址";
        self.distanseLabel.text = @"这里是距离100m";
        if (_user.inviteStatus == 0) {
            self.statusLabel.text = @"今晚无约";
        } else if (_user.inviteStatus == 1) {
            self.statusLabel.text = @"今晚已经有约";
        }
        self.moneyLabel.text = [NSString stringWithFormat:@"¥ %@/场", @(_user.userDetail.price)];
        self.heightLabel.text = @"175cm";
        self.sexLabel.text = [NSString stringWithFormat:@"性别%@", _user.gender];
        self.weightLabel.text = @"48kg";
    }
}

- (void)configPhotoLibrary:(NSArray<KTVPicture *> *)photoList {
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self.photoLibraryBgView addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.photoLibraryBgView);
    }];
    
    UIView *horiContentView = [[UIView alloc] init];
    [scrollView addSubview:horiContentView];
    [horiContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(scrollView);
        make.height.equalTo(scrollView);
        //            make.width.equalTo(scrollView);
    }];
    
    
    UIView *lastView = nil;
    for (NSInteger i = 0; i < photoList.count; i++) {
        UIView *itemView = [[UIView alloc] init];
        [horiContentView addSubview:itemView];
        itemView.layer.cornerRadius = 3;
        
        NSString *pictureUrl = photoList[i].pictureUrl;
        
        [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (!lastView) {
                make.left.equalTo(horiContentView).offset(3);
            } else {
                make.left.equalTo(lastView.mas_right).offset(5);
            }
            make.width.height.equalTo(horiContentView.mas_height).multipliedBy(0.9);
            make.centerY.equalTo(horiContentView.mas_centerY);
            if (i == photoList.count) {
                make.right.lessThanOrEqualTo(horiContentView.mas_right).offset(-3);
            }
        }];
        lastView = itemView;
        
        UIImageView *photoImageView = [[UIImageView alloc] init];
        [itemView addSubview:photoImageView];
        [photoImageView sd_setImageWithURL:[NSURL URLWithString:pictureUrl] placeholderImage:[UIImage imageNamed:@"bar_yuepao_user_placeholder"]];
        [photoImageView cornerRadius];
        [photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.and.height.equalTo(itemView);
            make.center.equalTo(itemView);
        }];
    }
}

@end
