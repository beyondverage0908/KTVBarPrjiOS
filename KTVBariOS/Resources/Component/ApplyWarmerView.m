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
    
    CLog(@"--->>> 222");
}

- (IBAction)uploadVedioAction:(id)sender {
    CLog(@"-->> 上传视频")
}
@end
