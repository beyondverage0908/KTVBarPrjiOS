//
//  KTVStoreOrderUseCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/12.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVStoreOrderUseCell.h"

@interface KTVStoreOrderUseCell ()

@property (weak, nonatomic) IBOutlet UIImageView *storeImageView;
@property (weak, nonatomic) IBOutlet UILabel *storeName;
@property (weak, nonatomic) IBOutlet UILabel *baojiaLabel;
@property (weak, nonatomic) IBOutlet UILabel *alreadyPayLabel;

@end

@implementation KTVStoreOrderUseCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)callStoreAction:(id)sender {
    [KTVUtil tellphone:@"18516133629"];
}
@end
