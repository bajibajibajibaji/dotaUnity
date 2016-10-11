//
//  UITabBarController+BJAutorotate.m
//  dotaUnity
//
//  Created by admin on 16/5/11.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import "UITabBarController+BJAutorotate.h"

@implementation UITabBarController (BJAutorotate)

- (BOOL)shouldAutorotate
{
    return [self.selectedViewController shouldAutorotate];
}

- (NSUInteger)supportedInterfaceOrientations
{
    return [self.selectedViewController supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [self.selectedViewController preferredInterfaceOrientationForPresentation];
}

@end
