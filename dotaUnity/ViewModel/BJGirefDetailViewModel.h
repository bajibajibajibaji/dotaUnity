//
//  BJGirefDetailViewModel.h
//  dotaUnity
//
//  Created by admin on 16/5/13.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BJGirefDetailViewModel : NSObject

@property (nonatomic, strong) NSURL *videoImageURL; /** <#注释#> */
@property (nonatomic, copy) NSString *videoTitle; /** <#注释#> */
@property (nonatomic, copy) NSString *userName; /** <#注释#> */
@property (nonatomic, strong) NSURL *userImageURL; /** <#注释#> */
@property (nonatomic, assign) NSInteger playNumber; /** <#注释#> */
@property (nonatomic, strong) NSDate *create_time; /** <#注释#> */
@property (nonatomic, strong) NSURL *videoURL; /** <#注释#> */

+ (void)getGirefDetailWithGirefName:(NSString *)girefName Limit:(NSInteger)limit Offset:(NSInteger)offSet CompletionHandler:(void (^)(NSArray<BJGirefDetailViewModel*> *girefDetails, NSError *error))completionHandler;

@end
