//
//  KTVBuycarPickerView.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/27.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVBuycarPickerView.h"

@interface KTVBuycarPickerView ()

@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UIView *counterNumberView;

@end

@implementation KTVBuycarPickerView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.counterNumberView.layer.borderWidth = 0.5f;
    self.counterNumberView.layer.borderColor = [UIColor ktvPlaceHolder].CGColor;
}

- (void)setTempGood:(KTVGood *)tempGood {
    if (_tempGood != tempGood) {
        
        _tempGood = tempGood;
        [self.itemImageView sd_setImageWithURL:[NSURL URLWithString:_tempGood.picture.pictureUrl] placeholderImage:[UIImage imageNamed:@"dianpu_dandian"]];
        self.nameLabel.text = _tempGood.goodName;
    }
}

- (void)setShopCart:(NSMutableDictionary<NSString *, id> *)shopCart {
    if (!_shopCart) {
        _shopCart = shopCart;
        
        self.numberLabel.text = [NSString stringWithFormat:@"%@", _shopCart[@"goodCount"]];
        self.moneyLabel.text = [NSString stringWithFormat:@"%@", @([_shopCart[@"goodCount"] integerValue] * self.tempGood.goodPrice.floatValue)];
    }
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

/// 清空购物车
- (void)clearCart {
    if (self.shopCart) {
        self.shopCart[@"goodCount"] = @(0);
    }
}

- (IBAction)reduceNumberAction:(UIButton *)sender {

    CLog(@"--->>> 数量减少");
    KTVGood *good = self.shopCart[@"goodKey"];
    [self removeGoodFromCart];
    self.moneyLabel.text = [NSString stringWithFormat:@"%@", @([self getCartAllPrice])];
    self.numberLabel.text = [NSString stringWithFormat:@"%@", @([self getCartCount])];
    
    if (self.operateShoppingCartCallBack) {
        self.operateShoppingCartCallBack(YES, good);
    }
}

- (IBAction)incrementNumberAction:(UIButton *)sender {

    [self addGoodToCart];
    self.moneyLabel.text = [NSString stringWithFormat:@"%@", @([self getCartAllPrice])];
    self.numberLabel.text = [NSString stringWithFormat:@"%@", @([self getCartCount])];
    
    if (self.operateShoppingCartCallBack) {
        self.operateShoppingCartCallBack(YES, self.tempGood);
    }
    CLog(@"--->>> 数量增加");
}

- (IBAction)cancelAction:(UIButton *)sender {
    CLog(@"--->>> 单点取消");
    
    [self clearCart];
    self.moneyLabel.text = [NSString stringWithFormat:@"%@", @([self getCartAllPrice])];
    self.numberLabel.text = [NSString stringWithFormat:@"%@", @([self getCartCount])];
}

- (IBAction)confirmAction:(UIButton *)sender {
    CLog(@"--->>> 单点确定");
    if (self.operateShoppingCartCompeletion) {
        self.operateShoppingCartCompeletion(YES, self.shopCart);
    }
    [self removeFromSuperview];
}

@end
