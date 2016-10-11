//
//  BJVideoHistoryViewModel.m
//  dotaUnity
//
//  Created by admin on 16/5/14.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import "BJVideoHistoryViewModel.h"
#import "AppDelegate.h"
#import "VideoHistory.h"

@implementation BJVideoHistoryViewModel

// insert
+ (void)insertIntoVideoHistoryWithVideoImageURLStr:(NSString *)videoImageURLStr Title:(NSString *)title VideoURLStr:(NSString *)videoURLStr
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    VideoHistory *vh = [NSEntityDescription insertNewObjectForEntityForName:@"VideoHistory" inManagedObjectContext:context];
    vh.videoCreateTime = [NSDate date];
    vh.videoImageURLStr = videoImageURLStr;
    vh.videoTitle = title;
    vh.videoURLStr = videoURLStr;
    
    [appDelegate saveContext];
}

// delete
+ (void)deleteFromVideoHistoryWithVideoURLStr:(NSString *)videoURLStr
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"VideoHistory"];
    NSPredicate *deletePredicate = [NSPredicate predicateWithFormat:@"videoURLStr=%@", videoURLStr];
    [request setPredicate:deletePredicate];
    
    NSArray *resultObjs = [context executeFetchRequest:request error:nil];
    if (resultObjs.count != 0) {
        for (VideoHistory *vh in resultObjs) {
            [context deleteObject:vh];
        }
        [appDelegate saveContext];
    } else {
        DDLogError(@"delete no data");
    }
    
}

// update (只更新日期)
+ (void)updateVideoHistoryForVideoURLStr:(NSString *)videoURLStr
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"VideoHistory"];
    NSPredicate *deletePredicate = [NSPredicate predicateWithFormat:@"videoURLStr=%@", videoURLStr];
    [request setPredicate:deletePredicate];
    
    NSArray *resultObjs = [context executeFetchRequest:request error:nil];
    if (resultObjs.count != 0) {
        for (VideoHistory *vh in resultObjs) {
            vh.videoCreateTime = [NSDate date];
        }
        [appDelegate saveContext];
    } else {
        DDLogError(@"update no data");
    }
}

//select
+ (void)selectVideoHistoryWithLimit:(NSInteger)limit Offset:(NSInteger)offset CompletionHandler:(void (^)(NSArray<BJVideoHistoryViewModel *> *videoHistorys, NSError *error))completionHandler
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"VideoHistory"];
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"videoCreateTime" ascending:NO];
    [request setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    [request setFetchLimit:limit];
    [request setFetchOffset:offset];
    
    NSError *error = nil;
    NSArray *resultObjs = [context executeFetchRequest:request error:&error];
    if (resultObjs != nil) {
        NSMutableArray<BJVideoHistoryViewModel *> *videoHisArray = [NSMutableArray array];
        for (VideoHistory *vh in resultObjs) {
            BJVideoHistoryViewModel *vhVM = [BJVideoHistoryViewModel new];
            vhVM.videoImageURLStr = vh.videoImageURLStr;
            vhVM.videoTitle = vh.videoTitle;
            vhVM.videoCreateTime = vh.videoCreateTime;
            vhVM.videoURLStr = vh.videoURLStr;
            
            [videoHisArray addObject:vhVM];
        }
        completionHandler(videoHisArray, nil);
    } else {
        completionHandler(nil, error);
    }
}

//select WithVideoURL
+ (void)selectVideoHistoryWithVideoURLStr:(NSString *)videoURLStr CompletionHandler:(void (^)(NSArray<BJVideoHistoryViewModel *> *videoHistorys, NSError *error))completionHandler
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"VideoHistory"];
    
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"videoURLStr=%@", videoURLStr];
    [request setPredicate:pre];
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"videoCreateTime" ascending:NO];
    [request setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    NSError *error = nil;
    NSArray *resultObjs = [context executeFetchRequest:request error:&error];
    if (resultObjs != nil) {
        NSMutableArray<BJVideoHistoryViewModel *> *videoHisArray = [NSMutableArray array];
        for (VideoHistory *vh in resultObjs) {
            BJVideoHistoryViewModel *vhVM = [BJVideoHistoryViewModel new];
            vhVM.videoImageURLStr = vh.videoImageURLStr;
            vhVM.videoTitle = vh.videoTitle;
            vhVM.videoCreateTime = vh.videoCreateTime;
            vhVM.videoURLStr = vh.videoURLStr;
            
            [videoHisArray addObject:vhVM];
        }
        completionHandler(videoHisArray, nil);
    } else {
        completionHandler(nil, error);
    }
}

@end
