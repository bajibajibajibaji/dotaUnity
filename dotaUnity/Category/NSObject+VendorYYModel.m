//
//  NSObject+VendorYYModel.m
//  dotaUnity
//
//  Created by admin on 16/4/26.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import "NSObject+VendorYYModel.h"

@implementation NSObject (VendorYYModel)

+ (id)modelFromJson:(id)json
{
    if ([json isKindOfClass:[NSArray class]]) {
        return [NSArray yy_modelArrayWithClass:[self class] json:json];
    } else {
        return [[self class] yy_modelWithJSON:json];
    }
    
    return json;
}

+ (id)jsonFromModel:(id)model
{
    return [model yy_modelToJSONObject];
}

@end
