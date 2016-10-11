//
//  UICollectionView+VendorMJRefresh.m
//  dotaUnity
//
//  Created by admin on 16/5/5.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import "UICollectionView+VendorMJRefresh.h"

@implementation UICollectionView (VendorMJRefresh)

- (void)addHeaderRefreshWithHandler:(void(^)())handler
{
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        handler();
    }];
}

- (void)beginHeaderRefresh
{
    // 马上进入刷新状态
    [self.mj_header beginRefreshing];
}

- (void)endHeaderReresh
{
    [self.mj_header endRefreshing];
}

- (void)addFooterRefreshWithHandler:(void(^)())handler
{
    self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        handler();
    }];
}

- (void)beginFooterRefresh
{
    [self.mj_footer beginRefreshing];
}

- (void)endFooterRefresh
{
    [self.mj_footer endRefreshing];
}

@end
