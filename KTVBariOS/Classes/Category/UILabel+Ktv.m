//
//  UILabel+Ktv.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/4.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "UILabel+Ktv.h"

@implementation UILabel (Ktv)

- (UILabel *)addUnderlineStyle {
    NSString *text = self.text;
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:text];
    NSRange strRange1 = {0,[str1 length]};
    [str1 addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange1];
    self.attributedText = str1;
    
    return self;
}

- (UILabel *)addStrikethroughStyle {
    NSString *text = self.text;
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:text];
    NSRange strRange1 = {0,[str1 length]};
    [str1 addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange1];
    self.attributedText = str1;
    
    return self;
}

@end
