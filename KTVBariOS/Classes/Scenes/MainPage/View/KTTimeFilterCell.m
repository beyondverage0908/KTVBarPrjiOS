//
//  KTVScrollTimeCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/13.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTTimeFilterCell.h"

@interface KTTimeFilterCell ()

@property (nonatomic, strong) NSArray<NSString *> *filterItems;

@end

@implementation KTTimeFilterCell

- (instancetype)initWithItems:(NSArray *)items reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.filterItems = items;
        
        UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainpage_all_bg_line"]];
        [self.contentView addSubview:bgImageView];
        [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        [self.contentView addSubview:scrollView];
        scrollView.bounces = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        
        UIView *horizontalContainerView = [[UIView alloc] init];
        [scrollView addSubview:horizontalContainerView];
        [horizontalContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(scrollView);
            make.height.equalTo(scrollView);
        }];
        
        CGFloat w = 375.0f / 6.0f;
        UIButton *lastBtn = nil;
        for (NSInteger i = 0; i < [items count]; i++) {
            
            UIButton *btn = [[UIButton alloc] init];
            [horizontalContainerView addSubview:btn];
            btn.tag = i + 1000;
            [btn addTarget:self action:@selector(timeFilterAction:) forControlEvents:UIControlEventTouchUpInside];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@(w));
                make.height.equalTo(horizontalContainerView);
                if (!lastBtn) {
                    make.left.equalTo(horizontalContainerView);
                } else {
                    make.left.equalTo(lastBtn.mas_right);
                }
            }];
            lastBtn = btn;
            
            NSArray *arr = [items[i] componentsSeparatedByString:@";"];
            
            UILabel *titleLabel = [[UILabel alloc] init];
            [btn addSubview:titleLabel];
            titleLabel.text = arr[0];
            titleLabel.font = [UIFont boldSystemFontOfSize:14];
            titleLabel.textColor = [UIColor whiteColor];
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(btn);
                make.top.equalTo(btn).offset(7);
            }];
            
            UILabel *numLabel = [[UILabel alloc] init];
            [btn addSubview:numLabel];
            numLabel.text = arr[1];
            numLabel.font = [UIFont boldSystemFontOfSize:14];
            numLabel.textColor = [UIColor whiteColor];
            [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(btn);
                make.top.equalTo(titleLabel.mas_bottom).offset(5);
            }];
        }
        
        [horizontalContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(lastBtn.mas_right);
        }];
    }
    return self;
}

- (void)timeFilterAction:(UIButton *)timeBtn {
    // 默认变成白色背景
    for (UIView *sub in timeBtn.superview.subviews) {
        if ([sub isKindOfClass:[UIButton class]]) {
            for (UIView *ssub in sub.subviews) {
                if ([ssub isKindOfClass:[UILabel class]]) {
                    ((UILabel *)ssub).textColor = [UIColor whiteColor];
                }
            }
        }
    }
    
    // 选中颜色
    for (UIView *sub in timeBtn.subviews) {
        if ([sub isKindOfClass:[UILabel class]]) {
            ((UILabel *)sub).textColor = [UIColor ktvFilterColor];
        }
    }
    
    NSInteger idx = timeBtn.tag - 1000;
    CLog(@"---->> %@", self.filterItems[idx]);
    if (self.filterCallback) {
        self.filterCallback(idx);
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
