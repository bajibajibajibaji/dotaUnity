//
//  BJLiveRoomCollectionViewCell.h
//  dotaUnity
//
//  Created by admin on 16/5/4.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BJLiveRoomCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) NSURL *liveImageURL; /** <#注释#> */
@property (nonatomic, strong) NSURL *userImageURL; /** <#注释#> */
@property (nonatomic, copy) NSString *nickName; /** <#注释#> */
@property (nonatomic, assign) NSInteger onlineNum; /** <#注释#> */
@property (nonatomic, copy) NSString *liveTitle; /** <#注释#> */


- (void)loadData;

@end
