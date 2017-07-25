//
//  KTVUnderlineButton.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/7/17.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVUnderlineButton.h"

@interface KTVUnderlineButton ()

@property (strong, nonatomic) UIView *underline;

@end

@implementation KTVUnderlineButton

- (instancetype)init {
    if (self = [super init]) {
        self.underline = [[UIView alloc] init];
        [self addSubview:self.underline];
        self.underline.backgroundColor = [UIColor ktvRed];
        self.underline.hidden = YES;
        [self.underline mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.and.bottom.equalTo(self);
            make.height.equalTo(@2);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected {
    self.underline.hidden = !selected;
}

@end
