//
//  BJGirefTableViewCell.h
//  dotaUnity
//
//  Created by admin on 16/5/13.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BJGirefTableViewCell : UITableViewCell

@property (nonatomic, strong) NSURL *userImageURL; /** <#注释#> */
@property (nonatomic, copy) NSString *userName; /** <#注释#> */
@property (nonatomic, assign) NSInteger videoNum; /** <#注释#> */
@property (nonatomic, strong) NSDate *createTime; /** <#注释#> */

- (void)loadData;

@end
