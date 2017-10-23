//
//  KTVAddMediaCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/10/19.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVAddMediaCell.h"

@interface KTVAddMediaCell()

@property (strong, nonatomic) UIView *horiContentView;

@property (strong, nonatomic) NSMutableArray *vedioList;

@end

@implementation KTVAddMediaCell

#pragma mark - 重写

- (void)setPhotoList:(NSMutableArray *)photoList {
    _photoList = photoList;
}

- (NSMutableArray *)vedioList {
    if (!_vedioList) {
        _vedioList = [NSMutableArray array];
    }
    return _vedioList;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        if (!self.photoList) {
            self.photoList = [NSMutableArray arrayWithCapacity:10];
            [self.photoList addObject:@"1"];
        }
        
        UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainpage_all_bg_line"]];
        [self.contentView addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        [self.contentView addSubview:scrollView];
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        
        self.horiContentView = [[UIView alloc] init];
        [scrollView addSubview:self.horiContentView];
        [self.horiContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.equalTo(scrollView);
            make.height.equalTo(scrollView);
        }];
        
        UIView *lastView = nil;
        for (NSInteger i = 0; i < self.photoList.count; i++) {
            UIView *itemView = [[UIView alloc] init];
            [self.horiContentView addSubview:itemView];
            itemView.layer.borderColor = [UIColor whiteColor].CGColor;
            itemView.layer.borderWidth = 1.0;
            itemView.layer.cornerRadius = 3;
            
            [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                if (!lastView) {
                    make.left.equalTo(self.horiContentView).offset(3);
                } else {
                    make.left.equalTo(lastView.mas_right).offset(5);
                }
                make.width.height.equalTo(self.horiContentView.mas_height).multipliedBy(0.9);
                make.centerY.equalTo(self.horiContentView.mas_centerY);
                if (i == self.photoList.count - 1) {
                    make.right.equalTo(self.horiContentView.mas_right).offset(-3);
                }
            }];
            lastView = itemView;
            
            UIButton *addImgBtn = [[UIButton alloc] init];
            [itemView addSubview:addImgBtn];
            [addImgBtn setBackgroundImage:[UIImage imageNamed:@"mine_apply_store"] forState:UIControlStateNormal];
            [addImgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(itemView);
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
