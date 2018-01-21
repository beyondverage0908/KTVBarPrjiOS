//
//  KTVSimpleFilter.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/27.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVSimpleFilter.h"

@interface KTVSimpleFilter ()

@property (strong, nonatomic) NSMutableDictionary *containerDict;

@end

@implementation KTVSimpleFilter

- (void)setFilters:(NSArray<NSString *> *)filters {
    _filters = filters;
    
    if (filters.count <= 0) {
        return;
    }
    
    self.containerDict = [NSMutableDictionary dictionaryWithCapacity:filters.count];
    
    UIView *bgView = [[UIView alloc] init];
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainpage_all_bg_line"]];
    [bgView addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(bgView);
    }];
    
    CGFloat w = SCREENW / filters.count;

    UIView *lastView = nil;
    for (NSInteger i = 0; i < filters.count; i++) {
        UIView *itemBgView = [[UIView alloc] init];
        [bgView addSubview:itemBgView];
        [itemBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(bgView);
            make.width.mas_equalTo(@(w));
            if (i == 0) {
                make.left.equalTo(bgView);
            } else {
                make.left.equalTo(lastView.mas_right);
            }
        }];
        lastView = itemBgView;
        
        [self.containerDict setObject:itemBgView forKey:@(i).stringValue];
        
        UIButton *btn = [[UIButton alloc] init];
        [itemBgView addSubview:btn];
        btn.tag = 2000 + i;
        [btn setTitle:filters[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        if (i == 0) {
            [btn setTitleColor:[UIColor ktvRed] forState:UIControlStateNormal];
        }
        btn.titleLabel.font = [UIFont bold17];
        [btn addTarget:self action:@selector(filterAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(itemBgView);
            make.bottom.equalTo(itemBgView).offset(-4);
        }];
        
        UILabel *bottomView = [[UILabel alloc] init];
        [itemBgView addSubview:bottomView];
        bottomView.tag = 1000 + i;
        if (i == 0) {
            bottomView.backgroundColor = [UIColor ktvRed];
        } else {
            bottomView.backgroundColor = [UIColor clearColor];
        }
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@1.5);
            make.centerX.equalTo(itemBgView);
            make.bottom.equalTo(itemBgView);
            make.width.equalTo(itemBgView.mas_width).multipliedBy(0.6f);
        }];
        
        if (i < filters.count - 1) {
            UIView *sepView = [[UIView alloc] init];
            [itemBgView addSubview:sepView];
            sepView.backgroundColor = [UIColor whiteColor];
            [sepView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(itemBgView.mas_height).multipliedBy(0.5f);
                make.width.equalTo(@1.5);
                make.right.equalTo(itemBgView);
                make.centerY.equalTo(itemBgView);
            }];
        }
    }
}

- (void)filterAction:(UIButton *)btn {
    [self changeActionLayer:btn];
    NSInteger idx = btn.tag - 2000;
    CLog(@"--->>> %@", self.filters[idx]);
    
    @WeakObj(self);
    if (self.filterCallfback) {
        weakself.filterCallfback(idx);
    }
}

- (void)changeActionLayer:(UIButton *)btn {
    NSInteger idx = btn.tag - 2000;
    
    NSString *selKey = @(idx).stringValue;
    
    for (NSString *key in self.containerDict.allKeys) {
        UIView *itemBgView = self.containerDict[key];
        for (UIView *view in itemBgView.subviews) {
            if ([view isKindOfClass:[UIButton class]]) {
                if (![selKey isEqualToString:key]) {
                    [(UIButton *)view setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                } else {
                    [(UIButton *)view setTitleColor:[UIColor ktvRed] forState:UIControlStateNormal];
                }
                
            }
            
            if ([view isKindOfClass:[UILabel class]]) {
                [(UILabel *)view setBackgroundColor:[UIColor clearColor]];
            }
        }
    }
    
    NSInteger bottomIdx = idx + 1000;
    UIView *btmLine = [btn.superview viewWithTag:bottomIdx];
    [btmLine setBackgroundColor:[UIColor ktvRed]];
}

@end
