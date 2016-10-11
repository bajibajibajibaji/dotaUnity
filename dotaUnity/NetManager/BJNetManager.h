//
//  BJNetManager.h
//  dotaUnity
//
//  Created by admin on 16/4/26.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BJDota2NewsList;

@interface BJNetManager : NSObject

+ (void)getDota2NewsWithOffset:(NSInteger)offset completionHandler:(void (^)(id responsObject, NSError *error))completionHandler;

+ (void)getNewsCommentsWithNewsID:(NSString *)newsID Limit:(NSInteger)limit CompletionHandler:(void (^)(id responsObject, NSError *error))completionHandler;

+ (void)getLiveRoomListWithOffset:(NSInteger)offset Limit:(NSInteger)limit CompletionHandler:(void (^)(id responsObject, NSError *error))completionHandler;


+ (void)getLiveUrlWithLiveID:(NSString *)liveID UrlStr:(NSString *)urlStr Referer:(NSString *)referer UserAgent:(NSString *)userAgent CompletionHandler:(void (^)(NSArray<NSURL *> *URLs, NSError *error))completionHandler;

+ (void)getDota2VideoListWithLimit:(NSInteger)limit Offset:(NSInteger)offSet CompletionHandler:(void (^)(id responsObject, NSError *error))completionHandler;

+ (void)getGirefListWithCompletionHandler:(void (^)(id responsObject, NSError *error))completionHandler;

+ (void)getGirefDetailWithGirefName:(NSString *)girefName andLimit:(NSInteger)limit Offset:(NSInteger)offSet CompletionHandler:(void (^)(id responsObject, NSError *error))completionHandler;
@end