//
//  BJNetManager.m
//  dotaUnity
//
//  Created by admin on 16/4/26.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import "BJNetManager.h"

@implementation BJNetManager

+ (void)getDota2NewsWithOffset:(NSInteger)offset completionHandler:(void (^)(id responsObject, NSError *error))completionHandler
{
    [NSObject GET:NEWSLISTURL((long)offset) parameters:nil completionHandler:^(id responsObject, NSError *error) {
        if (error == nil) {
            completionHandler(responsObject, nil);
        } else {
            completionHandler(nil, error);
        }
    }];
}

+ (void)getNewsCommentsWithNewsID:(NSString *)newsID Limit:(NSInteger)limit CompletionHandler:(void (^)(id responsObject, NSError *error))completionHandler
{
    [NSObject GET:COMMENTSURL((long)limit,newsID) parameters:nil completionHandler:^(id responsObject, NSError *error) {
        if (error == nil) {
            completionHandler(responsObject, nil);
        } else {
            completionHandler(nil, error);
        }
    }];
}

+ (void)getLiveRoomListWithOffset:(NSInteger)offset Limit:(NSInteger)limit CompletionHandler:(void (^)(id responsObject, NSError *error))completionHandler
{
    [NSObject GET:LIVELIST((long)limit, (long)offset) parameters:nil completionHandler:^(id responsObject, NSError *error) {
        if (error == nil) {
            completionHandler(responsObject, nil);
        } else {
            completionHandler(nil, error);
        }
    }];
}

+ (void)getLiveUrlWithLiveID:(NSString *)liveID UrlStr:(NSString *)urlStr Referer:(NSString *)referer UserAgent:(NSString *)userAgent CompletionHandler:(void (^)(NSArray<NSURL *> *URLs, NSError *error))completionHandler
{
    [NSObject GET:urlStr requestHead:@{@"Referer":referer, @"User-Agent":userAgent} parameters:nil completionHandler:^(id responsObject, NSError *error) {
        if (error == nil) {
            NSString *paramStr = [[NSString alloc] initWithData:responsObject encoding:NSUTF8StringEncoding];
           
            NSTimeInterval currTime = [[NSDate date] timeIntervalSince1970];
            long long dTime = [[NSNumber numberWithDouble:currTime] longLongValue];
            NSString *timeStr = [NSString stringWithFormat:@"%lld", dTime];
            
            [NSObject POST:LIVEURL(liveID, timeStr) parameters:@{@"info":paramStr} completionHandler:^(id responsObject, NSError *error) {
                if (error == nil) {
                    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:responsObject options:NSJSONReadingMutableContainers error:nil];
                    NSArray *urls = [jsonDic valueForKeyPath:@"result.stream_list.url"];
                    if (urls == nil) {
                        completionHandler(@[@"kongURL0", @"kongURL1"], nil);
                    } else {
                        completionHandler(urls, nil);
                    }
                } else {
                    completionHandler(nil, error);
                }
            }];
        } else {
            completionHandler(nil, error);
        }
    }];
}


+ (void)getDota2VideoListWithLimit:(NSInteger)limit Offset:(NSInteger)offSet CompletionHandler:(void (^)(id responsObject, NSError *error))completionHandler
{
    NSTimeInterval currTime = [[NSDate date] timeIntervalSince1970];
    long long dTime = [[NSNumber numberWithDouble:currTime] longLongValue];
    NSString *timeStr = [NSString stringWithFormat:@"%lld", dTime];
    
    [NSObject GET:VIDEOLIST(timeStr, (long)limit, (long)offSet) parameters:nil completionHandler:^(id responsObject, NSError *error) {
        if (error == nil) {
            completionHandler(responsObject, nil);
        } else {
            completionHandler(nil, error);
        }
    }];
}

+ (void)getGirefListWithCompletionHandler:(void (^)(id responsObject, NSError *error))completionHandler
{
    NSTimeInterval currTime = [[NSDate date] timeIntervalSince1970];
    long long dTime = [[NSNumber numberWithDouble:currTime] longLongValue];
    NSString *timeStr = [NSString stringWithFormat:@"%lld", dTime];
    
    [NSObject GET:GIREFLIST(timeStr) parameters:nil completionHandler:^(id responsObject, NSError *error) {
        if (error == nil) {
            completionHandler(responsObject, nil);
        } else {
            completionHandler(nil, error);
        }
    }];
}

+ (void)getGirefDetailWithGirefName:(NSString *)girefName andLimit:(NSInteger)limit Offset:(NSInteger)offSet CompletionHandler:(void (^)(id responsObject, NSError *error))completionHandler
{
    NSTimeInterval currTime = [[NSDate date] timeIntervalSince1970];
    long long dTime = [[NSNumber numberWithDouble:currTime] longLongValue];
    NSString *timeStr = [NSString stringWithFormat:@"%lld", dTime];
    
    [NSObject GET:GIREFDETAILLIST(timeStr, girefName, limit, offSet) parameters:nil completionHandler:^(id responsObject, NSError *error) {
        if (error == nil) {
            completionHandler(responsObject, nil);
        } else {
            completionHandler(nil, error);
        }
    }];
}

@end
