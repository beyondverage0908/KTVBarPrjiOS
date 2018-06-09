//
//  KTVBarKtvDetailHeaderCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/12.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVBarKtvDetailHeaderCell.h"
#import "KTVStarView.h"

@interface KTVBarKtvDetailHeaderCell ()
@property (weak, nonatomic) IBOutlet UIButton *purikuraBtn;
@property (weak, nonatomic) IBOutlet UILabel *numberSheetLabel;
@property (weak, nonatomic) IBOutlet UILabel *storeNameLabel;
@property (weak, nonatomic) IBOutlet KTVStarView *starView;
@property (weak, nonatomic) IBOutlet UILabel *locationName;
@property (weak, nonatomic) IBOutlet UILabel *yuepaoNumber;
@property (weak, nonatomic) IBOutlet UIView *yuepaoHeaderView;


@end

@implementation KTVBarKtvDetailHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.starView.stars = 2;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoYuePaoAction:)];
    [self.yuepaoNumber addGestureRecognizer:tap];
    
    [self setupUI];
    
    [self.purikuraBtn addTarget:self
                         action:@selector(purikuraAction:)
               forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 事件

- (void)purikuraAction:(UIButton *)btn {
    NSLog(@"--->>>图片浏览");
    if (self.purikuraCallBack) {
        self.purikuraCallBack(self.store);
    }
}

- (IBAction)yudingNumberAction:(UIButton *)sender {
    // 订座，指的是拨打酒店的电话
    CLog(@"--->>>拨打订座电话");
    [KTVUtil tellphone:self.store.phone];
}

- (void)setupUI {
    [self.yuepaoNumber addUnderlineStyle];
}

#pragma mark - 设置

- (void)setStore:(KTVStore *)store {
    _store = store;
    
    self.storeNameLabel.text = store.storeName;
    self.starView.stars = store.star;
    self.locationName.text = store.address.addressName;
}

- (void)setInvitorList:(NSArray<KTVUser *> *)invitorList {
    if (_invitorList != invitorList) {
        _invitorList = invitorList;
        
        self.yuepaoNumber.text = [NSString stringWithFormat:@"在约小伙伴%@人，点击查看",@([_invitorList count])];
        [self.yuepaoNumber addUnderlineStyle];
        
        NSInteger i = 0;
        for (UIView *subView in self.yuepaoHeaderView.subviews) {
            if (i < invitorList.count) {
                if ([subView isKindOfClass:[UIImageView class]]) {
                    UIImageView *headImageView = (UIImageView *)subView;
                    headImageView.layer.cornerRadius = CGRectGetWidth(headImageView.frame) / 2.0f;
                    headImageView.layer.masksToBounds = YES;
                    
                    KTVUser *user = _invitorList[i];
                    [headImageView sd_setImageWithURL:[NSURL URLWithString:user.pictureList.firstObject.pictureUrl] placeholderImage:[UIImage imageNamed:@"bar_yuepao_user_placeholder"]];
                }
                i++;
            } else {
                break;
            }
        }
    }
}

#pragma mark - 事件

- (void)gotoYuePaoAction:(UIButton *)btn {
    CLog(@"-- 在约的小伙伴有45人");
    if (self.callback) {
        self.callback(self.store);
    }
}

@end
