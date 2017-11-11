//
//  KTVStatusView.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/11/11.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVStatusView.h"

@interface KTVStatusView ()

@property (strong, nonatomic) NSArray<KTVStatus *> *statusList;

@end

@implementation KTVStatusView

- (instancetype)initWithStatusList:(NSArray<KTVStatus *> *)statusList{
    self = [super init];
    if (self) {
        
        self.statusList = statusList;
        
        if ([statusList count]) {
            UIImageView *bgImageView = [[UIImageView alloc] init];
            bgImageView.image = [UIImage imageNamed:@"mainpage_all_bg_line"];
            bgImageView.userInteractionEnabled = YES;
            [self addSubview:bgImageView];
            [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self);
            }];
            
            CGFloat wp = 1.0f / [statusList count];
            UIButton *lastBtn = nil;
            for (NSInteger i = 0; i < [statusList count]; i++) {
                
                KTVStatus *status = statusList[i];
                
                UIButton *btn = [[UIButton alloc] init];
                [self addSubview:btn];
                btn.tag = 1000 + i;
                [btn addTarget:self action:@selector(filterBtnAction:) forControlEvents:UIControlEventTouchUpInside];
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.height.equalTo(bgImageView);
                    make.width.equalTo(bgImageView).multipliedBy(wp);
                    make.centerY.equalTo(bgImageView);
                    if (!lastBtn) {
                        make.left.equalTo(bgImageView);
                    } else {
                        make.left.equalTo(lastBtn.mas_right);
                    }
                }];
                lastBtn = btn;
                
                UILabel *titleLabel = [[UILabel alloc] init];
                [btn addSubview:titleLabel];
                titleLabel.tag = 2000 + i;
                titleLabel.text = status.title;
                titleLabel.textColor = [UIColor whiteColor];
                titleLabel.font = [UIFont boldSystemFontOfSize:14];
                [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(btn);
                    make.centerX.offset(-5);
                }];
                
                UIView *bottomLine = [[UIView alloc] init];
                [btn addSubview:bottomLine];
                bottomLine.tag = 3000 + i;
                bottomLine.backgroundColor = [UIColor clearColor];
                [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(btn);
                    make.height.mas_equalTo(@3.0);
                    make.width.mas_equalTo(btn).multipliedBy(0.65);
                    make.centerX.equalTo(btn);
                }];
                
                if (i > 0) {
                    UIView *verLine = [[UIView alloc] init];
                    [btn addSubview:verLine];
                    verLine.backgroundColor = [UIColor whiteColor];
                    [verLine mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.width.mas_equalTo(@1.5);
                        make.centerY.equalTo(btn);
                        make.height.equalTo(btn).multipliedBy(0.5f);
                        make.left.equalTo(btn.mas_left);
                    }];
                }
            }
        }
    }
    return self;
}

- (void)filterBtnAction:(UIButton *)filterBtn {
    NSInteger idx = filterBtn.tag - 1000;
    UILabel *titleLabel = (UILabel *)[filterBtn viewWithTag:2000 + idx];
    UIView *bottomLine = (UIView *)[filterBtn viewWithTag:3000 + idx];
    titleLabel.textColor = [UIColor ktvRed];
    bottomLine.backgroundColor = [UIColor ktvRed];
    
    for (NSInteger i = 0; i < self.statusList.count; i++) {
        if (i != idx) {
            KTVStatus *status = self.statusList[idx];
            status.isSelect = NO;
            
            NSInteger tag = 1000 + i;
            UIButton *btn = [self viewWithTag:tag];
            
            UILabel *titleLabel = (UILabel *)[btn viewWithTag:2000 + i];
            UIView *bottomLine = (UIView *)[btn viewWithTag:3000 + i];
            titleLabel.textColor = [UIColor whiteColor];
            bottomLine.backgroundColor = [UIColor clearColor];
        }
    }
    
    KTVStatus *status = self.statusList[idx];
    status.isSelect = YES;
    if (self.selectedStatusCallback) {
        self.selectedStatusCallback(status);
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    CLog(@"keyPath -->>>%@--->>>%@-->>>%@", keyPath, change, context);
}

@end
