//
//  BJDota2NewsDetailViewController.h
//  dotaUnity
//
//  Created by admin on 16/4/29.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BJDota2NewsViewController;

@interface BJDota2NewsDetailViewController : UIViewController

@property (nonatomic, weak) BJDota2NewsViewController *dnVC; /** 传值用 */
@property (nonatomic, copy) NSString *newsID; /** <#注释#> */

- (void)loadNews; //载入新闻
- (void)addCommentIsShowDic:(BOOL)commentIsShow index:(NSInteger)index;
- (void)refreshCommentTableViewAtIndex:(NSInteger)index;

@end
