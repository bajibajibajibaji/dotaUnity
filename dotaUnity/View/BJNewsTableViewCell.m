//
//  BJNewsTableViewCell.m
//  dotaUnity
//
//  Created by admin on 16/4/27.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import "BJNewsTableViewCell.h"

@interface BJNewsTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *clickNumLabel;

@end

@implementation BJNewsTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.titleLabel.numberOfLines = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}


- (void)loadData
{
    UIImage *tmpImg = [UIImage imageNamed:@"loading"];
    [self.userImageView sd_setImageWithURL:self.imageURL placeholderImage:tmpImg completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error != nil) {
            DDLogError(@"加载图片error[%@]", error.localizedDescription);
        }
    }];
    
    // 设置imageView的背景渐变
    if (self.isSmallCell == NO) {
        [self.userImageView addBlackGradualChangeFromBottomToTop];
    }
   
    
    self.titleLabel.text = self.title;
    self.titleLabel.textColor = self.labelFontColor;
    
    /*
    NSDate *tempDate = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: tempDate];
    NSDate *nowDate = [tempDate  dateByAddingTimeInterval: interval];
     */
    NSDate *nowDate = [NSDate date];
    NSTimeInterval timeInterval = [nowDate timeIntervalSinceDate:self.createDate];
    if (timeInterval < 3600) {
        self.timeLabel.text = [NSString stringWithFormat:@"%ld分钟前", (long)timeInterval/60];
    } else if (timeInterval >= 3600 && timeInterval < 3600*24) {
        self.timeLabel.text = [NSString stringWithFormat:@"%ld小时前", (long)timeInterval/3600];
    } else if (timeInterval >= 3600*24) {
        self.timeLabel.text = [NSString stringWithFormat:@"%ld天前", (long)timeInterval/3600/24];
    }
    self.timeLabel.textColor = self.labelFontColor;
    
    
    self.clickNumLabel.text = [NSString stringWithFormat:@"%ld", (long)self.clickNum];
    self.clickNumLabel.textColor = self.labelFontColor;
}

@end
