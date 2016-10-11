//
//  BJGirefList.h
//  dotaUnity
//
//  Created by admin on 16/5/12.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BJGirefResult,BJGirefItems;
@interface BJGirefList : NSObject

@property (nonatomic, copy) NSString *msg;
@property (nonatomic, strong) NSArray<BJGirefResult *> *result;
@property (nonatomic, copy) NSString *status;

@end


@interface BJGirefResult : NSObject

@property (nonatomic, strong) NSArray<BJGirefItems *> *items;
@property (nonatomic, copy) NSString *title;

@end



@interface BJGirefItems : NSObject

@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *game_type;
@property (nonatomic, copy) NSString *recent_time;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, copy) NSString *dm_link;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, assign) NSInteger show_type;

@end

