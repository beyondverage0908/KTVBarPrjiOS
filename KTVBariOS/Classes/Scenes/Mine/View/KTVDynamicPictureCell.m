//
//  KTVDynamicPictureCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/10/19.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVDynamicPictureCell.h"

@interface KTVDynamicPictureCell()

@property (weak, nonatomic) IBOutlet UITextView *dynamicExplainTextView;

@end

@implementation KTVDynamicPictureCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - 事件

- (IBAction)toSeeDynamic:(UIButton *)sender {
    if (self.seeDynaicCallback) {
        self.seeDynaicCallback();
    }
}
@end
