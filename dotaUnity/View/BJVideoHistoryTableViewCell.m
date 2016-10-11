//
//  BJVideoHistoryTableViewCell.m
//  dotaUnity
//
//  Created by admin on 16/5/14.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import "BJVideoHistoryTableViewCell.h"

@interface BJVideoHistoryTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation BJVideoHistoryTableViewCell

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
            DDLogError(@"load videoimage error[%@]", error.localizedDescription);
        }
    }];
    
    self.titleLabel.text = self.title;
    
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
