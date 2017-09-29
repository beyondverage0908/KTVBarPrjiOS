//
//  KTVPublishDateController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/29.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVPublishDateController.h"

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
}

- (IBAction)chooseMonthAction:(UIButton *)sender {
    CLog(@"-->> 选择月");
}

- (IBAction)chooseDayAction:(UIButton *)sender {
    CLog(@"-->> 选择日");
}

- (IBAction)chooseGenderAction:(UIButton *)sender {
    CLog(@"-->> 选择性别");
}

- (IBAction)choosePayAction:(UIButton *)sender {
    CLog(@"-->> 选择付款方式");
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
