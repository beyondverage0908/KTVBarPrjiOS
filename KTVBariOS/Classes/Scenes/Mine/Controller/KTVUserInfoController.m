//
//  KTVUserInfoController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/4.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVUserInfoController.h"

#import "KTVUserBannerCell.h"
#import "KTVUserPhontosCell.h"
#import "KTVUserSenseCell.h"
#import "KTVMediaCell.h"
#import "KTVLoginService.h"
#import "KTVMainService.h"
#import "KTVTableHeaderView.h"
#import <AVKit/AVKit.h>
#import "KSPhotoBrowser.h"
#import "KTVInvitingTACell.h"

@interface KTVUserInfoController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation KTVUserInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self setupUi];
    
    [self loadUserInfo];
}

- (void)setupUi {
    self.tableView.backgroundColor = [UIColor ktvBG];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self clearNavigationbar:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self clearNavigationbar:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 网络

// 获取用户详情
- (void)loadUserInfo {
    NSString *phone = [KTVCommon userInfo].phone;
    if (!self.isMySelf) {
        phone = self.user.phone;
    }
    [KTVLoginService getUserInfo:phone result:^(NSDictionary *result) {
        if (![result[@"code"] isEqualToString:ktvCode]) {
            [KTVToast toast:TOAST_USERINFO_FAIL];
        } else {
            NSDictionary *userInfo = result[@"data"];
            KTVUser *user = [KTVUser yy_modelWithDictionary:userInfo];
            self.user = user;
            
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 235;
    } else if (indexPath.section == 1) {
        return 280.0f;
    } else if (indexPath.section == 2) {
        return 90.0f;
    } else if (indexPath.section == 3) {
        return 122.0f;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1 || section == 2 || section == 3) {
        return 29.0f;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:nil title:@"个人相册" remark:nil];
        return headerView;
    } else if (section == 2) {
        KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:nil title:@"我的视频" remark:nil];
        return headerView;
    } else if (section == 3) {
        KTVTableHeaderView *headerView = [[KTVTableHeaderView alloc] initWithImageUrl:nil title:@"关于TA" remark:nil];
        return headerView;
    }
    return nil;
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 1;
    } else if (section == 2) {
        return 1;
    } else if (section == 3) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        KTVUserBannerCell *cell = (KTVUserBannerCell *)[tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVUserBannerCell)];
        cell.user = self.user;
        cell.isSelf = self.isMySelf;
        cell.addFriendCallback = ^(KTVUser *user) {
            NSString *phone = [KTVCommon userInfo].phone;
            if (phone) {
                NSDictionary *params = @{@"sourceUsername" : phone, @"targetUsername" : user.phone};
                [KTVMainService postAddFriend:params result:^(NSDictionary *result) {
                    if ([result[@"code"] isEqualToString:ktvCode]) {
                        [KTVToast toast:TOAST_ADD_FRIEND_SUCC];
                    } else {
                        [KTVToast toast:result[@"detail"]];
                    }
                }];
            }
        };
        return cell;
    } else if (indexPath.section == 1) {
        KTVUserPhontosCell *cell = (KTVUserPhontosCell *)[tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVUserPhontosCell)];
        cell.pictureList = self.user.pictureList;
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
    } else if (indexPath.section == 2) {
        KTVMediaCell *cell = [[KTVMediaCell alloc] initWithMediaList:self.user.videoList style:UITableViewCellStyleDefault reuseIdentifier:@"KTVMediaCell"];
        @WeakObj(self);
        cell.showMediaCallback = ^(id media) {
            if ([media isKindOfClass:[KTVVideo class]]) {
                KTVVideo *video = (KTVVideo *)media;
                [weakself playVideaUrl:video.url];
            }
        };
        return cell;
    } else if (indexPath.section == 3) {
        KTVUserSenseCell *cell = (KTVUserSenseCell *)[tableView dequeueReusableCellWithIdentifier:KTVStringClass(KTVUserSenseCell)];
        cell.user = self.user;
        return cell;
    }
    return nil;
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

@end
