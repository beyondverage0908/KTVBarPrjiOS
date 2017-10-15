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
            make.width.height.equalTo(self);
        }];
        
        UIView *bgView = [[UIView alloc] init];
        [mask addSubview:bgView];
        bgView.backgroundColor = [UIColor whiteColor];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(mask).multipliedBy(0.4);
            make.left.and.right.and.bottom.equalTo(mask);
        }];
        
        UIView *headerView = [[UIView alloc] init];
        [bgView addSubview:headerView];
        headerView.backgroundColor = [UIColor whiteColor];
        [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(bgView);
            make.height.mas_equalTo(bgView.mas_height).multipliedBy(0.16);
        }];
        
        self.pickerView = [[UIPickerView alloc] init];
        [bgView addSubview:self.pickerView];
        self.pickerView.backgroundColor = [UIColor whiteColor];
        self.pickerView.delegate = self;
        self.pickerView.dataSource = self;
        [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.and.bottom.equalTo(bgView);
            make.height.equalTo(bgView.mas_height).multipliedBy(0.84);
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
    
    NSInteger row = [self.pickerView selectedRowInComponent:0];
    
    if ([self.delegate respondsToSelector:@selector(ktvPickerView:selectedTitle:)]) {
        [self.delegate ktvPickerView:self selectedTitle:self.dataSource[row]];
    }
    
    if (self.selectedCallback && ![KTVUtil isNullString:self.dataSource[row]]) {
        self.selectedCallback(self.dataSource[row]);
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
