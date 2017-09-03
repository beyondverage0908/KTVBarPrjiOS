//
//  KTVStartYueController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/31.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVStartYueController.h"
#import "KTVStoreViewController.h"
#import "KTVPinZhuoDetailController.h"

#import "KTVPickerView.h"

@interface KTVStartYueController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *typeBtn;
@property (weak, nonatomic) IBOutlet UIButton *needLabel;
@property (weak, nonatomic) IBOutlet UITextField *xiaofeiTextField;
@property (weak, nonatomic) IBOutlet UIButton *locationBtn;
@property (weak, nonatomic) IBOutlet UIButton *yearBtn;
@property (weak, nonatomic) IBOutlet UIButton *monthBtn;
@property (weak, nonatomic) IBOutlet UIButton *dayBtn;
@property (weak, nonatomic) IBOutlet UITextField *peopleNumberTextField;
@property (weak, nonatomic) IBOutlet UITextView *explainTextView;

@end

@implementation KTVStartYueController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发起拼桌活动";
    
    [self setupUI];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEidtAction)];
    [self.view addGestureRecognizer:tap];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor ktvBG];
    self.scrollView.backgroundColor = [UIColor ktvBG];
    self.xiaofeiTextField.backgroundColor = [UIColor ktvTextFieldBg];
    self.peopleNumberTextField.backgroundColor = [UIColor ktvTextFieldBg];
    
    self.xiaofeiTextField.textColor = [UIColor whiteColor];
    self.xiaofeiTextField.delegate = self;
    
    self.peopleNumberTextField.textColor = [UIColor whiteColor];
    self.peopleNumberTextField.delegate = self;
    
    self.explainTextView.backgroundColor = [UIColor ktvTextFieldBg];
    
    self.explainTextView.textColor = [UIColor whiteColor];
}

#pragma mark - 事件

- (void)endEidtAction {
    [self.view endEditing:YES];
}

- (IBAction)selectionTypeAction:(UIButton *)sender {
    CLog(@"-->> 拼桌选择类型");
    
    UIView *superView = [UIApplication sharedApplication].keyWindow;
    KTVPickerView *pv = [[KTVPickerView alloc] initWithSelectedCallback:^(NSString *selectedTitle) {
        [sender setTitle:selectedTitle forState:UIControlStateNormal];
    }];
    [superView addSubview:pv];
    [pv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superView);
    }];
    pv.dataSource = @[@"一等座", @"二等座", @"三等座", @"四等座"];
}

- (IBAction)locationAction:(UIButton *)sender {
    CLog(@"-->> 拼桌地点-->>跳转到凭桌店铺");
    KTVStoreViewController *vc = (KTVStoreViewController *)[UIViewController storyboardName:@"MainPage" storyboardId:@"KTVStoreViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)yearAction:(UIButton *)sender {
    CLog(@"-->> 选年");
}
- (IBAction)monthAction:(UIButton *)sender {
    CLog(@"-->> 选月");
}
- (IBAction)dayAction:(UIButton *)sender {
    CLog(@"-->> 选日");
}
- (IBAction)publishAction:(UIButton *)sender {
    CLog(@"-->> 发布");
    KTVPinZhuoDetailController *vc = (KTVPinZhuoDetailController *)[UIViewController storyboardName:@"MainPage" storyboardId:@"KTVPinZhuoDetailController"];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
}

@end
