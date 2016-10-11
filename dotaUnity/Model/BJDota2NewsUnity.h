//
//  BJDota2NewsUnity.h
//  dotaUnity
//
//  Created by admin on 16/4/25.
//  Copyright © 2016年 cc_company. All rights reserved.
//  新闻相关类

#import <Foundation/Foundation.h>

@class BJImgs,BJDota2News,BJHotTopics;

/* dota2新闻类列表 */
@interface BJDota2NewsList : NSObject

@property (nonatomic, strong) NSArray<BJDota2News *> * result;
@property (nonatomic, assign) NSInteger                reply_timestamp;
@property (nonatomic, copy)   NSString               * status;
@property (nonatomic, strong) BJImgs                 * imgs;
@property (nonatomic, strong) NSArray<BJHotTopics *> * hot_topics;
@property (nonatomic, copy)   NSString               * msg;

@end


@interface BJImgs : NSObject

@property (nonatomic, copy) NSString *topic_all;
@property (nonatomic, copy) NSString *mjia_all;

@end


/* dota2新闻类 */
@interface BJDota2News : NSObject

@property (nonatomic, assign) NSInteger             click;
@property (nonatomic, assign) NSInteger             content_type;
@property (nonatomic, copy)   NSString            * create_at;
@property (nonatomic, copy)   NSString            * date;
@property (nonatomic, copy)   NSString            * newsDescription;  // description -> newsDescription
@property (nonatomic, assign) BOOL                  favour;
@property (nonatomic, assign) NSInteger             img_type;
@property (nonatomic, strong) NSArray<NSString *> * imgs;
@property (nonatomic, assign) NSInteger             is_large_img;
@property (nonatomic, assign) NSInteger             linkid;
@property (nonatomic, copy)   NSString            * newsid;
@property (nonatomic, copy)   NSString            * newsUrl;      // newUrl -> newsUrl
@property (nonatomic, copy)   NSString            * source;
@property (nonatomic, assign) NSInteger             timestamp;
@property (nonatomic, copy)   NSString            * title;
@property (nonatomic, assign) BOOL                  top;
@property (nonatomic, copy)   NSString            * url;

@end


@interface BJHotTopics : NSObject

@property (nonatomic, assign) NSInteger  topicid;
@property (nonatomic, copy)   NSString * img;
@property (nonatomic, copy)   NSString * newsDescription; // description -> newsDescription
@property (nonatomic, copy)   NSString * name;

@end

