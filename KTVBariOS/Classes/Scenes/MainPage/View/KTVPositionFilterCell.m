//
//  KTVPositionFilterCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/13.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVPositionFilterCell.h"

@interface KTVPositionFilterCell ()

@property (nonatomic, strong) NSArray<NSString *> *filterItems;

@end

@implementation KTVPositionFilterCell

- (instancetype)initWithPositionFilterItems:(NSArray *)items reuseIdentifier:(NSString *)reuseIdentifier {
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
        
        UIButton *lastBtn = nil;
        for (NSInteger i = 0; i < [items count]; i++) {
            
            UIButton *btn = [[UIButton alloc] init];
            [horizontalContainerView addSubview:btn];
            btn.tag = i + 1000;
            [btn addTarget:self action:@selector(positionFilterAction:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:items[i] forState:UIControlStateNormal];
            [self changeBtnStyleFilterColor:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(horizontalContainerView).multipliedBy(0.5);
                make.centerY.equalTo(horizontalContainerView);
                if (!lastBtn) {
                    make.left.equalTo(horizontalContainerView).offset(5);
                } else {
                    make.left.equalTo(lastBtn.mas_right).offset(10);
                }
            }];
            lastBtn = btn;
        }
        
        [horizontalContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(lastBtn.mas_right).offset(5);
        }];
    }
    return self;
}

- (void)changeBtnStyleFilterColor:(UIButton *)btn {
    btn.layer.borderColor = [UIColor ktvGray].CGColor;
    btn.layer.borderWidth = 0.8f;
    btn.layer.cornerRadius = 2;
    [btn setTitleColor:[UIColor ktvGray] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    btn.contentEdgeInsets = UIEdgeInsetsMake(5, 7, 5, 7);
    [btn setBackgroundImage:nil forState:UIControlStateNormal];
}

- (void)positionFilterAction:(UIButton *)timeBtn {
    // 默认选中颜色
    for (UIView *sub in timeBtn.superview.subviews) {
        if ([sub isKindOfClass:[UIButton class]]) {
            [self changeBtnStyleFilterColor:((UIButton *)sub)];
        }
    }
    
    // 选中颜色->白色
    [timeBtn setTitleColor:[UIColor ktvFilterColor] forState:UIControlStateNormal];
    timeBtn.layer.borderColor = [UIColor ktvFilterColor].CGColor;
    [timeBtn setBackgroundImage:[UIImage imageNamed:@"app_filter_gou"] forState:UIControlStateNormal];

    NSInteger idx = timeBtn.tag - 1000;
    CLog(@"---->> 位置过滤%@", self.filterItems[idx]);
}

@end
