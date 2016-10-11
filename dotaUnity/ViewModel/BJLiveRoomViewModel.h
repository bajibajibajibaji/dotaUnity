//
//  BJLiveRoomViewModel.h
//  dotaUnity
//
//  Created by admin on 16/5/4.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BJUrlInfoViewModel;

@interface BJLiveRoomViewModel : NSObject

@property (nonatomic, strong) NSURL *live_img_url;
@property (nonatomic, copy) NSString *live_title;
@property (nonatomic, copy) NSString *live_nickname;
@property (nonatomic, assign) NSInteger live_online;
@property (nonatomic, strong) NSURL *live_userimg_url;
@property (nonatomic, copy) NSString *live_id; /** <#注释#> */
@property (nonatomic, strong) BJUrlInfoViewModel *url_info;

+ (void)getRoomListWithOffset:(NSInteger)offset Limit:(NSInteger)limit CompletionHandler:(void (^)(NSArray<BJLiveRoomViewModel *> *responsObject, NSError *error))completionHandler;

@end

@interface BJUrlInfoViewModel : NSObject

@property (nonatomic, copy) NSString *urlStr; /** <#注释#> */
@property (nonatomic, copy) NSString *referer; /** <#注释#> */
@property (nonatomic, copy) NSString *user_agent; /** <#注释#> */

@end
