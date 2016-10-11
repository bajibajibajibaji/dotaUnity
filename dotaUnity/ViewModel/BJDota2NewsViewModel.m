//
//  BJDota2NewsViewModel.m
//  dotaUnity
//
//  Created by admin on 16/4/26.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import "BJDota2NewsViewModel.h"

@implementation BJDota2NewsViewModel

+ (void)getDota2NewsListWithOffset:(NSInteger)offset completionHandler:(void (^)(NSArray<BJDota2NewsViewModel *> *, NSError *))completionHandler
{
    [BJNetManager getDota2NewsWithOffset:offset completionHandler:^(id responsObject, NSError *error) {
        if (error == nil) {
                BJDota2NewsList *dota2NewsList = [BJDota2NewsList modelFromJson:responsObject];
            NSArray<BJDota2News *> *resultArr = dota2NewsList.result;
            NSMutableArray<BJDota2NewsViewModel *> *ma = [NSMutableArray arrayWithCapacity:20];
        
            NSDateFormatter *df = [[NSDateFormatter alloc] init];
            df.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        
            for (BJDota2News *news in resultArr) {
                BJDota2NewsViewModel *newVM = [[BJDota2NewsViewModel alloc] init];
                newVM.title = news.title;
                newVM.createDate = [df dateFromString:news.date];
                newVM.clickNum = news.click;
                newVM.imageURL = [NSURL URLWithString:news.imgs[0]];
                newVM.imageType = news.img_type;
                newVM.newsURL = [NSURL URLWithString:news.newsUrl];
                newVM.newsID = news.newsid;
            
                [ma addObject:newVM];
            }
            
            completionHandler(ma, nil);
        } else {
            completionHandler(nil, error);
        }
    }];
}

@end
