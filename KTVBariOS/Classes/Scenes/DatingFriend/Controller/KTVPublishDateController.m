//
//  KTVPublishDateController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/29.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVPublishDateController.h"
#import "KTVPickerView.h"

@interface KTVPublishDateController ()

@property (weak, nonatomic) IBOutlet UIButton *barNameBtn;
@property (weak, nonatomic) IBOutlet UIButton *yearBtn;
@property (weak, nonatomic) IBOutlet UIButton *monthBtn;
@property (weak, nonatomic) IBOutlet UIButton *dayBtn;
@property (weak, nonatomic) IBOutlet UIButton *genderBtn;
@property (weak, nonatomic) IBOutlet UIButton *payBtn; // 费用
@property (weak, nonatomic) IBOutlet UITextView *explainTextView;
@property (weak, nonatomic) IBOutlet UIImageView *firstimageView;
@property (weak, nonatomic) IBOutlet UIImageView *secondImageView;
@property (weak, nonatomic) IBOutlet UIImageView *thirdImageView;

@end

@implementation KTVPublishDateController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.type == 0) {
        self.title = @"酒吧";
    } else {
        self.title = @"KTV";
    }
    
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 初始化Ui

- (void)initUI {
    self.explainTextView.backgroundColor = [UIColor ktvTextFieldBg];
    self.explainTextView.layer.cornerRadius = 5;
}

#pragma mark - 事件

- (IBAction)chooseBarAction:(UIButton *)sender {
    CLog(@"-->> 选择酒吧");
}

- (IBAction)chooseYearAction:(UIButton *)sender {
    CLog(@"-->> 选择年");
    KTVPickerView *pv = [[KTVPickerView alloc] initWithSelectedCallback:^(NSString *selectedTitle) {
        [sender setTitle:selectedTitle forState:UIControlStateNormal];
    }];
    [self.view addSubview:pv];
    pv.dataSource = @[@"2017", @"2018", @"2019", @"2020"];
    [pv mas_makeConstraints:^(MASConstraintMaker *make) {make.edges.equalTo(self.view);}];
}

- (IBAction)chooseMonthAction:(UIButton *)sender {
    CLog(@"-->> 选择月");
    KTVPickerView *pv = [[KTVPickerView alloc] initWithSelectedCallback:^(NSString *selectedTitle) {
        [sender setTitle:selectedTitle forState:UIControlStateNormal];
    }];
    [self.view addSubview:pv];
    pv.dataSource = [KTVUtil monthList];
    [pv mas_makeConstraints:^(MASConstraintMaker *make) {make.edges.equalTo(self.view);}];
}

- (IBAction)chooseDayAction:(UIButton *)sender {
    CLog(@"-->> 选择日");
    NSInteger month = [self.monthBtn.currentTitle integerValue];
    KTVPickerView *pv = [[KTVPickerView alloc] initWithSelectedCallback:^(NSString *selectedTitle) {
        [sender setTitle:selectedTitle forState:UIControlStateNormal];
    }];
    [self.view addSubview:pv];
    pv.dataSource = [KTVUtil dayListByMonth:month];
    [pv mas_makeConstraints:^(MASConstraintMaker *make) {make.edges.equalTo(self.view);}];
}

- (IBAction)chooseGenderAction:(UIButton *)sender {
    CLog(@"-->> 选择性别");
    KTVPickerView *pv = [[KTVPickerView alloc] initWithSelectedCallback:^(NSString *selectedTitle) {
        [sender setTitle:selectedTitle forState:UIControlStateNormal];
    }];
    [self.view addSubview:pv];
    pv.dataSource = @[@"男", @"女"];
    [pv mas_makeConstraints:^(MASConstraintMaker *make) {make.edges.equalTo(self.view);}];
}

- (IBAction)choosePayAction:(UIButton *)sender {
    CLog(@"-->> 选择付款方式");
    KTVPickerView *pv = [[KTVPickerView alloc] initWithSelectedCallback:^(NSString *selectedTitle) {
        [sender setTitle:selectedTitle forState:UIControlStateNormal];
    }];
    [self.view addSubview:pv];
    pv.dataSource = @[@"AA制", @"我一个付", @"我付大部分"];
    [pv mas_makeConstraints:^(MASConstraintMaker *make) {make.edges.equalTo(self.view);}];
}

- (IBAction)chooseAendAction:(UIButton *)sender {
    CLog(@"-->> 我接送");
    [sender setSelected:!sender.isSelected];
    UIImage *image = nil;
    if (sender.isSelected) {
        image = [UIImage imageNamed:@"app_gou_red"];
    } else {
        image = [UIImage imageNamed:@"app_selected_kuang"];
    }
    [sender setImage:image forState:UIControlStateNormal];
}

- (IBAction)publishYueAction:(UIButton *)sender {
    CLog(@"-->> 发布预约");
}

@end
