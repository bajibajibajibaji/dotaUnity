//
//  BJLiveRoomViewModel.m
//  dotaUnity
//
//  Created by admin on 16/5/4.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import "BJLiveRoomViewModel.h"
#import "BJLiveRoomList.h"

@implementation BJLiveRoomViewModel

+ (void)getRoomListWithOffset:(NSInteger)offset Limit:(NSInteger)limit CompletionHandler:(void (^)(NSArray<BJLiveRoomViewModel *> *responsObject, NSError *error))completionHandler
{
    [BJNetManager getLiveRoomListWithOffset:offset Limit:limit CompletionHandler:^(id responsObject, NSError *error) {
        if (error == nil) {
            BJLiveRoomList *roomList = [BJLiveRoomList modelFromJson:responsObject];
            NSArray<BJLiveRoom *> *result = roomList.result;
            
            NSMutableArray *liveRoomVMArray = [NSMutableArray array];
            for (BJLiveRoom *liveRoom in result) {
                BJLiveRoomViewModel *lrVM = [[BJLiveRoomViewModel alloc] init];
                lrVM.url_info = [BJUrlInfoViewModel new];
                lrVM.live_img_url = [NSURL URLWithString:liveRoom.live_img];
                lrVM.live_title = liveRoom.live_title;
                lrVM.live_nickname = liveRoom.live_nickname;
                lrVM.live_online = liveRoom.live_online;
                lrVM.live_userimg_url = [NSURL URLWithString:liveRoom.live_userimg];
                lrVM.live_id = liveRoom.live_id;
                
                lrVM.url_info.urlStr = liveRoom.url_info.url == nil ? @"kongURL" : liveRoom.url_info.url;
                lrVM.url_info.referer = liveRoom.url_info.Referer == nil ? @"kongReferer" : liveRoom.url_info.Referer;
                lrVM.url_info.user_agent = liveRoom.url_info.User_Agent == nil ? @"kongUserAgent" : liveRoom.url_info.User_Agent;
                
                [liveRoomVMArray addObject:lrVM];
            }
            
            completionHandler(liveRoomVMArray, nil);
        } else {
            completionHandler(nil, error);
        }
    }];
}

@end



@implementation BJUrlInfoViewModel

@end
