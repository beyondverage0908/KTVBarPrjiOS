//
//  KTVInvitatingCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2018/1/21.
//  Copyright © 2018年 Lin. All rights reserved.
//

#import "KTVInvitatingCell.h"

@interface KTVInvitatingCell()

@property (weak, nonatomic) IBOutlet UIButton *acceptBtn;
@property (weak, nonatomic) IBOutlet UIButton *refuseBtn;
@property (weak, nonatomic) IBOutlet UILabel *storeName;
@property (weak, nonatomic) IBOutlet UILabel *leftTime;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *price;

@property (strong, nonatomic) AMapReGeocodeSearchRequest *regeo;

@end

@implementation KTVInvitatingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // 地理位置
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
}

- (IBAction)refuseAction:(id)sender {
    CLog(@"-->> 拒绝");
    if (self.denyCallback) self.denyCallback(self.warmerOrder);
}

- (IBAction)acceptAction:(id)sender {
    CLog(@"-->> 接受");
    if (self.agreeCallback) self.agreeCallback(self.warmerOrder);
}

- (void)setWarmerOrder:(KTVWarmerOrder *)warmerOrder {
    if (_warmerOrder != warmerOrder) {
        _warmerOrder = warmerOrder;
        // UI赋值
        self.storeName.text = _warmerOrder.storeName;
        self.leftTime.text = @"";
        self.location.text = [NSString stringWithFormat:@"正在定位中..."];
        self.time.text = _warmerOrder.createTime;
        self.price.text = [NSString stringWithFormat:@"%@¥/场", _warmerOrder.price];
        
        
        self.regeo = [[AMapReGeocodeSearchRequest alloc] init];
        self.regeo.location = [AMapGeoPoint locationWithLatitude:_warmerOrder.latitude.floatValue longitude:_warmerOrder.longitude.floatValue];
        // self.regeo.location = [AMapGeoPoint locationWithLatitude:22.962145 longitude:113.982667];
        self.regeo.requireExtension            = YES;
        [self.search AMapReGoecodeSearch:self.regeo];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    UIColor *originAcceptColor = self.acceptBtn.backgroundColor;
    UIColor *originRefuseColor = self.refuseBtn.backgroundColor;
    
    [super setSelected:selected animated:animated];
    
    self.acceptBtn.backgroundColor = originAcceptColor;
    self.refuseBtn.backgroundColor = originRefuseColor;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    UIColor *originAcceptColor = self.acceptBtn.backgroundColor;
    UIColor *originRefuseColor = self.refuseBtn.backgroundColor;
    
    [super setHighlighted:highlighted animated:animated];
    
    self.acceptBtn.backgroundColor = originAcceptColor;
    self.refuseBtn.backgroundColor = originRefuseColor;
}


#pragma mark - 搞的回调

/* 逆地理编码回调. */
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if (response.regeocode != nil)
    {
        //解析response获取地址描述，具体解析见 Demo
        self.location.text = [NSString stringWithFormat:@"%@ %@米",
                              response.regeocode.addressComponent.streetNumber.street,
                              @(response.regeocode.addressComponent.streetNumber.distance)];
    }
}

- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", error);
}

@end
