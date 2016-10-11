//
//  BJGirefList.m
//  dotaUnity
//
//  Created by admin on 16/5/12.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import "BJGirefList.h"

@implementation BJGirefList
YYModelOverrideMethod;

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"result" : [BJGirefResult class]};
}

@end

@implementation BJGirefResult
YYModelOverrideMethod;

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"items" : [BJGirefItems class]};
}

@end


@implementation BJGirefItems
YYModelOverrideMethod;

@end


