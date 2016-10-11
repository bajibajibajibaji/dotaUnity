//
//  NSString+stringHeight.h
//  dotaUnity
//
//  Created by admin on 16/5/2.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (stringHeight)

- (CGFloat)heightOfStringForMaxWidth:(CGFloat)maxWidth Font:(UIFont *)font;
- (CGFloat)widthOfStringWithFont:(UIFont *)font;

@end
