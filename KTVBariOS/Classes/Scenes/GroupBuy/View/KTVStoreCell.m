//
//  KTVStoreCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/3.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVStoreCell.h"

#import "KTVStarView.h"

@interface KTVStoreCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *storeTimeLabel; // 营业时间
@property (weak, nonatomic) IBOutlet KTVStarView *starView;

@end

@implementation KTVStoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.starView.stars = arc4random() % 5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (IBAction)confirmAction:(UIButton *)sender {
    CLog(@"-->> 选中店铺 确定");
    if (self.callBack) {
        self.callBack(self.store);
    }
}

- (void)setStore:(KTVStore *)store {
    _store = store;
    
    self.nameLabel.text = _store.storeName;
    self.starView.stars = _store.star;
    self.storeTimeLabel.text = [NSString stringWithFormat:@"营业时间 %@-%@", _store.fromTime, _store.toTime];
    self.locationLabel.text = _store.address.addressName;
}

@end
