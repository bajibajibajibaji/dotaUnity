//
//  BJNewsCommentsListViewModel.h
//  dotaUnity
//
//  Created by admin on 16/4/26.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BJNewsCommentsDetailViewModel,BJNewsCommentsViewModel;




@interface BJNewsCommentsListViewModel : NSObject

@property (nonatomic, assign) NSInteger                           commentsCount; /** 评论总数 */
@property (nonatomic, strong) NSArray<BJNewsCommentsViewModel *> *commentsArray;


+ (void)getCommentsWithNewsID:(NSString *)newsID Limit:(NSInteger)limit CompletionHandler:(void (^)(BJNewsCommentsListViewModel * responsObject, NSError *error))completionHandler;

@end




@interface BJNewsCommentsViewModel : NSObject

@property (nonatomic, strong) NSArray<BJNewsCommentsDetailViewModel *> *commentsDetailArray;

@end




@interface BJNewsCommentsDetailViewModel : NSObject

@property (nonatomic, strong) NSURL    * avartarURL;    /** 头像 */
@property (nonatomic, copy)   NSString * username;      /** 用户名 */
@property (nonatomic, assign) NSInteger  level;         /** 等级 */
@property (nonatomic, assign) NSInteger  up;            /** 点赞数量 */
@property (nonatomic, strong) NSDate   * create_at;     /** 评论时间 */
@property (nonatomic, copy)   NSString * text;          /** 回复文本 */
@property (nonatomic, assign) BOOL       top;           /** 是否是每个评论的第一个用户 */
@property (nonatomic, copy)   NSString * replyUserName; /** 回复用户名 */

@end