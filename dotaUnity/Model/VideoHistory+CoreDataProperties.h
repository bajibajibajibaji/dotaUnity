//
//  VideoHistory+CoreDataProperties.h
//  dotaUnity
//
//  Created by admin on 16/5/14.
//  Copyright © 2016年 cc_company. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "VideoHistory.h"

NS_ASSUME_NONNULL_BEGIN

@interface VideoHistory (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *videoImageURLStr;
@property (nullable, nonatomic, retain) NSString *videoTitle;
@property (nullable, nonatomic, retain) NSDate   *videoCreateTime;
@property (nullable, nonatomic, retain) NSString *videoURLStr;

@end

NS_ASSUME_NONNULL_END
