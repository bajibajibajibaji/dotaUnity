//
//  BJVideoListViewModel.m
//  dotaUnity
//
//  Created by admin on 16/5/9.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import "BJVideoListViewModel.h"
#import "BJVideoList.h"

@implementation BJVideoListViewModel

+ (void)getVideoListWithLimit:(NSInteger)limit Offset:(NSInteger)offSet CompletionHandler:(void (^)(NSArray<BJVideoListViewModel *> *videos, NSError *error))completionHandler
{
    [BJNetManager getDota2VideoListWithLimit:limit Offset:offSet CompletionHandler:^(id responsObject, NSError *error) {
        if (error == nil) {
            BJVideoList *videoList = [BJVideoList modelFromJson:responsObject];
            
            NSMutableArray *videos = [NSMutableArray array];
            for (BJVideoListByTime *vlbt in videoList.result.video_list_by_time) {
                BJVideoListViewModel *vlVM= [BJVideoListViewModel new];
                
                vlVM.videoImageURL = [NSURL URLWithString:vlbt.thumb_img];
                vlVM.videoTitle = vlbt.title;
                vlVM.userName = vlbt.user_info.username;
                vlVM.userImageURL = [NSURL URLWithString:vlbt.user_info.avatar];
                vlVM.playNumber = vlbt.play_times_num;
                vlVM.create_time = [NSDate dateWithTimeIntervalSince1970:[vlbt.create_time intValue]];
                vlVM.videoURL = [NSURL URLWithString:vlbt.segs[0].url];
                
                [videos addObject:vlVM];
                
                completionHandler(videos, nil);
            }
        } else {
            completionHandler(nil, error);
        }
    }];
}

@end
