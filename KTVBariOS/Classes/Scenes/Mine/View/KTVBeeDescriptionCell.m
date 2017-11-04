//
//  KTVBeeDescriptionCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/10/31.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVBeeDescriptionCell.h"

@interface KTVBeeDescriptionCell()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation KTVBeeDescriptionCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setIntroduction:(NSString *)introduction {
    if (_introduction != introduction) {
        _introduction = introduction;
        
        self.textView.text = _introduction;
    }
}

@end
