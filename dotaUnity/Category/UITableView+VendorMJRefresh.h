//
//  UITableView+VendorMJRefresh.h
//  dotaUnity
//
//  Created by admin on 16/4/28.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (VendorMJRefresh)

- (void)addHeaderRefreshWithHandler:(void(^)())handler;
- (void)beginHeaderRefresh;
- (void)endHeaderReresh;

- (void)addFooterRefreshWithHandler:(void(^)())handler;
- (void)beginFooterRefresh;
- (void)endFooterRefresh;

@end
