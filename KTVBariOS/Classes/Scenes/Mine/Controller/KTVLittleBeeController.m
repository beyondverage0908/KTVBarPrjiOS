//
//  KTVLittleBeeController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/10/31.
//  Copyright © 2017年 Lin. All rights reserved.
//
//  小蜜蜂用户详情

#import "KTVLittleBeeController.h"

#import "KTVBeeHeaderCell.h"
#import "KTVBeeInfoCell.h"
#import "KTVBeeDescriptionCell.h"
#import "KSPhotoBrowser.h"
#import "KTVTableHeaderView.h"
#import "KTVMediaCell.h"
#import "KTVInvitingTACell.h"
#import <AVKit/AVKit.h>
#import "KTVCommentCell.h"
#import "KTVMainService.h"

@interface KTVLittleBeeController ()<UITableViewDelegate, UITableViewDataSource, KSPhotoBrowserDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray<KTVComment *> *commentList;

@end

@implementation KTVLittleBeeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"小蜜蜂详情";
    
    self.tableView.backgroundColor = [UIColor ktvBG];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self getActivityComment];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - override

- (NSMutableArray<KTVComment *> *)commentList {
    if (!_commentList) {
        _commentList = [NSMutableArray array];
    }
    return _commentList;
}

#pragma mark - 网络

- (void)getActivityComment {
    NSDictionary *param = @{@"userId": @"9", @"currentIndex" : @0, @"pageSize" : @5};
    [KTVMainService postQueryActorComment:param result:^(NSDictionary *result) {
        if ([result[@"code"] isEqualToString:ktvCode]) {
            for (NSDictionary *dic in result[@"data"]) {
                KTVComment *comment = [KTVComment yy_modelWithDictionary:dic];
                [self.commentList addObject:comment];
            }
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:4] withRowAnimation:UITableViewRowAnimationNone];
        }
    }];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 287.0f;
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return 90.0f;
        } else {
            return 130.0f;
        }
    } else if (indexPath.section == 2) {
        return 112.0f;
    } else if (indexPath.section == 4) {
        KTVComment *comment = self.commentList[indexPath.row];
        if ([comment.pictureList count]) {
            return 185;
        } else {
            return 92;
        }
    } else if (indexPath.section == 5) {
        return 87;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1 || section == 2 || section == 3 || section == 4) {
        return 28;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:nil title:@"个人视频" remark:nil];
        return headerView;
    } else if (section == 2) {
        KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:nil title:@"个人简介" remark:nil];
        return headerView;
    } else if (section == 3) {
        KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:nil title:@"最新动态" remark:nil];
        return headerView;
    } else if (section == 4) {
        KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:nil title:@"评价" remark:nil];
        return headerView;
    }
    return nil;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 2;
    } else if (section == 2) {
        return 1;
    } else if (section == 3) {
        return 0;
    } else if (section == 4) {
        return [self.commentList count];
    } else if (section == 5) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        KTVBeeHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVBeeHeaderCell)];
        cell.user = self.user;
        @WeakObj(self);
        cell.userImageTapCallback = ^(NSInteger index, NSArray<KTVPicture *> *pictureList) {
            NSMutableArray *urlItems = @[].mutableCopy;
            for (KTVPicture *pic in pictureList) {
                KSPhotoItem *item = [KSPhotoItem itemWithSourceView:[UIImageView new] imageUrl:[NSURL URLWithString:pic.pictureUrl]];
                [urlItems addObject:item];
            }
            KSPhotoBrowser *browser = [KSPhotoBrowser browserWithPhotoItems:urlItems selectedIndex:index];
            browser.dismissalStyle = KSPhotoBrowserInteractiveDismissalStyleRotation;
            browser.backgroundStyle = KSPhotoBrowserBackgroundStyleBlur;
            browser.loadingStyle = KSPhotoBrowserImageLoadingStyleIndeterminate;
            browser.pageindicatorStyle = KSPhotoBrowserPageIndicatorStyleText;
            browser.bounces = NO;
            [browser showFromViewController:weakself];
        };
        return cell;
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            KTVMediaCell *cell = [[KTVMediaCell alloc] initWithMediaList:self.user.videoList style:UITableViewCellStyleDefault reuseIdentifier:@"KTVMediaCell"];
            @WeakObj(self);
            cell.showMediaCallback = ^(id media) {
                if ([media isKindOfClass:[KTVVideo class]]) {
                    KTVVideo *video = (KTVVideo *)media;
                    [weakself playVideaUrl:video.url];
                }
            };
            return cell;
        } else {
            KTVBeeInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVBeeInfoCell)];
            cell.user = self.user;
            return cell;
        }
    } else if (indexPath.section == 2) {
        KTVBeeDescriptionCell *cell = [tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVBeeDescriptionCell)];
        cell.user = self.user;
        return cell;
    } else if (indexPath.section == 4) {
        KTVCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVCommentCell)];
        KTVComment *comment = self.commentList[indexPath.row];
        cell.comment = comment;
        @WeakObj(self);
        cell.commentImageBrowsingCallBack = ^(NSInteger idx, KTVComment *comment) {
            NSMutableArray *urlList = @[].mutableCopy;
            for (KTVPicture *pic in comment.pictureList) {
                [urlList addObject:pic.pictureUrl];
            }
            [weakself browserImageWithPictureUrl:[urlList copy] currentIndex:idx];
        };
        return cell;
    } else if (indexPath.section == 5) {
        KTVInvitingTACell *cell = [tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVInvitingTACell)];
        cell.invitedCallback = ^{
            [KTVToast toast:@"邀约成功"];
        };
        return cell;
    }
    return [UITableViewCell new];
}

#pragma mark - KSPhotoBrowser

- (void)browserImageWithPictureUrl:(NSArray<NSString *> *)picUrlList currentIndex:(NSInteger)currentIndex {
    NSMutableArray *urlItems = @[].mutableCopy;
    for (NSString *url in picUrlList) {
        KSPhotoItem *item = [KSPhotoItem itemWithSourceView:[UIImageView new] imageUrl:[NSURL URLWithString:url]];
        [urlItems addObject:item];
    }
    KSPhotoBrowser *browser = [KSPhotoBrowser browserWithPhotoItems:urlItems selectedIndex:currentIndex];
    browser.delegate = self;
    browser.dismissalStyle = KSPhotoBrowserInteractiveDismissalStyleRotation;
    browser.backgroundStyle = KSPhotoBrowserBackgroundStyleBlur;
    browser.loadingStyle = KSPhotoBrowserImageLoadingStyleIndeterminate;
    browser.pageindicatorStyle = KSPhotoBrowserPageIndicatorStyleText;
    browser.bounces = NO;
    [browser showFromViewController:self];
}


#pragma mark - 播放视频

- (void)playVideaUrl:(NSString *)videaUrl {
    //    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Alladin" withExtension:@"mp4"];
    if (videaUrl) {
        NSURL *url = [NSURL URLWithString:videaUrl];
        AVAsset *asset = [AVURLAsset URLAssetWithURL:url options:nil];
        AVPlayerItem *item = [AVPlayerItem playerItemWithAsset:asset];
        AVPlayer *player = [AVPlayer playerWithPlayerItem:item];
        
        AVPlayerViewController *playController = [[AVPlayerViewController alloc] init];
        playController.player = player;
        [playController.player play];
        [self presentViewController:playController animated:YES completion:nil];
    } else {
        [KTVToast toast:TOAST_VIDEO_CANT_PLAY];
    }
}

// MARK: - KSPhotoBrowserDelegate

- (void)ks_photoBrowser:(KSPhotoBrowser *)browser didSelectItem:(KSPhotoItem *)item atIndex:(NSUInteger)index {
    NSLog(@"selected index: %ld", index);
}

@end
