//
//  BJVideoTableViewCell.h
//  dotaUnity
//
//  Created by admin on 16/5/10.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BJVideoTableViewCell : UITableViewCell

@property (nonatomic, strong) NSURL *videoImageURL;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSURL *userImageURL;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, assign) NSInteger playNum;
@property (nonatomic, strong) NSDate *time;

- (void)loadData;

@end
