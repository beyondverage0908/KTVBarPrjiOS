//
//  ThreeRightView.m
//  Frame
//
//  Created by 栗子 on 2017/9/7.
//  Copyright © 2017年 http://www.cnblogs.com/Lrx-lizi/. All rights reserved.
//

#import "KTVThreeRightView.h"
#import "KTVThirdRightTableViewCell.h"
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

@interface KTVThreeRightView ()<UITableViewDelegate,UITableViewDataSource> {
    UITableView *tableVIew;
}

@property(nonatomic,strong)UIView      *parentView;
@property(nonatomic,strong)NSArray     *imageArr;
@property(nonatomic,strong)NSArray     *textArray;
@end


@implementation KTVThreeRightView


- (instancetype)initCustomImageArray:(NSArray *)imageArr textArray:(NSArray *)textArr selfFrame:(CGRect)frame{

    if (self = [super init]) {
        if (self.parentView ==nil) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,SCREEN_HEIGHT)];
            view.userInteractionEnabled = YES;
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressParentView)];
            [view addGestureRecognizer:tap];
            view.backgroundColor = [UIColor blackColor];
            view.alpha = 0.1;
            [[UIApplication sharedApplication].keyWindow addSubview:view];
            self.parentView = view;
        }
        
        self.frame = frame;
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        self.backgroundColor = [UIColor clearColor];
       
        self.imageArr = imageArr;
        self.textArray = textArr;
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews{

    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width - 30, 0, 15, 15)];
    image.image = [UIImage imageNamed:@"this_bg_ssj"];
    [self addSubview:image];
    
    tableVIew = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(image.frame), self.frame.size.width, self.frame.size.height-15) style:UITableViewStylePlain];
    tableVIew.backgroundColor = [UIColor whiteColor];
    tableVIew.delegate = self;
    tableVIew.dataSource = self;
    tableVIew.layer.cornerRadius = 5;
    tableVIew.layer.masksToBounds = YES;
    [self addSubview:tableVIew];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.textArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KTVThirdRightTableViewCell *cell = [tableVIew dequeueReusableCellWithIdentifier:@"KTVThirdRightTableViewCell"];
    if (!cell) {
        cell = [[KTVThirdRightTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"KTVThirdRightTableViewCell"];
    }
    NSString *iconImgName = self.imageArr[indexPath.row];
    UIImage *img = nil;
    if (iconImgName) {
        img = [UIImage imageNamed:iconImgName];
    }
    [cell iconiv:img titleText:[NSString stringWithFormat:@"%@",self.textArray[indexPath.row]]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    if (self.selectRowBlock) {
        self.selectRowBlock(row);
    }
    [self hide:YES];//点完一个就关闭
    
}
- (void)pressParentView{
    _closeOnTouchUpOutside = !_closeOnTouchUpOutside;
    
    if (_closeOnTouchUpOutside)
    {
        [self hide:YES];
    }
}
- (void)show:(BOOL)animated
{
    if (animated)
    {
        
        self.transform = CGAffineTransformMakeScale(0.6f , 0.6f);
        self.alpha = 0.0f;
        self.parentView.alpha = 0.0f;
        __weak typeof(self) weakSelf = self;
        
        [UIView animateWithDuration:0.2 animations:^{
            weakSelf.transform = CGAffineTransformIdentity;
            weakSelf.alpha = 1.0f;
            weakSelf.parentView.alpha = 0.5f;
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)hide:(BOOL)animated
{
    [self endEditing:YES];
    if (animated)
    {
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:0.2 animations:^{
            weakSelf.parentView.alpha = 0.0f;
            weakSelf.transform = CGAffineTransformMakeScale(0.2f , 0.2f);
            weakSelf.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [weakSelf removeFromSuperview];
            [weakSelf.parentView removeFromSuperview];
        }];
    }
}


@end
