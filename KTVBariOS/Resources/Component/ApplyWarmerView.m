//
//  ApplyWarmerView.m
//  KTVBariOS
//
//  Created by pingjun lin on 2018/1/27.
//  Copyright © 2018年 Lin. All rights reserved.
//

#import "ApplyWarmerView.h"

@interface ApplyWarmerView()

@property (weak, nonatomic) IBOutlet UIImageView *idZhengMianImageView;
@property (weak, nonatomic) IBOutlet UIImageView *idFanMainImageView;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *idTF;
@property (weak, nonatomic) IBOutlet UITextField *mobileTF;
@property (weak, nonatomic) IBOutlet UITextField *addressTF;

@end

@implementation ApplyWarmerView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UITapGestureRecognizer *tapZm = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zhengmianIdAction)];
    [self.idZhengMianImageView addGestureRecognizer:tapZm];
    
    UITapGestureRecognizer *tapFm = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fanmianIdAction)];
    [self.idFanMainImageView addGestureRecognizer:tapFm];
}

- (void)setUserIdentifier:(NSDictionary *)info {
    if ([info objectForKey:@"id_zhengmian"]) {
        self.idZhengMianImageView.image = [info objectForKey:@"id_zhengmian"];
    }
    if ([info objectForKey:@"id_fanmian"]) {
        self.idFanMainImageView.image = [info objectForKey:@"id_fanmian"];
    }
}

- (IBAction)uploadVedioAction:(id)sender {
    CLog(@"-->> 上传视频")
    if (self.uploadVedioCallback) self.uploadVedioCallback();
}

#pragma mark - 证件上传

- (void)zhengmianIdAction {
    if (self.uploadIDCallback) self.uploadIDCallback(YES);
}

- (void)fanmianIdAction {
    if (self.uploadIDCallback) self.uploadIDCallback(NO);
}

- (NSDictionary *)obtainWarmerInfo {
    NSMutableDictionary *warmerInfoDic = [[NSMutableDictionary alloc] initWithCapacity:4];
    NSString *name = self.nameTF.text;
    if (name.length) {
        [warmerInfoDic setObject:name forKey:@"realName"];
    }
//    NSString *identify = self.idTF.text;
//    if (identify.length) {
//        [warmerInfoDic setObject:identify forKey:@"identify"];
//    }
    NSString *mobile = self.mobileTF.text;
    if (mobile.length) {
        [warmerInfoDic setObject:mobile forKey:@"username"];
    } else {
        NSString *userName = [KTVCommon userInfo].username;
        [warmerInfoDic setObject:(userName ? userName : @"")  forKey:@"username"];
    }
    
    if ([KTVCommon userInfo].realName) {
        [warmerInfoDic setObject:[KTVCommon userInfo].realName forKey:@"realName"];
    }
    
    NSString *address = self.addressTF.text;
    if (address.length) {
        [warmerInfoDic setObject:address forKey:@"addressDetail"];
    }
    
    return warmerInfoDic;
}

@end
