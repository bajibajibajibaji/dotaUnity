//
//  BJGirefListViewModel.m
//  dotaUnity
//
//  Created by admin on 16/5/13.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import "BJGirefListViewModel.h"
#import "BJGirefList.h"

@implementation BJGirefListViewModel

+ (void)getGirefListWithCompletionHandler:(void (^)(NSArray<BJGirefListViewModel *> *girefs, NSError *error))completionHandler
{
    [BJNetManager getGirefListWithCompletionHandler:^(id responsObject, NSError *error) {
        if (error == nil) {
            BJGirefList *girefList = [BJGirefList modelFromJson:responsObject];
            
            NSMutableArray<BJGirefListViewModel*> *girefsArray = [NSMutableArray array];
            
            for (BJGirefItems *gi in girefList.result[1].items) {
                BJGirefListViewModel *glVM = [[BJGirefListViewModel alloc] init];
                glVM.userImageURL = [NSURL URLWithString:gi.avatar];
                glVM.userName = gi.username;
                glVM.videoNum = gi.count;
                glVM.createTime = [NSDate dateWithTimeIntervalSince1970:[gi.recent_time intValue]];
                glVM.girefName = gi.dm_link;
                
                [girefsArray addObject:glVM];
            }
            
            completionHandler(girefsArray, nil);
        } else {
            completionHandler(nil, error);
        }
    }];
}

@end
