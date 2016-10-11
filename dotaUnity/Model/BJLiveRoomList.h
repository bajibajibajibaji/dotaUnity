//
//  BJLiveRoomList.h
//  dotaUnity
//
//  Created by admin on 16/5/4.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BJLiveRoom,BJLiveRoomUrlInfo;
@interface BJLiveRoomList : NSObject

@property (nonatomic, copy) NSString *msg;
@property (nonatomic, strong) NSArray<BJLiveRoom *> *result;
@property (nonatomic, copy) NSString *status;

@end


@interface BJLiveRoom : NSObject

@property (nonatomic, copy) NSString *live_id;
@property (nonatomic, assign) NSInteger enable;
@property (nonatomic, copy) NSString *live_nickname;
@property (nonatomic, strong) BJLiveRoomUrlInfo *url_info;
@property (nonatomic, copy) NSString *live_title;
@property (nonatomic, copy) NSString *live_img;
@property (nonatomic, copy) NSString *game_type;
@property (nonatomic, copy) NSString *live_name;
@property (nonatomic, copy) NSString *live_type;
@property (nonatomic, assign) NSInteger live_online;
@property (nonatomic, copy) NSString *live_userimg;
@property (nonatomic, copy) NSString *show_type;
@property (nonatomic, assign) NSInteger sort_num;

@end


@interface BJLiveRoomUrlInfo : NSObject

@property (nonatomic, copy) NSString *Referer;
@property (nonatomic, copy) NSString *User_Agent;
@property (nonatomic, copy) NSString *url;

@end

