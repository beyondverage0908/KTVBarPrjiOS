//
//  KTVCollectionFilterView.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/27.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVCollectionFilterView.h"

@interface KTVCollectionFilterView ()


@end

@implementation KTVCollectionFilterView

- (void)setFilters:(NSArray<NSString *> *)filters {
    _filters = filters;
    
    if ([filters count]) {
        UIImageView *bgImageView = [[UIImageView alloc] init];
        bgImageView.image = [UIImage imageNamed:@"mainpage_all_bg_line"];
        bgImageView.userInteractionEnabled = YES;
        [self addSubview:bgImageView];
        [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        CGFloat wp = 1.0f / [filters count];
        UIButton *lastBtn = nil;
        for (NSInteger i = 0; i < [filters count]; i++) {
            
            UIButton *btn = [[UIButton alloc] init];
            [bgImageView addSubview:btn];
            btn.tag = 1000 + i;
            [btn addTarget:self action:@selector(filterBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(bgImageView);
                make.width.equalTo(bgImageView).multipliedBy(wp);
                make.centerY.equalTo(bgImageView);
                if (!lastBtn) {
                    make.left.equalTo(bgImageView);
                } else {
                    make.left.equalTo(lastBtn.mas_right);
                }
            }];
            lastBtn = btn;
            
            
            UILabel *titleLabel = [[UILabel alloc] init];
            [btn addSubview:titleLabel];
            titleLabel.text = filters[i];
            titleLabel.textColor = [UIColor whiteColor];
            titleLabel.font = [UIFont boldSystemFontOfSize:13];
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(btn);
                make.centerX.offset(-5);
            }];
            
            UIImageView *sanImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_filter_sanjiao"]];
            [btn addSubview:sanImageView];
            [sanImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(titleLabel.mas_right).offset(5);
                make.centerY.equalTo(btn);
            }];
            
            
            if (i > 0) {
                UIView *verLine = [[UIView alloc] init];
                [btn addSubview:verLine];
                verLine.backgroundColor = [UIColor whiteColor];
                [verLine mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(@1.5);
                    make.centerY.equalTo(btn);
                    make.height.equalTo(btn).multipliedBy(0.5f);
                    make.left.equalTo(btn.mas_left);
                }];
                
            }
        }
    }
}


- (void)filterBtnAction:(UIButton *)filterBtn {
    NSInteger idx = filterBtn.tag - 1000;
    CLog(@"筛选--CollectionVeiw--->>>%@", self.filters[idx]);
}

@end
