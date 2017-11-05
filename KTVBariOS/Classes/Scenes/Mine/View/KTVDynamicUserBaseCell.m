//
//  KTVDynamicUserBaseCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/10/19.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVDynamicUserBaseCell.h"

@interface KTVDynamicUserBaseCell()<UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *heightTF;
@property (weak, nonatomic) IBOutlet UITextField *ageTF;
@property (weak, nonatomic) IBOutlet UITextField *weightTF;
@property (weak, nonatomic) IBOutlet UITextField *xingzuoTF;
@property (weak, nonatomic) IBOutlet UITextField *zhiyeTF;
@property (weak, nonatomic) IBOutlet UITextField *shouruTF;
@property (weak, nonatomic) IBOutlet UITextField *aihaoTF;
@property (weak, nonatomic) IBOutlet UITextView *thinkLoveTextView;
@property (weak, nonatomic) IBOutlet UITextView *thinkSexTextView;
@property (weak, nonatomic) IBOutlet UITextField *signTF;
@property (weak, nonatomic) IBOutlet UITextField *satisfiedTF;

@property (strong, nonatomic) NSMutableDictionary *userInfoDict;

@end

@implementation KTVDynamicUserBaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.heightTF.delegate = self;
    self.ageTF.delegate = self;
    self.weightTF.delegate = self;
    self.xingzuoTF.delegate = self;
    self.zhiyeTF.delegate = self;
    self.shouruTF.delegate = self;
    self.aihaoTF.delegate = self;
    
    self.thinkLoveTextView.delegate = self;
    self.thinkSexTextView.delegate = self;
    
    self.userInfoDict = [NSMutableDictionary new];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)resetUserInfo {
//    "sign":"abcdfdsfsdfsdfs",
//    "price":500,
//    "todayMood":"今天很开心",
//    "profession":"老师",
//    "constellation":"白羊座",
//    "status":1,
//    "active":1,
//    "income":20000,
//    "hobby":"喝酒 聊天",
//    "satisfiedFigure":"手",
//    "viewForLove":"爱情",
//    "viewForSex":"xx"
    if (self.heightTF.text.length) {
        [self.userInfoDict setObject:self.heightTF.text forKey:@"height"];
    }
    if (self.ageTF.text.length) {
        [self.userInfoDict setObject:self.ageTF.text forKey:@"age"];
    }
    if (self.weightTF.text.length) {
        [self.userInfoDict setObject:self.weightTF.text forKey:@"weight"];
    }
    if (self.xingzuoTF.text.length) {
        [self.userInfoDict setObject:self.xingzuoTF.text forKey:@"constellation"];
    }
    if (self.zhiyeTF.text.length) {
        [self.userInfoDict setObject:self.zhiyeTF.text forKey:@"profession"];
    }
    if (self.shouruTF.text.length) {
        [self.userInfoDict setObject:self.shouruTF.text forKey:@"income"];
    }
    if (self.aihaoTF.text.length) {
        [self.userInfoDict setObject:self.aihaoTF.text forKey:@"hobby"];
    }
    if (self.thinkLoveTextView.text.length) {
        [self.userInfoDict setObject:self.thinkLoveTextView.text forKey:@"viewForLove"];
    }
    if (self.thinkLoveTextView.text.length) {
        [self.userInfoDict setObject:self.thinkSexTextView.text forKey:@"viewForSex"];
    }
    if (self.signTF.text.length) {
        [self.userInfoDict setObject:self.signTF.text forKey:@"sign"];
    }
    if (self.satisfiedTF.text.length) {
        [self.userInfoDict setObject:self.satisfiedTF.text forKey:@"satisfiedFigure"];
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self resetUserInfo];
    if (self.userInfoCallback) {
        self.userInfoCallback(self.userInfoDict);
    }
}

#pragma mark - UITextViewDelegate

- (void)textViewDidEndEditing:(UITextView *)textView {
    [self resetUserInfo];
    if (self.userInfoCallback) {
        self.userInfoCallback(self.userInfoDict);
    }
}

@end
