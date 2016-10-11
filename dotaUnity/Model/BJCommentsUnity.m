//
//  BJCommentsUnity.m
//  dotaUnity
//
//  Created by admin on 16/4/25.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import "BJCommentsUnity.h"

@implementation BJCommentsUnity
YYModelOverrideMethod;

@end

@implementation BJCommentsList
YYModelOverrideMethod;

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"comments" : [BJComment class]};
}

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"commentsCount":@"count"};
}

@end


@implementation BJComment
YYModelOverrideMethod;

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"comment" : [BJCommentDetail class]};
}

@end


@implementation BJCommentDetail
YYModelOverrideMethod;

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"idelete":@"delete"};
}

@end


