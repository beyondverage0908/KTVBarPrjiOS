//
//  KTVStarView.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/24.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVStarView.h"

@implementation KTVStarView

- (void)setStars:(NSInteger)stars {
    _stars = stars;
    
    NSInteger number = self.subviews.count;
    
    for (NSInteger i = _stars; i < number; i++) {
        UIView *subview = self.subviews[i];
        
        if ([subview isKindOfClass:[UIButton class]]) {
            UIButton *starBtn = (UIButton *)subview;
            [starBtn setImage:[UIImage imageNamed:@"mainpage_list_start_empty"] forState:UIControlStateNormal];
        }
    }
}
@end
