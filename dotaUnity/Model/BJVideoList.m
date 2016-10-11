//
//  BJVideoList.m
//  dotaUnity
//
//  Created by admin on 16/5/9.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import "BJVideoList.h"

@implementation BJVideoList
YYModelOverrideMethod;

@end

@implementation BJVideoResult
YYModelOverrideMethod;

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"video_list_by_time" : [BJVideoListByTime class]};
}

@end


@implementation BJVideoListByTime
YYModelOverrideMethod;

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"segs" : [BJVideoSegs class]};
}

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"videoListByTimeClass":@"class"};
}

@end


@implementation BJVideoUserInfo
YYModelOverrideMethod;

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"userInfoClass":@"class"};
}

@end


@implementation BJVideoUrlInfo
YYModelOverrideMethod;

@end


@implementation BJVideoSegs
YYModelOverrideMethod;

@end


