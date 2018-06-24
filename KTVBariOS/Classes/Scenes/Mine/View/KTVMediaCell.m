//
//  KTVMediaCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/11/19.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVMediaCell.h"

@interface KTVMediaCell()

@property (nonatomic, strong) NSArray *mediaList;

@end

@implementation KTVMediaCell

- (instancetype)initWithMediaList:(NSArray *)mediaList style:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.mediaList = mediaList;
        
        UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainpage_all_bg_line"]];
        [self.contentView addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        [self.contentView addSubview:scrollView];
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        
        UIView *horiContentView = [[UIView alloc] init];
        [scrollView addSubview:horiContentView];
        [horiContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.equalTo(scrollView);
            make.height.equalTo(scrollView);
            //            make.width.equalTo(scrollView);
        }];
        
        
        UIView *lastView = nil;
        for (NSInteger i = 0; i < mediaList.count; i++) {
            UIView *itemView = [[UIView alloc] init];
            [horiContentView addSubview:itemView];
            itemView.layer.cornerRadius = 5;
            itemView.layer.borderWidth = 1;
            itemView.layer.borderColor = [UIColor whiteColor].CGColor;
            
            [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                if (!lastView) {
                    make.left.equalTo(horiContentView).offset(3);
                } else {
                    make.left.equalTo(lastView.mas_right).offset(5);
                }
                make.width.height.equalTo(horiContentView.mas_height).multipliedBy(0.9);
                make.centerY.equalTo(horiContentView.mas_centerY);
                if (i == mediaList.count - 1) {
                    make.right.lessThanOrEqualTo(horiContentView.mas_right).offset(-3);
                }
            }];
            lastView = itemView;
            
            UIImageView *imageHolder = [[UIImageView alloc] init];
            [itemView addSubview:imageHolder];
            imageHolder.layer.cornerRadius = 3;
            imageHolder.layer.masksToBounds = YES;
            imageHolder.userInteractionEnabled = YES;
            imageHolder.tag = 1000 + i;
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap:)];
            [imageHolder addGestureRecognizer:tap];
            
            id img = mediaList[i];
            if ([img isKindOfClass:[NSString class]]) {
                NSString *imgStr = (NSString *)img;
                [imageHolder sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:[UIImage imageNamed:imgStr]];
            } else if ([img isKindOfClass:[UIImage class]]) {
                UIImage *image = (UIImage *)img;
                imageHolder.image = image;
            } else if ([img isKindOfClass:[KTVVideo class]]) {
                KTVVideo *video = (KTVVideo *)img;
                //                    imageHolder.image = [KTVUtil thumbnailFromVideoUrl:video.url];
                [imageHolder thumbnailFromVideoUrl:video.url];
            }
            [imageHolder mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.and.height.equalTo(itemView);
                make.center.equalTo(itemView);
            }];
            
            UIButton *payBtn = [[UIButton alloc] init];
            [itemView addSubview:payBtn];
            [payBtn setBackgroundImage:[UIImage imageNamed:@"ktv_vedio_play"] forState:UIControlStateNormal];
            [payBtn addTarget:self action:@selector(payVedioAction:) forControlEvents:UIControlEventTouchUpInside];
            payBtn.tag = 10000 + i;
            [payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(itemView);
            }];
        }
    }
    return self;
}

#pragma mark - 事件

- (void)imageTap:(UITapGestureRecognizer *)tap {
    NSInteger tag = tap.view.tag - 1000;
    
    if (self.showMediaCallback) {
        id media = self.mediaList[tag];
        self.showMediaCallback(media);
    }
    CLog(@"--->> 点击图片 %@", @(tag));
}

- (void)payVedioAction:(UIButton *)btn {
    NSInteger tag = btn.tag - 10000;
    
    if (self.showMediaCallback) {
        id media = self.mediaList[tag];
        self.showMediaCallback(media);
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
