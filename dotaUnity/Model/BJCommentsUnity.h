//
//  BJCommentsUnity.h
//  dotaUnity
//
//  Created by admin on 16/4/25.
//  Copyright © 2016年 cc_company. All rights reserved.
//  评论相关类

#import <Foundation/Foundation.h>

@class BJCommentsList,BJComment,BJCommentDetail;

@interface BJCommentsUnity : NSObject

@property (nonatomic, copy)   NSString       *msg;
@property (nonatomic, strong) BJCommentsList *result;
@property (nonatomic, copy)   NSString       *status;

@end


@interface BJCommentsList : NSObject

@property (nonatomic, assign) NSInteger              commentsCount; // count -> commentsCount
@property (nonatomic, copy)   NSString             * newsid;
@property (nonatomic, strong) NSArray<BJComment *> * comments;

@end


@interface BJComment : NSObject

@property (nonatomic, strong) NSArray<BJCommentDetail *> *comment;

@end


@interface BJCommentDetail : NSObject

@property (nonatomic, assign) NSInteger  commentid;
@property (nonatomic, assign) NSInteger  replyid;
@property (nonatomic, assign) NSInteger  up;
@property (nonatomic, copy)   NSString * avartar;
@property (nonatomic, copy)   NSString * userid;
@property (nonatomic, assign) NSInteger  create_at;
@property (nonatomic, assign) NSInteger  idelete; // delete -> idelete
@property (nonatomic, assign) NSInteger  is_offical;
@property (nonatomic, copy)   NSString * issupport;
@property (nonatomic, assign) NSInteger  down;
@property (nonatomic, assign) NSInteger  level;
@property (nonatomic, copy)   NSString * text;
@property (nonatomic, copy)   NSString * username;
@property (nonatomic, assign) NSInteger  is_vip;
@property (nonatomic, assign) BOOL       top;
@property (nonatomic, copy)   NSString * replyusername;

@end

