//
//  BJGirefDetail.h
//  dotaUnity
//
//  Created by admin on 16/5/13.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BJGirefDetailResult,BJGirefDetailUserInfo,BJGirefDetailVideoListByTime,BJGirefDeetailUserInfo,BJGirefDetailUrlInfo,BJGirefSegs;
@interface BJGirefDetail : NSObject

@property (nonatomic, copy) NSString *msg;
@property (nonatomic, strong) BJGirefDetailResult *result;
@property (nonatomic, copy) NSString *status;

@end


@interface BJGirefDetailResult : NSObject

@property (nonatomic, strong) BJGirefDetailUserInfo *user_info;
@property (nonatomic, copy) NSString *current_username;
@property (nonatomic, copy) NSString *dm_uid;
@property (nonatomic, strong) NSArray<BJGirefDetailVideoListByTime *> *video_list_by_time;
@property (nonatomic, assign) NSInteger item_count;
@property (nonatomic, copy) NSString *v_type;

@end



@interface BJGirefDetailUserInfo : NSObject

@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, assign) NSInteger order;
@property (nonatomic, copy) NSString *dm_link;
@property (nonatomic, assign) NSInteger userClass; // class -> userClass
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *type;

@end



@interface BJGirefDetailVideoListByTime : NSObject

@property (nonatomic, strong) BJGirefDeetailUserInfo *user_info;
@property (nonatomic, strong) BJGirefDetailUrlInfo *url_info;
@property (nonatomic, copy) NSString *vtag;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *time_len;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, assign) NSInteger play_times_num;
@property (nonatomic, copy) NSString *create_time_desc;
@property (nonatomic, assign) NSInteger play_times;
@property (nonatomic, strong) NSArray<BJGirefSegs *> *segs;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, assign) NSInteger videoClass; // class -> videoClass
@property (nonatomic, copy) NSString *thumb_img;
@property (nonatomic, copy) NSString *zone_time;

@end



@interface BJGirefDeetailUserInfo : NSObject

@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, assign) NSInteger order;
@property (nonatomic, copy) NSString *dm_link;
@property (nonatomic, assign) NSInteger userClass; // class -> userClass
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *type;

@end



@interface BJGirefDetailUrlInfo : NSObject

@property (nonatomic, copy) NSString *Referer;
@property (nonatomic, copy) NSString *User_Agent;
@property (nonatomic, copy) NSString *url;

@end




@interface BJGirefSegs : NSObject

@property (nonatomic, copy) NSString *seg_type;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *url;

@end

