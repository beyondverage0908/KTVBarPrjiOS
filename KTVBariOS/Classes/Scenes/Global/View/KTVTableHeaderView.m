//
//  KTVTableHeaderView.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/13.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVTableHeaderView.h"

@interface KTVTableHeaderView()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *remarkLabel;

@end


@implementation KTVTableHeaderView

- (instancetype)initWithImageUrl:(NSString *)leadingImgUrl title:(NSString *)headerTitle headerImgUrl:(NSString *)headerUrl remarkUrl:(NSString *)remarkUrl remark:(NSString *)headerRemark {
    self = [super init];
    if (self) {
    
        UIButton *bgView = [[UIButton alloc] init];
        [self addSubview:bgView];
        [bgView setBackgroundImage:[UIImage imageNamed:@"mainpage_all_bg_line"]
                          forState:UIControlStateNormal];
        [bgView addTarget:self action:@selector(bgBtnAction:) forControlEvents:UIControlEventTouchUpInside];
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
            self.titleLabel = [[UILabel alloc] init];
            [self addSubview:self.titleLabel];
            self.titleLabel.text = headerTitle;
            self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
            self.titleLabel.textColor = [UIColor whiteColor];
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.left.equalTo(lastView.mas_right).offset(10);
            }];
            lastView = self.titleLabel;
        }
        
        if (headerUrl) {
            UIButton *headerBtn = [[UIButton alloc] init];
            [headerBtn setImage:[UIImage imageNamed:headerUrl] forState:UIControlStateNormal];
            [headerBtn addTarget:self action:@selector(headerBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:headerBtn];
            headerBtn.tag = 10001;
            [headerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.left.equalTo(lastView.mas_right).offset(10);
            }];
            lastView = headerBtn;
        }
        
        UIView *rightLastView = nil;
        if (headerRemark) {
            self.remarkLabel = [[UILabel alloc] init];
            [self addSubview:self.remarkLabel];
            self.remarkLabel.text = headerRemark;
            self.remarkLabel.font = [UIFont boldSystemFontOfSize:12.5];
            self.remarkLabel.textColor = [UIColor ktvGray];
            [self.remarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.right.equalTo(self).offset(-10);
            }];
            
            rightLastView = self.remarkLabel;
        }
    
        if (remarkUrl) {
            UIButton *remarkBtn = [[UIButton alloc] init];
            [remarkBtn setImage:[UIImage imageNamed:remarkUrl] forState:UIControlStateNormal];
            [remarkBtn addTarget:self action:@selector(headerBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:remarkBtn];
            remarkBtn.tag = 10002;
            [remarkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                if (rightLastView) {
                    make.right.equalTo(rightLastView.mas_left).offset(-10);
                } else {
                    make.right.equalTo(self).offset(-10);
                }
            }];
        }
    }
    return self;
}

- (instancetype)initWithImageUrl:(NSString *)leadingImgUrl title:(NSString *)headerTitle headerImgUrl:(NSString *)headerUrl remark:(NSString *)headerRemark {
    return [self initWithImageUrl:leadingImgUrl title:headerTitle headerImgUrl:headerUrl remarkUrl:nil remark:headerRemark];
}

- (instancetype)initWithImageUrl:(NSString *)leadingImgUrl title:(NSString *)headerTitle remark:(NSString *)headerRemark {
    return [self initWithImageUrl:leadingImgUrl title:headerTitle headerImgUrl:nil remark:headerRemark];
}

#pragma mark - override setter

- (void)setTitle:(NSString *)title {
    if (_title != title) {
        _title = title;
        
        self.titleLabel.text = [NSString stringWithFormat:@"%@", title];
    }
}

- (void)setRemark:(NSString *)remark {
    if (_remark != remark) {
        _remark = remark;
        
        self.remarkLabel.text = [NSString stringWithFormat:@"%@", remark];
    }
}


#pragma mark - 事件

- (void)headerBtnAction:(UIButton *)btn {
    if (_headerActionBlock) {
        if (btn.tag == 10001) {
            self.headerActionBlock(self, HeaderType);
        } else if (btn.tag == 10002) {
            self.headerActionBlock(self, RemarkType);
        }
    }
}

- (void)bgBtnAction:(UIButton *)btn {
    if (self.bgActionBlock) {
        self.bgActionBlock(self, BGType);
    }
}

@end
