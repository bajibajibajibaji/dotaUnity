//
//  BJGirefListViewModel.h
//  dotaUnity
//
//  Created by admin on 16/5/13.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BJGirefListViewModel : NSObject

@property (nonatomic, strong) NSURL *userImageURL; /** <#注释#> */
@property (nonatomic, copy) NSString *userName; /** <#注释#> */
@property (nonatomic, assign) NSInteger videoNum; /** <#注释#> */
@property (nonatomic, strong) NSDate *createTime; /** <#注释#> */
@property (nonatomic, copy) NSString *girefName; /** <#注释#> */

+ (void)getGirefListWithCompletionHandler:(void (^)(NSArray<BJGirefListViewModel *> *girefs, NSError *error))completionHandler;

@end
