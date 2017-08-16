//
//  KTVTableHeaderView.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/13.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVTableHeaderView.h"

@implementation KTVTableHeaderView

- (instancetype)initWithImageUrl:(NSString *)headerImageUrl title:(NSString *)headerTitle remark:(NSString *)headerRemark {
    self = [super init];
    if (self) {
        UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainpage_all_bg_line"]];
        [self addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        
        UIView *lastView = nil;
        if (headerImageUrl) {
            UIImageView *headerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:headerImageUrl]];
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


@end
