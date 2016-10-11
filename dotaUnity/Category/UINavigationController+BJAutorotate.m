//
//  UINavigationController+BJAutorotate.m
//  dotaUnity
//
//  Created by admin on 16/5/11.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import "UINavigationController+BJAutorotate.h"

@implementation UINavigationController (BJAutorotate)

- (BOOL)shouldAutorotate
{
    return [self.topViewController shouldAutorotate];
}

- (NSUInteger)supportedInterfaceOrientations
{
    return [self.topViewController supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [self.topViewController preferredInterfaceOrientationForPresentation];
}

@end
