//
//  KTVUserPhontosCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/5.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVUserPhontosCell.h"

#import "KTVUserPhotoCollectionCell.h"

@interface KTVUserPhontosCell ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *photosCollectionView;

@end

static NSInteger RowCount = 4;

@implementation KTVUserPhontosCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.photosCollectionView.delegate = self;
    self.photosCollectionView.dataSource = self;
    [self setupUI];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setupUI {
    self.photosCollectionView.backgroundColor = [UIColor ktvBG];
    self.photosCollectionView.collectionViewLayout = [self setupFlowLayout];
}

- (void)setPictureList:(NSArray *)pictureList {
    if (_pictureList != pictureList) {
        _pictureList = pictureList;
        
        [self.photosCollectionView reloadData];
    }
}

#pragma mark - CollectionView 布局

- (UICollectionViewFlowLayout *)setupFlowLayout {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    CGFloat iWith = (SCREENW / RowCount) - 5;
    flowLayout.itemSize = CGSizeMake(iWith, iWith);
    flowLayout.minimumLineSpacing = 5.0f;
    flowLayout.minimumInteritemSpacing = 5.0f;
    
    return flowLayout;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CLog(@"-- 点击用户了图片");
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.pictureList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KTVUserPhotoCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KTVUserPhotoCollectionCell" forIndexPath:indexPath];
    KTVPicture *pic = self.pictureList[indexPath.row];
    cell.picture = pic;
    return cell;
}

@end
