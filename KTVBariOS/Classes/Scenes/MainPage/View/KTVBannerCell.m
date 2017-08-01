//
//  KTVBannerCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/1.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVBannerCell.h"

@implementation KTVBannerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor colorHex:@"#efeff4"];
    
    self.sdBannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREENW, self.contentView.frame.size.height) delegate:nil placeholderImage:[UIImage imageNamed:@"dynamic_banner_placehold"]];
    self.sdBannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    self.sdBannerView.pageDotColor = [UIColor whiteColor];
    self.sdBannerView.currentPageDotColor = [UIColor ktvRed];
    self.sdBannerView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.sdBannerView.hidesForSinglePage = YES;
    [self.contentView addSubview:self.sdBannerView];
    
    UIView *superView = self.contentView;
    [self.sdBannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superView);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
