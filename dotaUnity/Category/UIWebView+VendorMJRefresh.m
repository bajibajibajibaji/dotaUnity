//
//  UIWebView+VendorMJRefresh.m
//  dotaUnity
//
//  Created by admin on 16/5/5.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import "UIWebView+VendorMJRefresh.h"

@implementation UIWebView (VendorMJRefresh)

- (void)addHeaderRefreshWithHandler:(void(^)())handler
{
    self.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        handler();
    }];
}

- (void)beginHeaderRefresh
{
    // 马上进入刷新状态
    [self.scrollView.mj_header beginRefreshing];
}

- (void)endHeaderReresh
{
    [self.scrollView.mj_header endRefreshing];
}

@end
