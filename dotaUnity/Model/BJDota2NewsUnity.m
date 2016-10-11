//
//  BJDota2NewsUnity.m
//  dotaUnity
//
//  Created by admin on 16/4/25.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import "BJDota2NewsUnity.h"

@implementation BJDota2NewsList
YYModelOverrideMethod;

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"result" : [BJDota2News class],
             @"hot_topics" : [BJHotTopics class]};
}

@end

@implementation BJImgs

@end


@implementation BJDota2News
YYModelOverrideMethod;

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"newsDescription":@"description", @"newsUrl":@"newUrl"};
}

@end


@implementation BJHotTopics
YYModelOverrideMethod;

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"newsDescription":@"description"};
}

@end


