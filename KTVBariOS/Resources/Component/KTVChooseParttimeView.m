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
    [self.parttimeDic setObject:[NSNumber numberWithBool:![self.parttimeDic[@"monday"] boolValue]] forKey:@"monday"];
    [self changeParttimeStatus];
}

- (void)tuesdayTap {
    [self.parttimeDic setObject:[NSNumber numberWithBool:![self.parttimeDic[@"tuesday"] boolValue]] forKey:@"tuesday"];
    [self changeParttimeStatus];
}

- (void)wednesdayTap {
    [self.parttimeDic setObject:[NSNumber numberWithBool:![self.parttimeDic[@"wednesday"] boolValue]] forKey:@"wednesday"];
    [self changeParttimeStatus];
}

- (void)thursdayTap {
    [self.parttimeDic setObject:[NSNumber numberWithBool:![self.parttimeDic[@"thursday"] boolValue]] forKey:@"thursday"];
    [self changeParttimeStatus];
}

- (void)fridayTap {
    [self.parttimeDic setObject:[NSNumber numberWithBool:![self.parttimeDic[@"friday"] boolValue]] forKey:@"friday"];
    [self changeParttimeStatus];
}

- (void)saturdayTap {
    [self.parttimeDic setObject:[NSNumber numberWithBool:![self.parttimeDic[@"saturday"] boolValue]] forKey:@"saturday"];
    [self changeParttimeStatus];
}

- (void)sundayTap {
    [self.parttimeDic setObject:[NSNumber numberWithBool:![self.parttimeDic[@"sunday"] boolValue]] forKey:@"sunday"];
    [self changeParttimeStatus];
}

- (void)changeParttimeStatus {
    for (NSString *key in self.parttimeDic.allKeys) {
        BOOL isSel = [self.parttimeDic[key] boolValue];
        if ([key isEqualToString:@"monday"]) {
            self.mondayIg.image = isSel ? [UIImage imageNamed:@"app_gou_red"] : [UIImage imageNamed:@"app_kuang_red"];
        } else if ([key isEqualToString:@"tuesday"]) {
             self.tuesdayIg.image = isSel ? [UIImage imageNamed:@"app_gou_red"] : [UIImage imageNamed:@"app_kuang_red"];
        } else if ([key isEqualToString:@"wednesday"]) {
             self.wednesdayIg.image = isSel ? [UIImage imageNamed:@"app_gou_red"] : [UIImage imageNamed:@"app_kuang_red"];
        } else if ([key isEqualToString:@"thursday"]) {
             self.thursdayIg.image = isSel ? [UIImage imageNamed:@"app_gou_red"] : [UIImage imageNamed:@"app_kuang_red"];
        } else if ([key isEqualToString:@"friday"]) {
             self.fridayIg.image = isSel ? [UIImage imageNamed:@"app_gou_red"] : [UIImage imageNamed:@"app_kuang_red"];
        } else if ([key isEqualToString:@"saturday"]) {
             self.saturdayIg.image = isSel ? [UIImage imageNamed:@"app_gou_red"] : [UIImage imageNamed:@"app_kuang_red"];
        } else if ([key isEqualToString:@"sunday"]) {
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
