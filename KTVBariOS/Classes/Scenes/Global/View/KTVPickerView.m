//
//  KTVPickerView.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/1.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVPickerView.h"

@interface KTVPickerView ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) UIPickerView *pickerView;

@property (strong, nonatomic) NSString *selectedTitle;

@property (copy, nonatomic) void (^selectedCallback)(NSString *selectedTitle);

@end

@implementation KTVPickerView

- (instancetype)initWithSelectedCallback:(void (^)(NSString *selectedTitle))selectedCallback {
    self = [super init];
    
    if (self) {
        if (selectedCallback) {
            self.selectedCallback = selectedCallback;
        }
        
        UIView *mask = [[UIView alloc] init];
        mask.backgroundColor = [UIColor clearColor];
        [self addSubview:mask];
        [mask mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        UIView *bgView = [[UIView alloc] init];
        [mask addSubview:bgView];
        bgView.backgroundColor = [UIColor whiteColor];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.and.bottom.equalTo(self);
            make.height.equalTo(mask).multipliedBy(0.4);
        }];
        
        
        UIView *headerView = [[UIView alloc] init];
        [bgView addSubview:headerView];
        headerView.backgroundColor = [UIColor whiteColor];
        [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(bgView);
            make.height.equalTo(@40);
        }];

        UIButton *leftBtn = [[UIButton alloc] init];
        [headerView addSubview:leftBtn];
        [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
        [leftBtn addTarget:self action:@selector(cancleAction:) forControlEvents:UIControlEventTouchUpInside];
        leftBtn.titleLabel.font = [UIFont bold15];
        [leftBtn setTitleColor:[UIColor ktvGray] forState:UIControlStateNormal];
        [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(headerView);
            make.left.equalTo(headerView).offset(10);
        }];

        UIButton *rightBtn = [[UIButton alloc] init];
        [headerView addSubview:rightBtn];
        [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
        rightBtn.titleLabel.font = [UIFont bold15];
        [rightBtn addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
        [rightBtn setTitleColor:[UIColor ktvRed] forState:UIControlStateNormal];
        [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(headerView);
            make.right.equalTo(headerView).offset(-10);
        }];

        self.pickerView = [[UIPickerView alloc] init];
        [bgView addSubview:self.pickerView];
        self.pickerView.backgroundColor = [UIColor whiteColor];
        self.pickerView.delegate = self;
        self.pickerView.dataSource = self;
        [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.and.bottom.equalTo(bgView);
            make.top.equalTo(headerView.mas_bottom);
        }];
    }
    
    return self;
}

- (void)setDataSource:(NSArray<NSString *> *)dataSource {
    _dataSource = dataSource;
    
    [self.pickerView reloadAllComponents];
}

#pragma mark - 事件

- (void)cancleAction:(UIButton *)btn {
    CLog(@"-->> 取消");
    [self removeFromSuperview];
}

- (void)confirmAction:(UIButton *)btn {
    CLog(@"-->> 确定");
    
    if ([self.delegate respondsToSelector:@selector(ktvPickerView:selectedTitle:)]) {
        [self.delegate ktvPickerView:self selectedTitle:self.selectedTitle];
    }
    
    if (self.selectedCallback) {
        self.selectedCallback(self.selectedTitle);
    }
    
    [self removeFromSuperview];
}

#pragma mark - UIPickerViewDelegate

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return self.bounds.size.width;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 44.0f;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectedTitle = self.dataSource[row];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.dataSource[row];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.dataSource count];
}

@end
