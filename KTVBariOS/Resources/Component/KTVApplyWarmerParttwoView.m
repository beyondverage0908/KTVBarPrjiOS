//
//  KTVApplyWarmerParttwoView.m
//  KTVBariOS
//
//  Created by pingjun lin on 2018/1/28.
//  Copyright © 2018年 Lin. All rights reserved.
//

#import "KTVApplyWarmerParttwoView.h"

@interface KTVApplyWarmerParttwoView()<UITextFieldDelegate>
{
    NSArray * _worktimeList;
}
@property (weak, nonatomic) IBOutlet UILabel *depositLabel; // 需要缴纳保证金

@property (weak, nonatomic) IBOutlet UIButton *parttimeBtn;
@property (weak, nonatomic) IBOutlet UIButton *longtimeBtn;

@property (weak, nonatomic) IBOutlet UIView *week1;
@property (weak, nonatomic) IBOutlet UIView *week2;
@property (weak, nonatomic) IBOutlet UIView *week3;
@property (weak, nonatomic) IBOutlet UIView *week4;
@property (weak, nonatomic) IBOutlet UIView *week5;
@property (weak, nonatomic) IBOutlet UIView *week6;
@property (weak, nonatomic) IBOutlet UIView *week7;

@property (weak, nonatomic) IBOutlet UIImageView *igweek1;
@property (weak, nonatomic) IBOutlet UIImageView *igweek2;
@property (weak, nonatomic) IBOutlet UIImageView *igweek3;
@property (weak, nonatomic) IBOutlet UIImageView *igweek4;
@property (weak, nonatomic) IBOutlet UIImageView *igweek5;
@property (weak, nonatomic) IBOutlet UIImageView *igweek6;
@property (weak, nonatomic) IBOutlet UIImageView *igweek7;

@property (assign, nonatomic) BOOL week1IsSelected;
@property (assign, nonatomic) BOOL week2IsSelected;
@property (assign, nonatomic) BOOL week3IsSelected;
@property (assign, nonatomic) BOOL week4IsSelected;
@property (assign, nonatomic) BOOL week5IsSelected;
@property (assign, nonatomic) BOOL week6IsSelected;
@property (assign, nonatomic) BOOL week7IsSelected;

@property (weak, nonatomic) IBOutlet UITextField *partMoneyTF;

@property (strong, nonatomic) NSMutableDictionary *workTimeDic;

@end

@implementation KTVApplyWarmerParttwoView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _worktimeList = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7"];
    self.workTimeDic = [NSMutableDictionary dictionaryWithCapacity:7];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(weektap1)];
    [self.week1 addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(weektap2)];
    [self.week2 addGestureRecognizer:tap2];
    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(weektap3)];
    [self.week3 addGestureRecognizer:tap3];
    
    
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(weektap4)];
    [self.week4 addGestureRecognizer:tap4];
    
    
    UITapGestureRecognizer *tap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(weektap5)];
    [self.week5 addGestureRecognizer:tap5];
    
    UITapGestureRecognizer *tap6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(weektap6)];
    [self.week6 addGestureRecognizer:tap6];
    
    UITapGestureRecognizer *tap7 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(weektap7)];
    [self.week7 addGestureRecognizer:tap7];
    
    self.partMoneyTF.delegate = self;

}

#pragma mark - 兼职时间选择

- (void)weektap1 {
    self.week1IsSelected = !self.week1IsSelected;
    self.igweek1.image = self.week1IsSelected ? [UIImage imageNamed:@"app_gou_red"] : [UIImage imageNamed:@"app_kuang_red"];
    if (self.week1IsSelected) {
        [self.workTimeDic setObject:_worktimeList[0] forKey:_worktimeList[0]];
    } else {
        [self.workTimeDic removeObjectForKey:_worktimeList[0]];
    }
    [self weekSelectedChange];
}

- (void)weektap2 {
    self.week2IsSelected = !self.week2IsSelected;
    self.igweek2.image = self.week2IsSelected ? [UIImage imageNamed:@"app_gou_red"] : [UIImage imageNamed:@"app_kuang_red"];
    if (self.week2IsSelected) {
        [self.workTimeDic setObject:_worktimeList[1] forKey:_worktimeList[1]];
    } else {
        [self.workTimeDic removeObjectForKey:_worktimeList[1]];
    }
    [self weekSelectedChange];
}

- (void)weektap3 {
    self.week3IsSelected = !self.week3IsSelected;
    self.igweek3.image = self.week3IsSelected ? [UIImage imageNamed:@"app_gou_red"] : [UIImage imageNamed:@"app_kuang_red"];
    if (self.week3IsSelected) {
        [self.workTimeDic setObject:_worktimeList[2] forKey:_worktimeList[2]];
    } else {
        [self.workTimeDic removeObjectForKey:_worktimeList[2]];
    }
    [self weekSelectedChange];
}

- (void)weektap4 {
    self.week4IsSelected = !self.week4IsSelected;
    self.igweek4.image = self.week4IsSelected ? [UIImage imageNamed:@"app_gou_red"] : [UIImage imageNamed:@"app_kuang_red"];
    if (self.week4IsSelected) {
        [self.workTimeDic setObject:_worktimeList[3] forKey:_worktimeList[3]];
    } else {
        [self.workTimeDic removeObjectForKey:_worktimeList[3]];
    }
    [self weekSelectedChange];
}

- (void)weektap5 {
    self.week5IsSelected = !self.week5IsSelected;
    self.igweek5.image = self.week5IsSelected ? [UIImage imageNamed:@"app_gou_red"] : [UIImage imageNamed:@"app_kuang_red"];
    if (self.week5IsSelected) {
        [self.workTimeDic setObject:_worktimeList[4] forKey:_worktimeList[4]];
    } else {
        [self.workTimeDic removeObjectForKey:_worktimeList[4]];
    }
    [self weekSelectedChange];
}

- (void)weektap6 {
    self.week6IsSelected = !self.week6IsSelected;
    self.igweek6.image = self.week6IsSelected ? [UIImage imageNamed:@"app_gou_red"] : [UIImage imageNamed:@"app_kuang_red"];
    if (self.week6IsSelected) {
        [self.workTimeDic setObject:_worktimeList[5] forKey:_worktimeList[5]];
    } else {
        [self.workTimeDic removeObjectForKey:_worktimeList[5]];
    }
    [self weekSelectedChange];
}

- (void)weektap7 {
    self.week7IsSelected = !self.week7IsSelected;
    self.igweek7.image = self.week7IsSelected ? [UIImage imageNamed:@"app_gou_red"] : [UIImage imageNamed:@"app_kuang_red"];
    if (self.week7IsSelected) {
        [self.workTimeDic setObject:_worktimeList[6] forKey:_worktimeList[6]];
    } else {
        [self.workTimeDic removeObjectForKey:_worktimeList[6]];
    }
    [self weekSelectedChange];
}

- (void)weekSelectedChange {
    if (self.weekCallback) self.weekCallback(self.workTimeDic);
}

#pragma mark - 事件

- (IBAction)parttimeAction:(UIButton *)sender {
    CLog(@"--->>> 兼职");
    [sender setImage:[UIImage imageNamed:@"warmer_type"] forState:UIControlStateNormal];
    [self.longtimeBtn setImage:[UIImage imageNamed:@"warmer_un_type"] forState:UIControlStateNormal];
    
    if (self.parttimeOrlongtimeCallback) self.parttimeOrlongtimeCallback(NO);
}

- (IBAction)longtimeAction:(UIButton *)sender {
    CLog(@"--->>> 全职");
    [sender setImage:[UIImage imageNamed:@"warmer_type"] forState:UIControlStateNormal];
    [self.parttimeBtn setImage:[UIImage imageNamed:@"warmer_un_type"] forState:UIControlStateNormal];
    
    if (self.parttimeOrlongtimeCallback) self.parttimeOrlongtimeCallback(YES);
}

- (IBAction)agreeProtocolAction:(UIButton *)sender {
    CLog(@"--- 同意协议");
    [sender setSelected:!sender.isSelected];
    if (sender.isSelected) {
        [sender setImage:[UIImage imageNamed:@"app_gou_red"] forState:UIControlStateNormal];
    } else {
        [sender setImage:[UIImage imageNamed:@"app_kuang_red"] forState:UIControlStateNormal];
    }
    
    if (self.permissCallback) self.permissCallback(sender.isSelected);
}

- (IBAction)linkCompanyAction:(id)sender {
    CLog(@"联系我们");
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSString *moneyStr = textField.text;
    if ([moneyStr doubleValue] > 0) {
        if (self.everydayMoneyCallback) self.everydayMoneyCallback(moneyStr);
    } else {
        [KTVToast toast:@"请填写正确的金额"];
    }
}

@end
