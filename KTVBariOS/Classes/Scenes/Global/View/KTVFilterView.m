//
//  KTVFilterView.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/12.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVFilterView.h"

@interface KTVFilterView ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray<NSDictionary<NSString *, NSArray *> *> *filters;

@property (strong, nonatomic) UIView *bkMaskView;

@property (strong, nonatomic) NSDictionary<NSString *, NSArray *> *filterSectionDic;

@property (nonatomic, copy) void (^filterDetaiSelectedCallbadk)(NSString *filterDetail);

@end

@implementation KTVFilterView

- (instancetype)initWithFilter:(NSArray<NSDictionary<NSString *, NSArray *> *> *)filters{
    self = [super init];
    if (self) {
        
        self.filters = [filters copy];
        
        if ([self.filters count]) {
            UIImageView *bgImageView = [[UIImageView alloc] init];
            bgImageView.image = [UIImage imageNamed:@"mainpage_all_bg_line"];
            bgImageView.userInteractionEnabled = YES;
            [self addSubview:bgImageView];
            [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self);
            }];
            
            CGFloat wp = 1.0f / [self.filters count];
            UIButton *lastBtn = nil;
            for (NSInteger i = 0; i < [self.filters count]; i++) {
                
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
                titleLabel.tag = 2000 + i;
                titleLabel.text = [self.filters[i].allKeys firstObject];
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
    return self;
}

- (void)remove {
    [self.bkMaskView removeFromSuperview];
    self.bkMaskView = nil;
}


- (void)filterBtnAction:(UIButton *)filterBtn {
    NSInteger idx = filterBtn.tag - 1000;
    
    NSDictionary *filterDict = nil;
    if ([self.filters count] > idx) {
        filterDict = self.filters[idx];
    }
    if (self.filterCallback) {
        self.filterCallback(idx, filterDict);
    }

    self.filterSectionDic = filterDict;
    [self showFilterDetailView];
    
    self.filterDetaiSelectedCallbadk = ^(NSString *filterDetail) {
        UILabel *titleLabel = [filterBtn viewWithTag:idx + 2000];
        titleLabel.text = filterDetail;
    };
}

- (void)maskFilterTapAction:(UITapGestureRecognizer *)tap {
    [self remove];
}

- (void)showFilterDetailView {
    // 生成筛选列表
    if (self.bkMaskView) {
        [self.bkMaskView removeFromSuperview];
        self.bkMaskView = nil;
    }
    UIView *superView = [UIApplication sharedApplication].keyWindow;
    self.bkMaskView = [[UIView alloc] init];
    self.bkMaskView.backgroundColor = [UIColor clearColor];
    [superView addSubview:self.bkMaskView];
    [self.bkMaskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superView);
    }];
    
    UIView *maskFilterView = [[UIView alloc] init];
    [self.bkMaskView addSubview:maskFilterView];
    maskFilterView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.3];
    [maskFilterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.and.bottom.equalTo(self.bkMaskView);
        if (@available(iOS 11.0, *)) {
            if (iPhoneX) {
                make.top.equalTo(self.bkMaskView.mas_safeAreaLayoutGuideTop).offset(44 + 40);
            } else {
                make.top.equalTo(self.bkMaskView.mas_safeAreaLayoutGuideTop).offset(64 + 40);
            }
        } else {
            // Fallback on earlier versions
            make.top.equalTo(self.bkMaskView.mas_top).offset(64 + 40);
        }
    }];
    
    UIView *filterBgView = [[UIView alloc] init];
    [maskFilterView addSubview:filterBgView];
    filterBgView.backgroundColor = [UIColor yellowColor];
    [filterBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.and.left.equalTo(maskFilterView);
        make.height.equalTo(maskFilterView.mas_height).multipliedBy(0.5);
    }];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [filterBgView addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(filterBgView);
    }];
    
    UIView *blackView = [[UIView alloc] init];
    [maskFilterView addSubview:blackView];
    [blackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(filterBgView.mas_bottom);
        make.left.right.and.bottom.equalTo(maskFilterView);
    }];
    UITapGestureRecognizer *maskFilterTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskFilterTapAction:)];
    [blackView addGestureRecognizer:maskFilterTap];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *key = self.filterSectionDic.allKeys.firstObject;
    NSArray *filterList = [self.filterSectionDic objectForKey:key];
    return filterList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"filterCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSString *key = self.filterSectionDic.allKeys.firstObject;
    NSArray *filterList = [self.filterSectionDic objectForKey:key];
    NSString *item = filterList[indexPath.row];
    cell.textLabel.text = item;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self remove];
    
    NSString *key = self.filterSectionDic.allKeys.firstObject;
    NSArray *filterList = [self.filterSectionDic objectForKey:key];
    NSString *item = filterList[indexPath.row];
    
    if (self.filterDitailCallback) {
        self.filterDitailCallback(item);
    }
    if (self.filterDetaiSelectedCallbadk) {
        self.filterDetaiSelectedCallbadk(item);
    }
}


@end
