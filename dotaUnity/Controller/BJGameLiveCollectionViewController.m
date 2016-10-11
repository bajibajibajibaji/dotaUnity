//
//  BJGameLiveCollectionViewController.m
//  dotaUnity
//
//  Created by admin on 16/5/4.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import "BJGameLiveCollectionViewController.h"
#import "BJLiveRoomViewModel.h"
#import "BJLiveRoomCollectionViewCell.h"

@interface BJGameLiveCollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *LiveCollectionView;

// 数据源
@property (nonatomic, strong) NSArray<BJLiveRoomViewModel *> *liveRooms;

@end

@implementation BJGameLiveCollectionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.LiveCollectionView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
    
    ws(weakSelf);
    [self.LiveCollectionView addHeaderRefreshWithHandler:^{
        [BJLiveRoomViewModel getRoomListWithOffset:0 Limit:30 CompletionHandler:^(NSArray<BJLiveRoomViewModel *> *responsObject, NSError *error) {
            if (error == nil) {
                weakSelf.liveRooms = responsObject;
                [weakSelf.LiveCollectionView reloadData];
                [weakSelf.LiveCollectionView endHeaderReresh];
            } else {
                DDLogError(@"getRoomList error[%@]", error.localizedDescription);
            }
        }];
    }];
    
    [self.LiveCollectionView addFooterRefreshWithHandler:^{
        [BJLiveRoomViewModel getRoomListWithOffset:self.liveRooms.count Limit:30 CompletionHandler:^(NSArray<BJLiveRoomViewModel *> *responsObject, NSError *error) {
            if (error == nil) {
                weakSelf.liveRooms = [weakSelf.liveRooms arrayByAddingObjectsFromArray:responsObject];
                [weakSelf.LiveCollectionView reloadData];
                [weakSelf.LiveCollectionView endFooterRefresh];
            } else {
                DDLogError(@"getRoomList error[%@]", error.localizedDescription);
            }
        }];
    }];
    
    [self.LiveCollectionView beginHeaderRefresh];
    
}

// 屏幕旋转设置
- (BOOL)shouldAutorotate{
    //是否允许转屏
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    //viewController所支持的全部旋转方向
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    //viewController初始显示的方向
    return UIInterfaceOrientationPortrait;
}
// // //




#pragma mark - <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.liveRooms.count != 0) {
        if (section == 0) {
            return 1;
        } else if (section == 1) {
            return self.liveRooms.count - 1;
        }
    }
    
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = 0;
    if (indexPath.section == 1) {
        index = indexPath.row + 1;
    }
    
    BJLiveRoomCollectionViewCell *cell = nil;
    if (index == 0) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"liveroomcell" forIndexPath:indexPath];
    } else {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"liveroomsmallcell" forIndexPath:indexPath];
    }
    
    cell.liveImageURL = self.liveRooms[index].live_img_url;
    cell.userImageURL = self.liveRooms[index].live_userimg_url;
    cell.nickName = self.liveRooms[index].live_nickname;
    cell.onlineNum = self.liveRooms[index].live_online;
    cell.liveTitle = self.liveRooms[index].live_title;
    
    [cell loadData];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqual:UICollectionElementKindSectionHeader]) {
        UICollectionViewCell *cell = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"collectionviewheader" forIndexPath:indexPath];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, cell.bounds.size.width, cell.bounds.size.height)];
        label.text = @"|  直播列表";
        label.font = [UIFont fontWithName:@"Helvetica" size:11];
        [cell addSubview:label];
        return cell;
    }
    return nil;
}


#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = 0;
    if (indexPath.section == 1) {
        index = indexPath.row + 1;
    }
    
    [BJNetManager getLiveUrlWithLiveID:self.liveRooms[index].live_id UrlStr:self.liveRooms[index].url_info.urlStr Referer:self.liveRooms[index].url_info.referer UserAgent:self.liveRooms[index].url_info.user_agent CompletionHandler:^(NSArray<NSString *> *urlStrs, NSError *error) {
        
        if (error == nil) {
            
            NSString *urlPath;
            if (urlStrs.count == 1) {
                urlPath = urlStrs[0];
            } else if (urlStrs.count == 2) {
                urlPath = urlStrs[1];
            }
            
            
            NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
            
            // increase buffering for .wmv, it solves problem with delaying audio frames
            if ([urlPath.pathExtension isEqualToString:@"wmv"])
                parameters[KxMovieParameterMinBufferedDuration] = @(5.0);
            
            // disable deinterlacing for iPhone, because it's complex operation can cause stuttering
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                parameters[KxMovieParameterDisableDeinterlacing] = @(YES);
            
            // disable buffering
            //parameters[KxMovieParameterMinBufferedDuration] = @(0.0f);
            //parameters[KxMovieParameterMaxBufferedDuration] = @(0.0f);
            
            KxMovieViewController *vc = [KxMovieViewController movieViewControllerWithContentPath:urlPath
                                                                                       parameters:parameters];
            [self presentViewController:vc animated:YES completion:nil];
            
            
        } else {
            DDLogError(@"play live error[%@]", error.localizedDescription);
            
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"由于版权原因，暂时不能播放" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:cancelAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        
    }];
}






#pragma mark - UICollectionViewDelegateFlowLayout

// 设置分区头的size
-(CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return CGSizeMake(0, 0);
    }
    return CGSizeMake(50, 30);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake(self.LiveCollectionView.bounds.size.width, self.LiveCollectionView.bounds.size.height*2/5);
    }
    return CGSizeMake(self.LiveCollectionView.bounds.size.width/2 - 0.5, self.LiveCollectionView.bounds.size.height/5);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        return UIEdgeInsetsMake(0, 0, 1, 0);
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}


@end
