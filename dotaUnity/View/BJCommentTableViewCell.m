//
//  BJCommentTableViewCell.m
//  dotaUnity
//
//  Created by admin on 16/4/29.
//  Copyright © 2016年 cc_company. All rights reserved.
//


#import "BJCommentTableViewCell.h"
#import "BJDota2NewsDetailViewController.h"

@interface BJCommentTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (weak, nonatomic) IBOutlet UIButton *upButton;
@property (weak, nonatomic) IBOutlet UILabel *upLabel;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UIButton *showAllButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentLabelHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *showAllButtonHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *showAllButtonBottomConstraint;

@end

@implementation BJCommentTableViewCell


- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadData
{
    [self.avatarImageView sd_setImageWithURL:self.avartarURL placeholderImage:[UIImage imageNamed:@"avatar_none_60x60_"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error != nil) {
            DDLogError(@"load avatar image error[%@]", error.localizedDescription);
        }
    }];
    
    
    self.usernameLabel.text = self.username;
    
    
    NSMutableAttributedString *levelStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Lv.%ld", (long)self.level]];
    NSDictionary *attr = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    [levelStr setAttributes:attr range:NSMakeRange(0, levelStr.length)];
    self.levelLabel.attributedText = levelStr;
    switch (self.level) {
        case 0:
        case 1:
        case 2:
        case 3:
            self.levelLabel.backgroundColor = [UIColor colorWithRed:0.3 green:0.3 blue:9.85 alpha:1];
            break;
        case 4:
        case 5:
        case 6:
            self.levelLabel.backgroundColor = [UIColor colorWithRed:0.5 green:0.85 blue:0.5 alpha:1];
            break;
        case 7:
        case 8:
            self.levelLabel.backgroundColor = [UIColor orangeColor];
            break;
        case 9:
            self.levelLabel.backgroundColor = [UIColor colorWithRed:0.85 green:0.3 blue:0.3 alpha:1];
            break;
            
        default:
            break;
    }
    
    
    if (self.up == 0) {
        self.upLabel.text = @"";
    } else {
        self.upLabel.text = [NSString stringWithFormat:@"%ld", (long)self.up];
    }
    
    
    NSDate *nowDate = [NSDate date];
    NSTimeInterval timeInterval = [nowDate timeIntervalSinceDate:self.create_at];
    if (timeInterval < 3600) {
        self.createTimeLabel.text = [NSString stringWithFormat:@"%ld分钟前", (long)timeInterval/60];
    } else if (timeInterval >= 3600 && timeInterval < 3600*24) {
        self.createTimeLabel.text = [NSString stringWithFormat:@"%ld小时前", (long)timeInterval/3600];
    } else if (timeInterval >= 3600*24) {
        self.createTimeLabel.text = [NSString stringWithFormat:@"%ld天前", (long)timeInterval/3600/24];
    }
    
    self.contentTextLabel.text = self.contentText;
    
    
    // commentLabel
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:@""];
    NSMutableAttributedString *huanhangStr = [[NSMutableAttributedString alloc] initWithString:@"\n \n"];
    [huanhangStr setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:7]} range:NSMakeRange(1, 1)];
    
    if (self.replysArray.count == 0) {
        self.commentLabelHeightConstraint.constant = 0;
    } else if ((self.replysArray.count > 0 && self.replysArray.count <= 2) || (self.replysArray.count > 2 && self.commentIsShow == YES)) {
        for (int i = 0; i < self.replysArray.count; ++i) {
            [attrStr appendAttributedString:[self attrStrOfReplyInfo:self.replysArray[i]]];
            if (i != self.replysArray.count - 1) {
                [attrStr appendAttributedString:huanhangStr];
            } else {
                [attrStr appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
            }
        }
        self.commentLabel.attributedText = attrStr;
        self.commentLabelHeightConstraint.constant = [attrStr heightOfStringForMaxWidth:self.commentLabel.frame.size.width];
    } else if (self.replysArray.count > 2 && self.commentIsShow == NO) {
        BJReplyInfo *replyInfo0 = self.replysArray[0];
        BJReplyInfo *replyInfo1 = self.replysArray[1];
        
        [attrStr appendAttributedString:[self attrStrOfReplyInfo:replyInfo0]];
        [attrStr appendAttributedString:huanhangStr];
        [attrStr appendAttributedString:[self attrStrOfReplyInfo:replyInfo1]];
        [attrStr appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
        
        self.commentLabel.attributedText = attrStr;
        self.commentLabelHeightConstraint.constant = [attrStr heightOfStringForMaxWidth:self.commentLabel.frame.size.width];
    }
    
    
    // 是否显示“查看全部”按钮
    if (self.replysArray.count <= 2 || (self.replysArray.count > 2 && self.commentIsShow == YES)) {
        self.showAllButton.hidden = YES;
        self.showAllButtonHeightConstraint.constant = 0;
        self.showAllButtonBottomConstraint.constant = 0;
    } else if (self.replysArray.count > 2 && self.commentIsShow == NO) {
        self.showAllButton.hidden = NO;
    }
}

- (IBAction)showAllButtonClick:(UIButton *)sender {
    self.showAllButton.hidden = YES;
    self.commentIsShow = YES;
    [self.dndVC addCommentIsShowDic:YES index:self.cellIndex];
    [self.dndVC refreshCommentTableViewAtIndex:self.cellIndex];
}

- (NSMutableAttributedString *)attrStrOfReplyInfo:(BJReplyInfo *)replyInfo
{
    NSDate *nowDate = [NSDate date];
    NSTimeInterval timeInterval = [nowDate timeIntervalSinceDate:replyInfo.create_at];
    NSString *timeStr;
    if (timeInterval < 3600) {
        timeStr = [NSString stringWithFormat:@"%ld分钟前", (long)timeInterval/60];
    } else if (timeInterval >= 3600 && timeInterval < 3600*24) {
        timeStr = [NSString stringWithFormat:@"%ld小时前", (long)timeInterval/3600];
    } else if (timeInterval >= 3600*24) {
        timeStr = [NSString stringWithFormat:@"%ld天前", (long)timeInterval/3600/24];
    }
    
    NSString *replyStr = [NSString stringWithFormat:@"%@: 回复 %@: %@ %@", replyInfo.username, replyInfo.replyUserName, replyInfo.replyContentText, timeStr];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:1];//调整行间距
    NSDictionary *attr = @{
                           NSFontAttributeName:[UIFont systemFontOfSize:11],
                            NSParagraphStyleAttributeName:paragraphStyle
                           };
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:replyStr attributes:attr];
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.5 green:0.8 blue:1 alpha:1] range:NSMakeRange(0, replyInfo.username.length)];
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(replyInfo.username.length+5+replyInfo.replyUserName.length+2+replyInfo.replyContentText.length+1, timeStr.length)];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:7] range:NSMakeRange(replyInfo.username.length+5+replyInfo.replyUserName.length+2+replyInfo.replyContentText.length+1, timeStr.length)];
    
    return attrStr;
}

- (IBAction)zanButtonClick:(UIButton *)sender {
    self.upLabel.text = [NSString stringWithFormat:@"%ld", self.upLabel.text.integerValue + 1];
    [self.upButton setSelected:YES];
    self.upButton.userInteractionEnabled = NO;
}



@end





@implementation BJReplyInfo

@end
