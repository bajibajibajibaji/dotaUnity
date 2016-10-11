//
//  BJVideoHistoryTableViewCell.h
//  dotaUnity
//
//  Created by admin on 16/5/14.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BJVideoHistoryTableViewCell : UITableViewCell

@property (nonatomic, strong) NSURL *videoImageURL;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSDate *createTime;

- (void)loadData;

@end
