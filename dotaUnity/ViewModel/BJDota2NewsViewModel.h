//
//  BJDota2NewsViewModel.h
//  dotaUnity
//
//  Created by admin on 16/4/26.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BJDota2NewsViewModel : NSObject

@property (nonatomic, copy) NSString *title; /** <#注释#> */
@property (nonatomic, strong) NSDate *createDate; /** <#注释#> */
@property (nonatomic, assign) NSInteger clickNum; /** <#注释#> */
@property (nonatomic, strong) NSURL *imageURL; /** <#注释#> */
@property (nonatomic, assign) NSInteger imageType; /** <#注释#> */
@property (nonatomic, strong) NSURL *newsURL; /** <#注释#> */
@property (nonatomic, copy) NSString *newsID; /** <#注释#> */


+ (void)getDota2NewsListWithOffset:(NSInteger)offset completionHandler:(void (^)(NSArray<BJDota2NewsViewModel *> *dota2NewsList, NSError *error))completionHandler;

@end
