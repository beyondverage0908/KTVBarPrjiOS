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
#import <AVKit/AVKit.h>

@interface KTVLittleBeeController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation KTVLittleBeeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"小蜜蜂详情";
    
    self.tableView.backgroundColor = [UIColor ktvBG];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    return 5;
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
        return 0;
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
    }
    return [UITableViewCell new];
}

#pragma mark - KSPhotoBrowser


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

@end
