//
//  KTVPhotoBrowerView.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/11/14.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVPhotoBrowerView.h"
#import "KTVMainService.h"

@interface KTVPhotoBrowerView()<UIScrollViewDelegate>

@property (nonatomic, assign) NSInteger currentPageIndex;
@property (strong, nonatomic) NSMutableArray<KTVPicture *> *photoList;

@end

@implementation KTVPhotoBrowerView

- (void)showPhotoBrowerConfig:(NSArray<KTVPicture *> *)photoUrlList andDefaultIndex:(NSInteger)index {
    
    self.photoList = photoUrlList;
    
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
    scrollView.delegate = self;
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
    }
    
    if (self.opType == KTVEditType) {
        UIButton *removePhotoBtn = [[UIButton alloc] init];
        [bgView addSubview:removePhotoBtn];
        [removePhotoBtn setImage:[UIImage imageNamed:@"app_photo_delete"] forState:UIControlStateNormal];
        [removePhotoBtn addTarget:self action:@selector(removePhotoClick:) forControlEvents:UIControlEventTouchUpInside];
        [removePhotoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bgView).offset(20);
            make.right.equalTo(bgView).offset(-10);
            make.width.equalTo(@80);
            make.height.equalTo(@80);
        }];
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
    NSString *phone = [KTVCommon userInfo].username;
    if (![KTVUtil isNullString:phone]) {
        KTVPicture *pic = self.photoList[self.currentPageIndex];
        
        NSDictionary *params = @{@"username" : phone, @"pictureId" : pic.pictureId};
        [KTVMainService postDeleteUserPhoto:params result:^(NSDictionary *result) {
            if ([result[@"code"] isEqualToString:ktvCode]) {
                [KTVToast toast:TOAST_DELETE_SUCC];
            } else {
                [KTVToast toast:TOAST_DELETE_FAIL];
            }
        }];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    self.currentPageIndex = offsetX / SCREENW;
}

@end
