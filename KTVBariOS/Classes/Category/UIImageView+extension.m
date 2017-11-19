//
//  UIImageView+extension.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/11/19.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "UIImageView+extension.h"
#import <AVKit/AVKit.h>

@implementation UIImageView (extension)

- (void)thumbnailFromVideoUrl:(NSString *)videoUrl {
    dispatch_queue_t concu=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(concu, ^{
        NSURL *url = [NSURL URLWithString:videoUrl];
        AVAsset *asset = [AVAsset assetWithURL:url];
        AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
        CMTime time = [asset duration];
        time.value = 0;
        CGImageRef imageRef = [imageGenerator copyCGImageAtTime:time actualTime:NULL error:NULL];
        UIImage *thumbnail = [UIImage imageWithCGImage:imageRef];
        CGImageRelease(imageRef);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image = thumbnail;
        });
    });
    
//    NSURL *url = [NSURL URLWithString:videoUrl];
//    AVAsset *asset = [AVAsset assetWithURL:url];
//    AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
//    CMTime time = [asset duration];
//    time.value = 0;
//    CGImageRef imageRef = [imageGenerator copyCGImageAtTime:time actualTime:NULL error:NULL];
//    UIImage *thumbnail = [UIImage imageWithCGImage:imageRef];
//    CGImageRelease(imageRef);
//    self.image = thumbnail;
}

@end
