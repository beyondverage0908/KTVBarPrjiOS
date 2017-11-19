//
//  KTVPhotoBrowerView.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/11/14.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVPhotoBrowerView.h"

@interface KTVPhotoBrowerView()

@end

@implementation KTVPhotoBrowerView

- (void)showPhotoBrowerConfig:(NSArray<KTVPicture *> *)photoUrlList andDefaultIndex:(NSInteger)index {
    
    UIWindow *superView = [UIApplication sharedApplication].keyWindow;
    [superView addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superView);
    }];
    
    UIView *bgView = [[UIView alloc] init];
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];

    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [bgView addSubview:scrollView];
    scrollView.pagingEnabled = YES;
    scrollView.bounces = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.backgroundColor = [UIColor ktvBG];
    scrollView.canCancelContentTouches = NO;
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(bgView);
    }];

    UIView *horizontalContainerView = [[UIView alloc] init];
    [scrollView addSubview:horizontalContainerView];
    [horizontalContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.height.equalTo(scrollView);
    }];

    UIView *previousView = nil;
    for (NSInteger i = 0; i < [photoUrlList count]; i++) {
        NSString *url = photoUrlList[i].pictureUrl;

        UIView *photoBgView = [[UIView alloc] init];
        [horizontalContainerView addSubview:photoBgView];
        [photoBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (!previousView) {
                make.left.equalTo(horizontalContainerView);
            } else {
                make.left.equalTo(previousView.mas_right);
            }
            make.width.mas_equalTo(@(SCREENW));
            make.height.equalTo(horizontalContainerView);
            if (i == [photoUrlList count] - 1) {
                make.right.equalTo(horizontalContainerView.mas_right);
            }
        }];
        previousView = photoBgView;

        UIImageView *imgView = [[UIImageView alloc] init];
        [photoBgView addSubview:imgView];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        imgView.userInteractionEnabled = YES;
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(photoBgView);
            make.width.lessThanOrEqualTo(photoBgView);
        }];
        [imgView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"user_info_placeholder"]];

        UIButton *dismissBtn = [[UIButton alloc] init];
        [imgView addSubview:dismissBtn];
        [dismissBtn addTarget:self action:@selector(tapImageClick) forControlEvents:UIControlEventTouchUpInside];
        [dismissBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(imgView);
        }];
        
        if (self.opType == KTVEidtType) {
            UIButton *removePhotoBtn = [[UIButton alloc] init];
            [bgView addSubview:removePhotoBtn];
            removePhotoBtn.backgroundColor = [UIColor ktvRed];
            [removePhotoBtn addTarget:self action:@selector(removePhotoClick:) forControlEvents:UIControlEventTouchUpInside];
            [removePhotoBtn setTitle:@"删除" forState:UIControlStateNormal];
            [removePhotoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(bgView);
                make.left.and.right.equalTo(bgView);
                make.height.equalTo(@44);
            }];
        }
    }

    [horizontalContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(previousView.mas_right);
    }];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        scrollView.contentOffset = CGPointMake(index * SCREENW, 0);
    });
}

- (void)tapImageClick {
    [self removeFromSuperview];
}

- (void)removePhotoClick:(UIButton *)btn {
    [KTVToast toast:@"移除中"];
}

@end
