//
//  KTVChooseParttimeView.m
//  KTVBariOS
//
//  Created by pingjun lin on 2018/1/27.
//  Copyright © 2018年 Lin. All rights reserved.
//

#import "KTVChooseParttimeView.h"

@interface KTVChooseParttimeView()

@property (weak, nonatomic) IBOutlet UIView *monday;
@property (weak, nonatomic) IBOutlet UIView *tuesday;
@property (weak, nonatomic) IBOutlet UIView *wednesday;
@property (weak, nonatomic) IBOutlet UIView *thursday;
@property (weak, nonatomic) IBOutlet UIView *friday;
@property (weak, nonatomic) IBOutlet UIView *saturday;
@property (weak, nonatomic) IBOutlet UIView *sunday;
@property (weak, nonatomic) IBOutlet UIImageView *mondayIg;
@property (weak, nonatomic) IBOutlet UIImageView *tuesdayIg;
@property (weak, nonatomic) IBOutlet UIImageView *wednesdayIg;
@property (weak, nonatomic) IBOutlet UIImageView *thursdayIg;
@property (weak, nonatomic) IBOutlet UIImageView *fridayIg;
@property (weak, nonatomic) IBOutlet UIImageView *saturdayIg;
@property (weak, nonatomic) IBOutlet UIImageView *sundayIg;
@property (weak, nonatomic) IBOutlet UIButton *resetBtn;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

@property (nonatomic, strong) NSMutableDictionary *parttimeDic;

@end

@implementation KTVChooseParttimeView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.parttimeDic = [NSMutableDictionary dictionaryWithCapacity:7];
    
    UITapGestureRecognizer *mondayTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mondayTap)];
    [self.monday addGestureRecognizer:mondayTap];
    
    UITapGestureRecognizer *tuesdayTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tuesdayTap)];
    [self.tuesday addGestureRecognizer:tuesdayTap];
    
    UITapGestureRecognizer *wednesdayTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(wednesdayTap)];
    [self.wednesday addGestureRecognizer:wednesdayTap];
    
    UITapGestureRecognizer *thursdayTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(thursdayTap)];
    [self.thursday addGestureRecognizer:thursdayTap];
    
    UITapGestureRecognizer *fridayTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fridayTap)];
    [self.friday addGestureRecognizer:fridayTap];
    
    UITapGestureRecognizer *saturdayTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(saturdayTap)];
    [self.saturday addGestureRecognizer:saturdayTap];
    
    UITapGestureRecognizer *sundayTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sundayTap)];
    [self.sunday addGestureRecognizer:sundayTap];
}
//app_gou_red

- (void)mondayTap {
    [self.parttimeDic setObject:[NSNumber numberWithBool:![self.parttimeDic[@"1"] boolValue]] forKey:@"1"];
    [self changeParttimeStatus];
}

- (void)tuesdayTap {
    [self.parttimeDic setObject:[NSNumber numberWithBool:![self.parttimeDic[@"2"] boolValue]] forKey:@"2"];
    [self changeParttimeStatus];
}

- (void)wednesdayTap {
    [self.parttimeDic setObject:[NSNumber numberWithBool:![self.parttimeDic[@"3"] boolValue]] forKey:@"3"];
    [self changeParttimeStatus];
}

- (void)thursdayTap {
    [self.parttimeDic setObject:[NSNumber numberWithBool:![self.parttimeDic[@"4"] boolValue]] forKey:@"4"];
    [self changeParttimeStatus];
}

- (void)fridayTap {
    [self.parttimeDic setObject:[NSNumber numberWithBool:![self.parttimeDic[@"5"] boolValue]] forKey:@"5"];
    [self changeParttimeStatus];
}

- (void)saturdayTap {
    [self.parttimeDic setObject:[NSNumber numberWithBool:![self.parttimeDic[@"6"] boolValue]] forKey:@"6"];
    [self changeParttimeStatus];
}

- (void)sundayTap {
    [self.parttimeDic setObject:[NSNumber numberWithBool:![self.parttimeDic[@"7"] boolValue]] forKey:@"7"];
    [self changeParttimeStatus];
}

- (void)changeParttimeStatus {
    for (NSString *key in self.parttimeDic.allKeys) {
        BOOL isSel = [self.parttimeDic[key] boolValue];
        if ([key isEqualToString:@"1"]) {
            self.mondayIg.image = isSel ? [UIImage imageNamed:@"app_gou_red"] : [UIImage imageNamed:@"app_kuang_red"];
        } else if ([key isEqualToString:@"2"]) {
             self.tuesdayIg.image = isSel ? [UIImage imageNamed:@"app_gou_red"] : [UIImage imageNamed:@"app_kuang_red"];
        } else if ([key isEqualToString:@"3"]) {
             self.wednesdayIg.image = isSel ? [UIImage imageNamed:@"app_gou_red"] : [UIImage imageNamed:@"app_kuang_red"];
        } else if ([key isEqualToString:@"4"]) {
             self.thursdayIg.image = isSel ? [UIImage imageNamed:@"app_gou_red"] : [UIImage imageNamed:@"app_kuang_red"];
        } else if ([key isEqualToString:@"5"]) {
             self.fridayIg.image = isSel ? [UIImage imageNamed:@"app_gou_red"] : [UIImage imageNamed:@"app_kuang_red"];
        } else if ([key isEqualToString:@"6"]) {
             self.saturdayIg.image = isSel ? [UIImage imageNamed:@"app_gou_red"] : [UIImage imageNamed:@"app_kuang_red"];
        } else if ([key isEqualToString:@"7"]) {
             self.sundayIg.image = isSel ? [UIImage imageNamed:@"app_gou_red"] : [UIImage imageNamed:@"app_kuang_red"];
        }
    }
}

#pragma mark - 事件

- (IBAction)resetAction:(id)sender {
    for (NSString *key in self.parttimeDic.allKeys) {
        [self.parttimeDic setObject:[NSNumber numberWithBool:NO] forKey:key];
    }
    [self changeParttimeStatus];
}

- (IBAction)confirmAction:(id)sender {
    [self removeFromSuperview];
    if (self.confirmBackBack) self.confirmBackBack(self.parttimeDic);
}
@end
