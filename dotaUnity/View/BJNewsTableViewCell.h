//
//  BJNewsTableViewCell.h
//  dotaUnity
//
//  Created by admin on 16/4/27.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BJNewsTableViewCell : UITableViewCell

@property (nonatomic, assign) BOOL isSmallCell; /** <#注释#> */
@property (nonatomic, strong) NSURL *imageURL; /** <#注释#> */
@property (nonatomic, copy)   NSString *title; /** <#注释#> */
@property (nonatomic, strong) UIColor *labelFontColor; /** <#注释#> */
@property (nonatomic, strong) NSDate *createDate; /** <#注释#> */
@property (nonatomic, assign) NSInteger clickNum; /** <#注释#> */

- (void)loadData;

@end
