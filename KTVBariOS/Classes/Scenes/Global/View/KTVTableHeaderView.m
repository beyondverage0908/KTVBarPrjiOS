//
//  KTVTableHeaderView.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/13.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVTableHeaderView.h"

@implementation KTVTableHeaderView

- (instancetype)initWithImageUrl:(NSString *)leadingImgUrl title:(NSString *)headerTitle headerImgUrl:(NSString *)headerUrl remark:(NSString *)headerRemark {
    self = [super init];
    if (self) {
        UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainpage_all_bg_line"]];
        [self addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        
        UIView *lastView = nil;
        if (leadingImgUrl) {
            UIImageView *headerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:leadingImgUrl]];
            [self addSubview:headerImageView];
            [headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.left.equalTo(self).offset(10);
                make.width.height.equalTo(self.mas_height).multipliedBy(0.5);
            }];
            lastView = headerImageView;
        } else {
            UIView *leftLine = [[UIView alloc] init];
            [self addSubview:leftLine];
            leftLine.backgroundColor = [UIColor ktvRed];
            [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.height.equalTo(self).multipliedBy(0.6);
                make.width.equalTo(@2);
                make.left.equalTo(self);
            }];
            lastView = leftLine;
        }
        
        
        if (headerTitle) {
            UILabel *titleLabel = [[UILabel alloc] init];
            [self addSubview:titleLabel];
            titleLabel.text = headerTitle;
            titleLabel.font = [UIFont boldSystemFontOfSize:14];
            titleLabel.textColor = [UIColor whiteColor];
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.left.equalTo(lastView.mas_right).offset(10);
            }];
            lastView = titleLabel;
        }
        
        if (headerUrl) {
            UIButton *headerBtn = [[UIButton alloc] init];
            [headerBtn setImage:[UIImage imageNamed:headerUrl] forState:UIControlStateNormal];
            [headerBtn addTarget:self action:@selector(headerBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:headerBtn];
            [headerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.left.equalTo(lastView.mas_right).offset(10);
            }];
            lastView = headerBtn;
        }
        
        if (headerRemark) {
            UILabel *remarkLabel = [[UILabel alloc] init];
            [self addSubview:remarkLabel];
            remarkLabel.text = headerRemark;
            remarkLabel.font = [UIFont boldSystemFontOfSize:12.5];
            remarkLabel.textColor = [UIColor ktvGray];
            [remarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.right.equalTo(self).offset(-10);
            }];
        }
    }
    return self;
}

- (instancetype)initWithImageUrl:(NSString *)leadingImgUrl title:(NSString *)headerTitle remark:(NSString *)headerRemark {
    return [self initWithImageUrl:leadingImgUrl title:headerTitle headerImgUrl:nil remark:headerRemark];
}


#pragma mark - 事件

- (void)headerBtnAction:(UIButton *)btn {
    if (_headerActionBlock) {
        self.headerActionBlock(btn);
    }
}

@end
