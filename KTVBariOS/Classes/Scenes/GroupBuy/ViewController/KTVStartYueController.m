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

#pragma mark - 封装

- (void)pickDataSource:(NSArray<NSString *> *)dataSource sender:(UIButton *)sender {
    UIView *superView = [UIApplication sharedApplication].keyWindow;
    KTVPickerView *pv = [[KTVPickerView alloc] initWithSelectedCallback:^(NSString *selectedTitle) {
        [sender setTitle:selectedTitle forState:UIControlStateNormal];
    }];
    [superView addSubview:pv];
    [pv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superView);
    }];
    pv.dataSource = dataSource;
}

#pragma mark - 事件

- (void)endEidtAction {
    [self.view endEditing:YES];
}

- (IBAction)selectionTypeAction:(UIButton *)sender {
    CLog(@"-->> 拼桌选择类型");
    NSArray *dataSource = @[@"一等座", @"二等座", @"三等座", @"四等座"];
    [self pickDataSource:dataSource sender:sender];
}

- (IBAction)locationAction:(UIButton *)sender {
    CLog(@"-->> 拼桌地点-->>跳转到凭桌店铺");
    KTVStoreViewController *vc = (KTVStoreViewController *)[UIViewController storyboardName:@"MainPage" storyboardId:@"KTVStoreViewController"];
    vc.selectedStoreCallback = ^(KTVStore *store) {
        [sender setTitle:store.storeName forState:UIControlStateNormal];
    };
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)yearAction:(UIButton *)sender {
    CLog(@"-->> 选年");
    NSArray *dataSource = @[@"2017", @"2018", @"2019", @"2020"];
    [self pickDataSource:dataSource sender:sender];
}
- (IBAction)monthAction:(UIButton *)sender {
    CLog(@"-->> 选月");
    NSArray *dataSource = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12"];
    [self pickDataSource:dataSource sender:sender];
}
- (IBAction)dayAction:(UIButton *)sender {
    CLog(@"-->> 选日");
    NSMutableArray *dataSource = [NSMutableArray arrayWithCapacity:31];
    for (NSInteger i = 1; i < 13; i++) {
        switch (i) {
            case 1:
            case 3:
            case 5:
            case 7:
            case 8:
            case 10:
            case 12:
            {
                for (NSInteger i = 1; i <= 31; i++) {
                    [dataSource addObject:@(i).stringValue];
                }
            }
                break;
            case 4:
            case 6:
            case 9:
            case 11:
            {
                for (NSInteger i = 1; i <= 30; i++) {
                    [dataSource addObject:@(i).stringValue];
                }
            }
                break;
            case 2: {
                for (NSInteger i = 1; i <= 29; i++) {
                    [dataSource addObject:@(i).stringValue];
                }
            }
            default:
                break;
        }
    }
    [self pickDataSource:dataSource sender:sender];
}

- (IBAction)publishAction:(UIButton *)sender {
    
    NSMutableDictionary *publisParams = [[NSMutableDictionary alloc] init];
    if (self.typeBtn.currentTitle && self.xiaofeiTextField.text && self.locationBtn.currentTitle && self.yearBtn.currentTitle && self.monthBtn.currentTitle && self.dayBtn.currentTitle && self.peopleNumberTextField.text && self.explainTextView.text) {
        [publisParams setObject:self.typeBtn.currentTitle forKey:@"type"];
        [publisParams setObject:self.xiaofeiTextField.text forKey:@"xiaofei"];
        [publisParams setObject:self.locationBtn.currentTitle forKey:@"location"];
        [publisParams setObject:self.yearBtn.currentTitle forKey:@"year"];
        [publisParams setObject:self.monthBtn.currentTitle forKey:@"month"];
        [publisParams setObject:self.dayBtn.currentTitle forKey:@"month"];
        [publisParams setObject:self.peopleNumberTextField.text forKey:@"peopleNumber"];
        [publisParams setObject:self.explainTextView.text forKey:@"explain"];
    }
    
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
