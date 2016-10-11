//
//  BJVideoHistoryViewModel.h
//  dotaUnity
//
//  Created by admin on 16/5/14.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BJVideoHistoryViewModel : NSObject

@property (nonatomic, copy) NSString *videoImageURLStr;
@property (nonatomic, copy) NSString *videoTitle;
@property (nonatomic, strong) NSDate *videoCreateTime;
@property (nonatomic, copy) NSString *videoURLStr;

+ (void)insertIntoVideoHistoryWithVideoImageURLStr:(NSString *)videoImageURLStr Title:(NSString *)title VideoURLStr:(NSString *)videoURLStr;
+ (void)deleteFromVideoHistoryWithVideoURLStr:(NSString *)videoURLStr;
+ (void)updateVideoHistoryForVideoURLStr:(NSString *)videoURLStr;
+ (void)selectVideoHistoryWithLimit:(NSInteger)limit Offset:(NSInteger)offset CompletionHandler:(void (^)(NSArray<BJVideoHistoryViewModel *> *videoHistorys, NSError *error))completionHandler;
+ (void)selectVideoHistoryWithVideoURLStr:(NSString *)videoURLStr CompletionHandler:(void (^)(NSArray<BJVideoHistoryViewModel *> *videoHistorys, NSError *error))completionHandler;

@end
