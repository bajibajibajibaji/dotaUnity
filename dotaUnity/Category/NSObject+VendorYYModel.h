//
//  NSObject+VendorYYModel.h
//  dotaUnity
//
//  Created by admin on 16/4/26.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (VendorYYModel)

+ (id)modelFromJson:(id)json;
+ (id)jsonFromModel:(id)model;

@end
