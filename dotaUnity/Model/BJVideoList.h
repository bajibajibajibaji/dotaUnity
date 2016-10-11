//
//  BJVideoList.h
//  dotaUnity
//
//  Created by admin on 16/5/9.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BJVideoResult,BJVideoListByTime,BJVideoUserInfo,BJVideoUrlInfo,BJVideoSegs;
@interface BJVideoList : NSObject

@property (nonatomic, copy) NSString *msg;
@property (nonatomic, strong) BJVideoResult *result;
@property (nonatomic, copy) NSString *status;

@end


@interface BJVideoResult : NSObject

@property (nonatomic, assign) NSInteger item_count;
@property (nonatomic, strong) NSArray<BJVideoListByTime *> *video_list_by_time;
@property (nonatomic, copy) NSString *v_type;

@end


@interface BJVideoListByTime : NSObject

@property (nonatomic, strong) BJVideoUserInfo *user_info;
@property (nonatomic, strong) BJVideoUrlInfo *url_info;
@property (nonatomic, copy) NSString *vtag;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *time_len;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, assign) NSInteger play_times_num;
@property (nonatomic, copy) NSString *create_time_desc;
@property (nonatomic, assign) NSInteger play_times;
@property (nonatomic, strong) NSArray<BJVideoSegs *> *segs;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, assign) NSInteger videoListByTimeClass; // class -> videoListByTimeClass
@property (nonatomic, copy) NSString *thumb_img;
@property (nonatomic, copy) NSString *zone_time;

@end



@interface BJVideoUserInfo : NSObject

@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, assign) NSInteger order;
@property (nonatomic, copy) NSString *dm_link;
@property (nonatomic, assign) NSInteger userInfoClass; // class -> userInfoClass
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *type;

@end



@interface BJVideoUrlInfo : NSObject

@property (nonatomic, copy) NSString *Referer;
@property (nonatomic, copy) NSString *User_Agent;
@property (nonatomic, copy) NSString *url;

@end



@interface BJVideoSegs : NSObject

@property (nonatomic, copy) NSString *seg_type;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *url;

@end

