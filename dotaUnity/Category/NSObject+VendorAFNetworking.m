//
//  NSObject+VendorAFNetworking.m
//  dotaUnity
//
//  Created by admin on 16/4/26.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import "NSObject+VendorAFNetworking.h"

@implementation NSObject (VendorAFNetworking)

+ (void)GET:(NSString *)URLString parameters:(id)parameters completionHandler:(void (^)(id responsObject, NSError *error))completionHandler
{
    AFHTTPSessionManager *sm = [AFHTTPSessionManager manager];
    sm.requestSerializer = [AFHTTPRequestSerializer serializer];
    sm.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    sm.requestSerializer.timeoutInterval = 30;
    sm.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", @"text/json", @"text/javascript", @"application/json", nil];
    [sm GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completionHandler(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionHandler(nil, error);
    }];
}

+ (void)POST:(NSString *)URLString parameters:(id)parameters completionHandler:(void (^)(id responsObject, NSError *error))completionHandler
{
    AFHTTPSessionManager *sm = [AFHTTPSessionManager manager];
    sm.requestSerializer = [AFHTTPRequestSerializer serializer];
    sm.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    sm.requestSerializer.timeoutInterval = 30;
    sm.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", @"text/json", @"text/javascript", @"application/json", nil];
    [sm POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completionHandler(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionHandler(nil, error);
    }];
}



+ (void)GET:(NSString *)URLString requestHead:(NSDictionary *)requestHead parameters:(id)parameters completionHandler:(void (^)(id responsObject, NSError *error))completionHandler
{
    AFHTTPSessionManager *sm = [AFHTTPSessionManager manager];
    sm.requestSerializer = [AFHTTPRequestSerializer serializer];
    sm.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    for (NSString *key in requestHead) {
        [sm.requestSerializer setValue:requestHead[key] forHTTPHeaderField:key];
    }
    
    sm.requestSerializer.timeoutInterval = 30;
    sm.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", @"text/json", @"text/javascript", @"application/json", nil];
    [sm GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completionHandler(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionHandler(nil, error);
    }];
}

@end
