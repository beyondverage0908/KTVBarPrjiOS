//
//  KTVBuycarSummaryCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/27.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVBuycarSummaryCell.h"

@interface KTVBuycarSummaryCell ()

@property (weak, nonatomic) IBOutlet UIImageView *itemImageview;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *summaryMoneyLabel;
@property (weak, nonatomic) IBOutlet UIView *counterView;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@end

@implementation KTVBuycarSummaryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.counterView.layer.borderWidth = 0.5f;
    self.counterView.layer.borderColor = [UIColor ktvPlaceHolder].CGColor;
}

/// 获取购物车数量
- (NSInteger)getCartCount {
    return [self.shopCart[@"goodCount"] integerValue];
}

/// 获取商品总价
- (float)getCartAllPrice {
    KTVGood *good = self.shopCart[@"goodKey"];
    return [self getCartCount] * [good.goodPrice floatValue];
}

/// 添加到购物车
- (void)addGoodToCart {
    if (self.shopCart) {
        self.shopCart[@"goodCount"] = @([self.shopCart[@"goodCount"] integerValue] + 1);
    }
}

/// 移除商品
- (void)removeGoodFromCart {
    if (self.shopCart) {
        NSInteger goodCount = [self.shopCart[@"goodCount"] integerValue] - 1;
        if (goodCount >= 0) {
            self.shopCart[@"goodCount"] = @(goodCount);
        }
    }
}

- (KTVGood *)getGood {
    if (self.shopCart) {
        return self.shopCart[@"goodKey"];
    }
    return nil;
}

/// 清空购物车
- (void)clearCart {
    if (self.shopCart) {
        self.shopCart[@"goodCount"] = @(0);
    }
}

- (void)setShopCart:(NSMutableDictionary<NSString *,id> *)shopCart {
    if (_shopCart != shopCart) {
        _shopCart = shopCart;
        
        KTVGood *good = [self getGood];
        
        [self.itemImageview sd_setImageWithURL:[NSURL URLWithString:good.picture.pictureUrl]
                              placeholderImage:[UIImage imageNamed:@"dianpu_dandian"]];
        self.nameLabel.text = [NSString stringWithFormat:@"%@", good.goodName];
        self.itemMoneyLabel.text = [NSString stringWithFormat:@"¥%@", good.goodPrice];
        self.summaryMoneyLabel.text = [NSString stringWithFormat:@"¥%@", @([self getCartAllPrice])];
        self.numberLabel.text = [NSString stringWithFormat:@"%@",@([self getCartCount])];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
- (IBAction)reduceAction:(UIButton *)sender {
    CLog(@"--->>> 减少一");
    [self removeGoodFromCart];
    self.numberLabel.text = [NSString stringWithFormat:@"%@", @([self getCartCount])];
    self.summaryMoneyLabel.text = [NSString stringWithFormat:@"¥%@", @([self getCartAllPrice])];
}

- (IBAction)incrementAction:(UIButton *)sender {
    CLog(@"--->>> 增加一");
    [self addGoodToCart];
    self.numberLabel.text = [NSString stringWithFormat:@"%@", @([self getCartCount])];
    self.summaryMoneyLabel.text = [NSString stringWithFormat:@"¥%@", @([self getCartAllPrice])];
}
@end
