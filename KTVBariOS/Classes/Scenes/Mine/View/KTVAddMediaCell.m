//
//  KTVAddMediaCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/10/19.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVAddMediaCell.h"
#import "KTVAlertController.h"
#import "KTVMainService.h"

@interface KTVAddMediaCell()

@property (nonatomic, strong) NSArray *mediaList;

@end

@implementation KTVAddMediaCell


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
        for (NSInteger i = 0; i < mediaList.count + 1; i++) {
            UIView *itemView = [[UIView alloc] init];
            [horiContentView addSubview:itemView];
            itemView.layer.cornerRadius = 3;

            [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                if (!lastView) {
                    make.left.equalTo(horiContentView).offset(3);
                } else {
                    make.left.equalTo(lastView.mas_right).offset(5);
                }
                make.width.height.equalTo(horiContentView.mas_height).multipliedBy(0.9);
                make.centerY.equalTo(horiContentView.mas_centerY);
                if (i == mediaList.count) {
                    make.right.lessThanOrEqualTo(horiContentView.mas_right).offset(-3);
                }
            }];
            lastView = itemView;

            if (i == 0) {
                itemView.layer.borderColor = [UIColor whiteColor].CGColor;
                itemView.layer.borderWidth = 1.0;
                
                UIButton *addImgBtn = [[UIButton alloc] init];
                [itemView addSubview:addImgBtn];
                [addImgBtn addTarget:self action:@selector(pickImageAction:) forControlEvents:UIControlEventTouchUpInside];
                [addImgBtn setBackgroundImage:[UIImage imageNamed:@"mine_apply_store"] forState:UIControlStateNormal];
                [addImgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.width.and.height.equalTo(itemView).multipliedBy(0.8);
                    make.center.equalTo(itemView);
                }];
            } else {
                UIImageView *imageHolder = [[UIImageView alloc] init];
                [itemView addSubview:imageHolder];
                imageHolder.layer.cornerRadius = 3;
                imageHolder.layer.masksToBounds = YES;
                imageHolder.userInteractionEnabled = YES;
                imageHolder.tag = 1000 + i - 1;
                
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap:)];
                [imageHolder addGestureRecognizer:tap];
            
                id img = mediaList[i-1];
                if ([img isKindOfClass:[NSString class]]) {
                    NSString *imgStr = (NSString *)img;
                    [imageHolder sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:[UIImage imageNamed:imgStr]];
                } else if ([img isKindOfClass:[UIImage class]]) {
                    UIImage *image = (UIImage *)img;
                    imageHolder.image = image;
                } else if ([img isKindOfClass:[KTVVideo class]]) {
                    KTVVideo *video = (KTVVideo *)img;
                    [imageHolder thumbnailFromVideoUrl:video.url];
                    
                    //初始化一个长按手势
                    UILongPressGestureRecognizer *longPressGest = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressView:)];
                    //长按等待时间
                    longPressGest.minimumPressDuration = 1.5;
                    //长按时候,手指头可以移动的距离
                    longPressGest.allowableMovement = 30;
                    [imageHolder addGestureRecognizer:longPressGest];
                }
                [imageHolder mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.width.and.height.equalTo(itemView);
                    make.center.equalTo(itemView);
                }];
            }
        }
    }
    return self;
}

#pragma mark - 事件

- (void)pickImageAction:(UIButton *)btn {
    CLog(@"-->> 上传图片");
    if (self.pickImageCallback) {
        self.pickImageCallback(self.mediaType);
    }
}

- (void)imageTap:(UITapGestureRecognizer *)tap {
    NSInteger tag = tap.view.tag - 1000;
    if (self.showMediaCallback) {
        id media = self.mediaList[tag];
        self.showMediaCallback(media);
    }
    CLog(@"--->> 点击图片 %@", @(tag));
}

- (void)longPressView:(UILongPressGestureRecognizer *)longPressGest{
    UIView *longView = longPressGest.view;
    NSInteger idx = longView.tag - 1000;
    if (longPressGest.state==UIGestureRecognizerStateBegan) {
        if (self.longPressMediaCallback) {
            KTVVideo *video = self.mediaList[idx];
            self.longPressMediaCallback(video);
        }
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
