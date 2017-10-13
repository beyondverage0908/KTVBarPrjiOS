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

#import "KTVMainService.h"

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

@property (strong, nonatomic) NSMutableDictionary *publisParams;

@end

@implementation KTVStartYueController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发起拼桌活动";
    
    [self setupUI];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEidtAction)];
    [self.view addGestureRecognizer:tap];
    
    [self initData];
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

#pragma mark - 初始化

- (void)initData {
    self.publisParams = [[NSMutableDictionary alloc] init];
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

- (NSString *)getDateStr:(NSString *)year month:(NSString *)month day:(NSString *)day {
    if (month.integerValue < 10) {
        month = [NSString stringWithFormat:@"0%@", month];
    }
    if (day.integerValue < 10) {
        day = [NSString stringWithFormat:@"0%@", day];
    }
    NSString *dateStr = [NSString stringWithFormat:@"%@-%@-%@", year, month, day];
    return dateStr;
}

#pragma mark - 事件

- (void)endEidtAction {
    [self.view endEditing:YES];
}

- (IBAction)selectionTypeAction:(UIButton *)sender {
    CLog(@"-->> 拼桌选择类型");
    NSArray *dataSource = @[@"拼桌", @"拼桌2"];
    [self pickDataSource:dataSource sender:sender];
}

- (IBAction)locationAction:(UIButton *)sender {
    CLog(@"-->> 拼桌地点-->>跳转到凭桌店铺");
    KTVStoreViewController *vc = (KTVStoreViewController *)[UIViewController storyboardName:@"MainPage" storyboardId:@"KTVStoreViewController"];
    vc.selectedStoreCallback = ^(KTVStore *store) {
        [self.publisParams setObject:store.storeId forKey:@"storeId"];
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
    NSArray *dataSource = [KTVUtil monthList];
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

// 发起拼桌活动
- (IBAction)publishAction:(UIButton *)sender {
    CLog(@"-->> 发布");
    // 创建拼桌
    if ([KTVUtil isNullString:self.typeBtn.currentTitle]) {
        [KTVToast toast:TOAST_EMPTY_INFO];
        return;
    }
    if ([KTVUtil isNullString:self.xiaofeiTextField.text]) {
        [KTVToast toast:TOAST_EMPTY_INFO];
        return;
    }
    if ([KTVUtil isNullString:self.locationBtn.currentTitle]) {
        [KTVToast toast:TOAST_EMPTY_INFO];
        return;
    }
    if ([KTVUtil isNullString:self.peopleNumberTextField.text]) {
        [KTVToast toast:TOAST_EMPTY_INFO];
        return;
    }
    
    [self.publisParams setObject:[self getDateStr:self.yearBtn.currentTitle
                                       month:self.monthBtn.currentTitle
                                         day:self.dayBtn.currentTitle]
                     forKey:@"endTime"];
    [self.publisParams setObject:@"0" forKey:@"storeType"];
    [self.publisParams setObject:[KTVCommon userInfo].phone forKey:@"username"];
    [self.publisParams setObject:self.peopleNumberTextField.text forKey:@"limitPeople"];
    [self.publisParams setObject:self.xiaofeiTextField.text forKey:@"consume"];
    [self.publisParams setObject:self.typeBtn.currentTitle forKey:@"requiredType"];
    [self.publisParams setObject:self.explainTextView.text forKey:@"description"];
    
    // 校验信息
    if (!self.publisParams[@"storeId"]) {
        [KTVToast toast:TOAST_EMPTY_INFO];
        return;
    }
    
    [MBProgressHUD showMessage:MB_START_PINZHUO];
    [KTVMainService postShareTable:self.publisParams result:^(NSDictionary *result) {
        [MBProgressHUD hiddenHUD];
        if (![result[@"code"] isEqualToString:ktvCode]) {
            [KTVToast toast:result[@"detail"]];
            return;
        }
        KTVPinZhuoDetailController *vc = (KTVPinZhuoDetailController *)[UIViewController storyboardName:@"MainPage" storyboardId:@"KTVPinZhuoDetailController"];
        [self.navigationController pushViewController:vc animated:YES];
        
        [KTVToast toast:TOAST_PINZHUO_SUCCESS];
    }];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
}

@end
