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

@property (strong, nonatomic) UIView *maskFilterView;

@property (strong, nonatomic) NSDictionary<NSString *, NSArray *> *filterSectionDic;

@property (nonatomic, copy) void (^filterDetaiSelectedCallbadk)(NSString *filterDetail);

@end

@implementation KTVFilterView

- (instancetype)initWithFilter:(NSArray<NSDictionary<NSString *, NSArray *> *> *)filters{
    self = [super init];
    if (self) {
        
        self.filters = filters;
        
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
                titleLabel.tag = 2000 + i;
                titleLabel.text = [filters[i].allKeys firstObject];
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
    [self.maskFilterView removeFromSuperview];
    self.maskFilterView = nil;
}


- (void)filterBtnAction:(UIButton *)filterBtn {
    NSInteger idx = filterBtn.tag - 1000;
    if (self.filterCallback) {
        self.filterCallback(self.filters[idx]);
    }

    self.filterSectionDic = self.filters[idx];
    [self showFilterDetailView];
    
    self.filterDetaiSelectedCallbadk = ^(NSString *filterDetail) {
        UILabel *titleLabel = [filterBtn viewWithTag:idx + 2000];
        titleLabel.text = filterDetail;
    };
}

- (void)showFilterDetailView {
    // 生成筛选列表
    if (self.maskFilterView) {
        [self.maskFilterView removeFromSuperview];
        self.maskFilterView = nil;
    }
    self.maskFilterView = [[UIView alloc] init];
    UIView *superView = [UIApplication sharedApplication].keyWindow;
    [superView addSubview:self.maskFilterView];
    self.maskFilterView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.3];
    [self.maskFilterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.and.bottom.equalTo(superView);
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(superView.mas_safeAreaLayoutGuideTop).offset(64 + 40);
        } else {
            // Fallback on earlier versions
            make.top.equalTo(superView.mas_topMargin).offset(64 + 40);
        }
    }];
    
    UIView *filterBgView = [[UIView alloc] init];
    [self.maskFilterView addSubview:filterBgView];
    filterBgView.backgroundColor = [UIColor whiteColor];
    [filterBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.and.left.equalTo(self.maskFilterView);
        make.height.equalTo(self.maskFilterView.mas_height).multipliedBy(0.5);
    }];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [filterBgView addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(filterBgView);
    }];
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
    [self.maskFilterView removeFromSuperview];
    self.maskFilterView = nil;
    
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
