//
//  NSString+stringHeight.m
//  dotaUnity
//
//  Created by admin on 16/5/2.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import "NSString+stringHeight.h"

@implementation NSString (stringHeight)

- (CGFloat)heightOfStringForMaxWidth:(CGFloat)maxWidth Font:(UIFont *)font
{
    CGSize maxSize = CGSizeMake(maxWidth, CGFLOAT_MAX);
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByCharWrapping];
    NSDictionary *attributes = @{
                                 NSFontAttributeName : font,
                                 NSParagraphStyleAttributeName : style
                                 };

    CGRect rect = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    return rect.size.height;
}

- (CGFloat)widthOfStringWithFont:(UIFont *)font
{
    CGSize maxSize = CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByCharWrapping];
    NSDictionary *attributes = @{
                                 NSFontAttributeName : font,
                                 NSParagraphStyleAttributeName : style
                                 };
    
    CGRect rect = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    return rect.size.width;
}

@end
