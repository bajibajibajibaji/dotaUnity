//
//  NSAttributedString+stringHeight.m
//  dotaUnity
//
//  Created by admin on 16/5/2.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import "NSAttributedString+stringHeight.h"

@implementation NSAttributedString (stringHeight)

- (CGFloat)heightOfStringForMaxWidth:(CGFloat)maxWidth
{
    CGSize maxSize = CGSizeMake(maxWidth, CGFLOAT_MAX);
    CGRect rect = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin context:nil];
    return rect.size.height;
}

@end
