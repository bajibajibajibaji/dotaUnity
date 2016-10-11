//
//  UIWebView+VendorMJRefresh.h
//  dotaUnity
//
//  Created by admin on 16/5/5.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (VendorMJRefresh)

- (void)addHeaderRefreshWithHandler:(void(^)())handler;
- (void)beginHeaderRefresh;
- (void)endHeaderReresh;

@end
