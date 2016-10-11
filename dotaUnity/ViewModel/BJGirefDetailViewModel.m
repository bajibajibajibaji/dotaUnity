//
//  BJGirefDetailViewModel.m
//  dotaUnity
//
//  Created by admin on 16/5/13.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import "BJGirefDetailViewModel.h"
#import "BJGirefDetail.h"

@implementation BJGirefDetailViewModel

+ (void)getGirefDetailWithGirefName:(NSString *)girefName Limit:(NSInteger)limit Offset:(NSInteger)offSet CompletionHandler:(void (^)(NSArray<BJGirefDetailViewModel*> *girefDetails, NSError *error))completionHandler
{
    [BJNetManager getGirefDetailWithGirefName:girefName andLimit:limit Offset:offSet CompletionHandler:^(id responsObject, NSError *error) {
        if (error == nil) {
            BJGirefDetail *girefDetail = [BJGirefDetail modelFromJson:responsObject];
            
            NSMutableArray<BJGirefDetailViewModel *> *gdVMs = [NSMutableArray array];
            
            for (BJGirefDetailVideoListByTime *gdvlbt in girefDetail.result.video_list_by_time) {
                BJGirefDetailViewModel *gdVM = [BJGirefDetailViewModel new];
                gdVM.videoImageURL = [NSURL URLWithString:gdvlbt.thumb_img];
                gdVM.videoTitle = gdvlbt.title;
                gdVM.userName = gdvlbt.user_info.username;
                gdVM.userImageURL = [NSURL URLWithString:gdvlbt.user_info.avatar];
                gdVM.playNumber = gdvlbt.play_times;
                gdVM.create_time = [NSDate dateWithTimeIntervalSince1970:[gdvlbt.create_time intValue]];
                gdVM.videoURL = [NSURL URLWithString:gdvlbt.segs[0].url];
                
                [gdVMs addObject:gdVM];
                
                completionHandler(gdVMs, nil);
            }
        } else {
            completionHandler(nil, error);
        }
    }];
}

@end
