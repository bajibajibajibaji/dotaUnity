//
//  BJGirefDetail.m
//  dotaUnity
//
//  Created by admin on 16/5/13.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import "BJGirefDetail.h"

@implementation BJGirefDetail
YYModelOverrideMethod;

@end

@implementation BJGirefDetailResult
YYModelOverrideMethod;

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"video_list_by_time" : [BJGirefDetailVideoListByTime class]};
}

@end


@implementation BJGirefDetailUserInfo
YYModelOverrideMethod;

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"userClass":@"class"};
}

@end


@implementation BJGirefDetailVideoListByTime
YYModelOverrideMethod;

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"segs" : [BJGirefSegs class]};
}

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"videoClass":@"class"};
}

@end


@implementation BJGirefDeetailUserInfo
YYModelOverrideMethod;

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"userClass":@"class"};
}

@end


@implementation BJGirefDetailUrlInfo
YYModelOverrideMethod;

@end


@implementation BJGirefSegs
YYModelOverrideMethod;

@end


