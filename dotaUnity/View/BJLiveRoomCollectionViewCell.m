//
//  BJLiveRoomCollectionViewCell.m
//  dotaUnity
//
//  Created by admin on 16/5/4.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import "BJLiveRoomCollectionViewCell.h"

@interface BJLiveRoomCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *liveImageView;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *onlineNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation BJLiveRoomCollectionViewCell


- (void)loadData
{
    [self.liveImageView sd_setImageWithURL:self.liveImageURL placeholderImage:[UIImage imageNamed:@"loading"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error != nil) {
            DDLogError(@"load live image error[%@]", error.localizedDescription);
        }
    }];
    
    // 设置image的背景渐变
    [self.liveImageView addBlackGradualChangeFromBottomToTop];
    
    
    [self.userImageView sd_setImageWithURL:self.userImageURL placeholderImage:[UIImage imageNamed:@"loading"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error != nil) {
            DDLogError(@"load live userImage error[%@]", error.localizedDescription);
        }
    }];
    
    self.nickNameLabel.text = self.nickName;
    
    self.onlineNumLabel.text = [NSString stringWithFormat:@"%ld 名观众", (long)self.onlineNum];
    
    self.titleLabel.text = self.liveTitle;
}

@end
