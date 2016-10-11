//
//  NSObject+VendorAFNetworking.h
//  dotaUnity
//
//  Created by admin on 16/4/26.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (VendorAFNetworking)

+ (void)GET:(NSString *)URLString parameters:(id)parameters completionHandler:(void (^)(id responsObject, NSError *error))completionHandler;


+ (void)POST:(NSString *)URLString parameters:(id)parameters completionHandler:(void (^)(id responsObject, NSError *error))completionHandler;

+ (void)GET:(NSString *)URLString requestHead:(NSDictionary *)requestHead parameters:(id)parameters completionHandler:(void (^)(id responsObject, NSError *error))completionHandler;


@end
