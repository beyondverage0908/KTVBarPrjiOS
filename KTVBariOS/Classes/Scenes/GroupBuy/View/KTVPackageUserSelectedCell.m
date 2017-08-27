//
//  KTVPackageUserSelectedCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/24.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVPackageUserSelectedCell.h"

@implementation KTVPackageUserSelectedCell

- (instancetype)initBuyGoods:(NSArray<NSDictionary *> *)goods reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *bgView = [[UIView alloc] init];
        [self addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.and.left.equalTo(self);
        }];
        
        UIImageView *bgImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainpage_all_bg_line"]];
        [bgView addSubview:bgImgView];
        [bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(bgView);
        }];
        
        CGFloat height = 29.0f;
        UIView *previouslyView = nil;
        for (NSInteger i = 0; i < [goods count]; i++) {
            UIView *itemBgView = [[UIView alloc] init];
            [bgView addSubview:itemBgView];
            [itemBgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.and.right.equalTo(bgView);
                make.height.mas_equalTo(height);
                if (!previouslyView) {
                    make.top.equalTo(bgImgView);
                } else {
                    make.top.equalTo(previouslyView.mas_bottom);
                }
            }];
            previouslyView = itemBgView;
            
            NSDictionary *goodsItem = goods[i];
            NSString *goodsName = goodsItem[@"goodsName"];
            NSString *goodsNumber = goodsItem[@"goodsNumber"];
            NSString *goodsMoney = goodsItem[@"goodsMoney"];
            
            if (goodsName) {
                UILabel *goodsNameLabel = [[UILabel alloc] init];
                [itemBgView addSubview:goodsNameLabel];
                goodsNameLabel.text = goodsName;
                goodsNameLabel.textColor = [UIColor whiteColor];
                goodsNameLabel.font = [UIFont bold13];
                [goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(itemBgView);
                    make.left.equalTo(itemBgView).offset(10);
                }];
            }
            
            UILabel *goodsNumberLabel = [[UILabel alloc] init];
            [itemBgView addSubview:goodsNumberLabel];
            goodsNumberLabel.text = goodsNumber;
            goodsNumberLabel.textColor = [UIColor whiteColor];
            goodsNumberLabel.font = [UIFont bold13];
            goodsNumberLabel.textAlignment = NSTextAlignmentRight;
            [goodsNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(itemBgView);
                make.left.equalTo(itemBgView.mas_centerX).offset(30);
            }];
            
            UILabel *moneyLabel = [[UILabel alloc] init];
            [itemBgView addSubview:moneyLabel];
            moneyLabel.text = goodsMoney;
            moneyLabel.textColor = [UIColor whiteColor];
            if (i == [goods count] - 1) {
                moneyLabel.textColor = [UIColor ktvRed];
            }
            moneyLabel.font = [UIFont bold13];
            [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(itemBgView);
                make.right.equalTo(itemBgView.mas_right).offset(-20);
            }];
        }
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
