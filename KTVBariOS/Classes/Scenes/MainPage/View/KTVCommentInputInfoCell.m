//
//  KTVCommentInputInfoCell.m
//  AFNetworking
//
//  Created by pingjun lin on 2018/6/12.
//

#import "KTVCommentInputInfoCell.h"

@interface KTVCommentInputInfoCell()

@property (weak, nonatomic) IBOutlet UIView *starContainerView;
@property (weak, nonatomic) IBOutlet UITextView *commentInfoTextView;
@property (weak, nonatomic) IBOutlet UIImageView *firstImageView;
@property (weak, nonatomic) IBOutlet UIImageView *secondImageView;
@property (weak, nonatomic) IBOutlet UIImageView *thirdImageView;

@property (assign, nonatomic) NSInteger tapStarNumber;

@end

@implementation KTVCommentInputInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.commentInfoTextView.layer.cornerRadius = 5;
    
    self.starContainerView.backgroundColor = [UIColor ktvBG];
    
    [self addImageView:self.firstImageView cornerRadius:5];
    [self addImageView:self.secondImageView cornerRadius:5];
    [self addImageView:self.thirdImageView cornerRadius:5];
    
    UIView *lastView = nil;
    for (NSInteger i = 0; i < 5; i++) {
        UIImageView *startImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainpage_list_start_empty"]];
        startImageView.tag = 100 + i;
        startImageView.userInteractionEnabled = YES;
        [self.starContainerView addSubview:startImageView];
        [startImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.starContainerView);
            make.width.and.height.equalTo(@20);
            if (i == 0) {
                make.left.equalTo(self.starContainerView.mas_left).offset(5);
            } else {
                make.left.equalTo(lastView.mas_right).offset(5);
            }
        }];
        lastView = startImageView;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setCommentOfStar:)];
        [startImageView addGestureRecognizer:tap];
    }
}

- (void)addImageView:(UIImageView *)imageView cornerRadius:(CGFloat)radius {
    imageView.layer.cornerRadius = radius;
    imageView.layer.borderWidth = 1;
    imageView.layer.borderColor = [UIColor whiteColor].CGColor;
}

#pragma mark - 事件

- (void)setCommentOfStar:(UITapGestureRecognizer *)tap {
    // 当前选中几颗星
    self.tapStarNumber = tap.view.tag - 100;
    for (NSInteger i = 0; i < 5; i++) {
        UIView *tapView = [self.starContainerView.subviews objectAtIndex:i];
        if (i <= tap.view.tag - 100) {
            if ([tapView isKindOfClass:[UIImageView class]]) {
                ((UIImageView *)tapView).image = [UIImage imageNamed:@"mainpage_list_start"];
            }
        } else {
            if ([tapView isKindOfClass:[UIImageView class]]) {
                ((UIImageView *)tapView).image = [UIImage imageNamed:@"mainpage_list_start_empty"];
            }
        }
    }
}

@end
