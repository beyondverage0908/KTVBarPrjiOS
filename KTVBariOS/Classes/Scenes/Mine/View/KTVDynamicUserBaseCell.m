//
//  KTVDynamicUserBaseCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/10/19.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVDynamicUserBaseCell.h"

@interface KTVDynamicUserBaseCell()

@property (weak, nonatomic) IBOutlet UITextField *heightTF;
@property (weak, nonatomic) IBOutlet UITextField *ageTF;
@property (weak, nonatomic) IBOutlet UITextField *weightTF;
@property (weak, nonatomic) IBOutlet UITextField *xingzuoTF;
@property (weak, nonatomic) IBOutlet UITextField *zhiyeTF;
@property (weak, nonatomic) IBOutlet UITextField *shouruTF;
@property (weak, nonatomic) IBOutlet UITextField *aihaoTF;
@property (weak, nonatomic) IBOutlet UITextView *thinkLoveTextView;
@property (weak, nonatomic) IBOutlet UITextView *thinkSexTextView;

@end

@implementation KTVDynamicUserBaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
