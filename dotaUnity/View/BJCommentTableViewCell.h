//
//  BJCommentTableViewCell.h
//  dotaUnity
//
//  Created by admin on 16/4/29.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BJReplyInfo, BJDota2NewsDetailViewController;

@interface BJCommentTableViewCell : UITableViewCell

@property (nonatomic, strong) NSURL    * avartarURL;    /** 头像 */
@property (nonatomic, copy)   NSString * username;      /** 用户名 */
@property (nonatomic, assign) NSInteger  level;         /** 等级 */
@property (nonatomic, assign) NSInteger  up;            /** 点赞数量 */
@property (nonatomic, strong) NSDate   * create_at;     /** 评论时间 */
@property (nonatomic, copy)   NSString * contentText;          /** 回复文本 */
@property (nonatomic, strong) NSArray<BJReplyInfo *> *replysArray; /** 回复 */

@property (nonatomic, weak) BJDota2NewsDetailViewController *dndVC; /** <#注释#> */
@property (nonatomic, assign) NSInteger cellIndex; /** cell的序号 */
@property (nonatomic, assign) BOOL commentIsShow; /** 评论是否展开 */

- (void)loadData;

@end



@interface BJReplyInfo : NSObject

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *replyUserName;
@property (nonatomic, copy) NSString *replyContentText;
@property (nonatomic, strong) NSDate *create_at;

@end