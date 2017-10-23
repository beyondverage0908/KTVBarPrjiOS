//
//  KTVAppVersionCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/10/23.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVAppVersionCell.h"

@interface KTVAppVersionCell()

@property (weak, nonatomic) IBOutlet UILabel *version;

@end

@implementation KTVAppVersionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.version.text = [NSString stringWithFormat:@"%@", [KTVUtil appVersion]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
