//
//  BJVideoTableViewCell.m
//  dotaUnity
//
//  Created by admin on 16/5/10.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import "BJVideoTableViewCell.h"

@interface BJVideoTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *playNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@end

@implementation BJVideoTableViewCell


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadData
{
    [self.videoImageView sd_setImageWithURL:self.videoImageURL placeholderImage:[UIImage imageNamed:@"loading"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error != nil) {
            DDLogError(@"load video image error[%@]", error.localizedDescription);
        }
    }];
    [self.videoImageView addBlackGradualChangeFromBottomToTop];
    
    self.titleLabel.text = self.title;
    
    [self.userImageView sd_setImageWithURL:self.userImageURL placeholderImage:[UIImage imageNamed:@"avatar_none_60x60_"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error != nil) {
            DDLogError(@"load video user image error[%@]", error.localizedDescription);
        }
    }];
    
    self.userNameLabel.text = self.userName;
    
    self.playNumLabel.text = [NSString stringWithFormat:@"%ld次播放", (long)self.playNum];
    
    NSDate *nowDate = [NSDate date];
    NSTimeInterval timeInterval = [nowDate timeIntervalSinceDate:self.time];
    if (timeInterval < 3600) {
        self.timeLabel.text = [NSString stringWithFormat:@"%ld分钟前", (long)timeInterval/60];
    } else if (timeInterval >= 3600 && timeInterval < 3600*24) {
        self.timeLabel.text = [NSString stringWithFormat:@"%ld小时前", (long)timeInterval/3600];
    } else if (timeInterval >= 3600*24) {
        self.timeLabel.text = [NSString stringWithFormat:@"%ld天前", (long)timeInterval/3600/24];
    }
}

@end
