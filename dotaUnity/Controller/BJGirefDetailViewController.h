//
//  BJGirefDetailViewController.h
//  dotaUnity
//
//  Created by admin on 16/5/13.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BJGirefListViewController;

@interface BJGirefDetailViewController : UIViewController

@property (nonatomic, copy) NSString *girefName; /** <#注释#> */

@property (nonatomic, weak) BJGirefListViewController *glVC; /** <#注释#> */

@property (nonatomic, copy) NSString *navigationItemTitle;

@end
