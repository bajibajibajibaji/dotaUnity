//
//  BJNewsCommentsListViewModel.m
//  dotaUnity
//
//  Created by admin on 16/4/26.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import "BJNewsCommentsListViewModel.h"

@implementation BJNewsCommentsListViewModel

+ (void)getCommentsWithNewsID:(NSString *)newsID Limit:(NSInteger)limit CompletionHandler:(void (^)(BJNewsCommentsListViewModel * responsObject, NSError *error))completionHandler
{
    [BJNetManager getNewsCommentsWithNewsID:newsID Limit:limit CompletionHandler:^(id responsObject, NSError *error) {
        if (error == nil) {
            BJCommentsUnity *commentUnity = [BJCommentsUnity modelFromJson:responsObject];
        
            BJNewsCommentsListViewModel *newsCommentsListVM = [[BJNewsCommentsListViewModel alloc] init];
            newsCommentsListVM.commentsCount = commentUnity.result.commentsCount;
            
            NSMutableArray<BJNewsCommentsViewModel *> *commentsArr = [[NSMutableArray alloc] init];
            
            for (BJComment *comment in commentUnity.result.comments) {
                NSMutableArray<BJNewsCommentsDetailViewModel *> *commentsDetailArr = [[NSMutableArray alloc] init];
                for (BJCommentDetail *commentDetail in comment.comment) {
                    BJNewsCommentsDetailViewModel *ncdVM = [[BJNewsCommentsDetailViewModel alloc] init];
                    ncdVM.avartarURL = [NSURL URLWithString:commentDetail.avartar];
                    ncdVM.username = commentDetail.username;
                    ncdVM.level = commentDetail.level;
                    ncdVM.up = commentDetail.up;
                    ncdVM.create_at = [NSDate dateWithTimeIntervalSince1970:commentDetail.create_at];
                    ncdVM.text = commentDetail.text;
                    ncdVM.top = commentDetail.top;
                    ncdVM.replyUserName = commentDetail.replyusername;
                    
                    [commentsDetailArr addObject:ncdVM];
                }
                
                BJNewsCommentsViewModel *ncVM = [[BJNewsCommentsViewModel alloc] init];
                ncVM.commentsDetailArray = commentsDetailArr;
                
                [commentsArr addObject:ncVM];
            }
            
            newsCommentsListVM.commentsArray = commentsArr;
            
            completionHandler(newsCommentsListVM, nil);
        } else {
            completionHandler(nil, error);
        }
    }];
}

@end

@implementation BJNewsCommentsViewModel

@end


@implementation BJNewsCommentsDetailViewModel

@end