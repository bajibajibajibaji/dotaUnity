//
//  BJLiveRoomList.m
//  dotaUnity
//
//  Created by admin on 16/5/4.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import "BJLiveRoomList.h"

@implementation BJLiveRoomList
YYModelOverrideMethod;

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"result" : [BJLiveRoom class]};
}

@end


@implementation BJLiveRoom
YYModelOverrideMethod;

@end


@implementation BJLiveRoomUrlInfo
YYModelOverrideMethod;

@end


