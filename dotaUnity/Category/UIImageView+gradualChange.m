//
//  UIImageView+gradualChange.m
//  dotaUnity
//
//  Created by admin on 16/5/5.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import "UIImageView+gradualChange.h"

@implementation UIImageView (gradualChange)

- (void)addBlackGradualChangeFromBottomToTop
{
    UIView *layerView = [[UIView alloc] initWithFrame:self.frame];// 渐变背景view
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = layerView.frame;
    gradientLayer.bounds = layerView.frame;
    gradientLayer.borderWidth = 0;
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    UIColor *bc = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    gradientLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor, (__bridge id)bc.CGColor];
    
    [layerView.layer insertSublayer:gradientLayer atIndex:0];
    [self addSubview:layerView];
}

@end
