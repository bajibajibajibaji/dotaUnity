//
//  BJGirefTableViewCell.m
//  dotaUnity
//
//  Created by admin on 16/5/13.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import "BJGirefTableViewCell.h"

@interface BJGirefTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation BJGirefTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadData
{
    [self.userImageView sd_setImageWithURL:self.userImageURL placeholderImage:[UIImage imageNamed:@"loading"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error != nil) {
            DDLogError(@"load giref image error[%@]", error.localizedDescription);
        }
    }];
    
    self.userNameLabel.text = self.userName;
    
    self.videoNumLabel.text = [NSString stringWithFormat:@"%ld个视频", self.videoNum];
    
    NSDate *nowDate = [NSDate date];
    NSTimeInterval timeInterval = [nowDate timeIntervalSinceDate:self.createTime];
    if (timeInterval < 3600) {
        self.timeLabel.text = [NSString stringWithFormat:@"%ld分钟前", (long)timeInterval/60];
    } else if (timeInterval >= 3600 && timeInterval < 3600*24) {
        self.timeLabel.text = [NSString stringWithFormat:@"%ld小时前", (long)timeInterval/3600];
    } else if (timeInterval >= 3600*24) {
        self.timeLabel.text = [NSString stringWithFormat:@"%ld天前", (long)timeInterval/3600/24];
    }
}

@end
