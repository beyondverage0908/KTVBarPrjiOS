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
}

- (IBAction)yudingNumberAction:(UIButton *)sender {
    // 订座，指的是拨打酒店的电话
    CLog(@"--->>>拨打订座电话");
}

- (void)setupUI {
    [self.yuepaoNumber addUnderlineStyle];
}

#pragma mark - 事件

- (void)gotoYuePaoAction:(UIButton *)btn {
    CLog(@"-- 在约的小伙伴有45人");
}

@end
