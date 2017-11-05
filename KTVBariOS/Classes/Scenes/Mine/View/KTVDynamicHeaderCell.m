//
//  KTVDynamicHeaderCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/10/19.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVDynamicHeaderCell.h"
#import "KTVMainService.h"

@interface KTVDynamicHeaderCell()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UIImageView *userHeaderImageView;
@property (weak, nonatomic) IBOutlet UITextField *nicknameTextfield;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end

@implementation KTVDynamicHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.headerImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickImageAction:)];
    [self.headerImageView addGestureRecognizer:tap];
    
    self.userHeaderImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *headerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickUserHeaderAction:)];
    [self.userHeaderImageView addGestureRecognizer:headerTap];
    
    self.userHeaderImageView.layer.cornerRadius = CGRectGetWidth(self.userHeaderImageView.frame) / 2.0f;
    self.userHeaderImageView.layer.masksToBounds = YES;
    
    self.nicknameTextfield.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setHeaderBgImage:(UIImage *)headerBgImage {
    if (headerBgImage) {
        _headerBgImage = headerBgImage;
        self.headerImageView.image = _headerBgImage;
    }
}

- (void)setHeaderImage:(UIImage *)headerImage {
    if (headerImage) {
        _headerImage = headerImage;
        self.userHeaderImageView.image = _headerImage;
    }
}

- (void)pickImageAction:(UIButton *)btn {
    if (self.pickHeaderBgImageCallback) {
        self.pickHeaderBgImageCallback();
    }
}

- (void)pickUserHeaderAction:(UITapGestureRecognizer *)tap {
    if (self.pickHeaderImageCallback) {
        self.pickHeaderImageCallback();
    }
}
- (IBAction)editNicknameAction:(id)sender {
    [self.nicknameTextfield becomeFirstResponder];
    
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    CLog(@"结束编辑昵称...");
    NSString *nickname = textField.text;
    NSString *username = [KTVCommon userInfo].phone;
    
    if (nickname && nickname.length > 0 && username) {
        NSDictionary *params = @{@"nickName" : nickname, @"username" : username};
        [KTVMainService postEditNickname:params result:^(NSDictionary *result) {
            if ([result[@"code"] isEqualToString:ktvCode]) {
                [KTVToast toast:TOAST_NICKNAME_EDITED];
            }
        }];
    }
}

@end
