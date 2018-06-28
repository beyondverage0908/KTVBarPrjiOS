//
//  KTVCommonCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/13.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVCommentCell.h"
#import "KTVStarView.h"

@interface KTVCommentCell ()

@property (weak, nonatomic) IBOutlet KTVStarView *starView;
@property (weak, nonatomic) IBOutlet UIImageView *userHeaderImageView;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentTime;
@property (weak, nonatomic) IBOutlet UILabel *commentDescLabel;
@property (weak, nonatomic) IBOutlet UIImageView *firstImageView;
@property (weak, nonatomic) IBOutlet UIImageView *secondImageView;
@property (weak, nonatomic) IBOutlet UIImageView *thirdImageView;

@end

@implementation KTVCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.firstImageView.tag = 100;
    self.secondImageView.tag = 101;
    self.thirdImageView.tag = 102;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageBrowsingAction:)];
    [self.firstImageView addGestureRecognizer:tap];
    [self.secondImageView addGestureRecognizer:tap];
    [self.thirdImageView addGestureRecognizer:tap];
}

- (void)setComment:(KTVComment *)comment {
    if (_comment != comment) {
        _comment = comment;
        
        if (_comment.star.integerValue == 0) {
            _comment.star = @"5";
        }
        self.starView.stars = _comment.star.integerValue;
        self.commentTime.text = _comment.createTime;
        if (!_comment.desc) {
            _comment.desc = @"默认好评";
        }
        self.commentDescLabel.text = _comment.desc;
        
        if (_comment.pictureList.count == 0) {
            self.firstImageView.hidden = YES;
            self.secondImageView.hidden = YES;
            self.thirdImageView.hidden = YES;
        } else if (_comment.pictureList.count == 1) {
            self.secondImageView.hidden = YES;
            self.thirdImageView.hidden = YES;
        } else if (_comment.pictureList.count == 2) {
            self.thirdImageView.hidden = YES;
        }
        
        if (_comment.pictureList.count) {
            for (NSInteger i = 0; i < _comment.pictureList.count; i++) {
                if (i == 0) {
                    [self.firstImageView sd_setImageWithURL:[NSURL URLWithString:_comment.pictureList[i].pictureUrl] placeholderImage:[UIImage imageNamed:@"bar_detail_comment_placehoder"]];
                } else if (i == 1) {
                    [self.secondImageView sd_setImageWithURL:[NSURL URLWithString:_comment.pictureList[i].pictureUrl] placeholderImage:[UIImage imageNamed:@"bar_detail_comment_placehoder"]];
                } else if (i == 2) {
                    [self.thirdImageView sd_setImageWithURL:[NSURL URLWithString:_comment.pictureList[i].pictureUrl] placeholderImage:[UIImage imageNamed:@"bar_detail_comment_placehoder"]];
                }
            }
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - 事件

- (void)imageBrowsingAction:(UITapGestureRecognizer *)tap {
    UIView *tapView = tap.view;
    
    NSInteger idx = 0;
    if (tapView.tag == 100) {
        idx = 0;
    } else if (tapView.tag == 101) {
        idx = 1;
    } else if (tapView.tag == 102) {
        idx = 2;
    }
    if (self.commentImageBrowsingCallBack) {
        self.commentImageBrowsingCallBack(idx, self.comment);
    }
}
@end
