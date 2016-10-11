//
//  BJVideoTableViewController.m
//  dotaUnity
//
//  Created by admin on 16/5/9.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import "BJVideoTableViewController.h"
#import "BJVideoListViewModel.h"
#import "BJVideoTableViewCell.h"

@interface BJVideoTableViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *videoTableView;

@property (nonatomic, strong) NSArray<BJVideoListViewModel *> *videosArray; /** 数据源 */

@end

@implementation BJVideoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    * 设置tableview分割线样式
    self.videoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.videoTableView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
    
    /** 设置navigationItem */
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"store"] style:UIBarButtonItemStylePlain target:self action:@selector(storeButton)];
    
    /** header view */
    self.videoTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 411, 30)];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:self.videoTableView.tableHeaderView.frame];
    headerLabel.font = [UIFont fontWithName:@"Helvetica" size:11];
    headerLabel.text = @"|  视频列表";
    [self.videoTableView.tableHeaderView addSubview:headerLabel];
    
    ws(weakSelf);
    /** 设置刷新 */
    [self.videoTableView addHeaderRefreshWithHandler:^{
        [BJVideoListViewModel getVideoListWithLimit:30 Offset:0 CompletionHandler:^(NSArray<BJVideoListViewModel *> *videos, NSError *error) {
            weakSelf.videosArray = videos;
            [weakSelf.videoTableView reloadData];
            [weakSelf.videoTableView endHeaderReresh];
        }];
    }];
    
    [self.videoTableView addFooterRefreshWithHandler:^{
        [BJVideoListViewModel getVideoListWithLimit:30 Offset:self.videosArray.count CompletionHandler:^(NSArray<BJVideoListViewModel *> *videos, NSError *error) {
            weakSelf.videosArray = [weakSelf.videosArray arrayByAddingObjectsFromArray:videos];
            [weakSelf.videoTableView reloadData];
            [weakSelf.videoTableView endFooterRefresh];
        }];
    }];
    
    [self.videoTableView beginHeaderRefresh];
    
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


#pragma mark - custom method

- (void)storeButton
{

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.videosArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BJVideoTableViewCell *cell = nil;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"largevideocell" forIndexPath:indexPath];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"smallvideocell" forIndexPath:indexPath];
    }
    
    cell.videoImageURL = self.videosArray[indexPath.row].videoImageURL;
    cell.title = self.videosArray[indexPath.row].videoTitle;
    cell.userImageURL = self.videosArray[indexPath.row].userImageURL;
    cell.userName = self.videosArray[indexPath.row].userName;
    cell.playNum = self.videosArray[indexPath.row].playNumber;
    cell.time = self.videosArray[indexPath.row].create_time;
    
    [cell loadData];
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 215.0;
    } else {
        return 100.0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DDLogError(@"url[%@]", self.videosArray[indexPath.row].videoURL);
//    [self.activityIndicatorView startAnimating];
    NSString *urlPath = [self.videosArray[indexPath.row].videoURL absoluteString];
    
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
    ws(weakSelf);
    [self presentViewController:vc animated:YES completion:^{
        [BJVideoHistoryViewModel selectVideoHistoryWithVideoURLStr:urlPath CompletionHandler:^(NSArray<BJVideoHistoryViewModel *> *videoHistorys, NSError *error) {
            if (videoHistorys.count == 0) {
                [BJVideoHistoryViewModel insertIntoVideoHistoryWithVideoImageURLStr:[weakSelf.videosArray[indexPath.row].videoImageURL absoluteString] Title:weakSelf.videosArray[indexPath.row].videoTitle VideoURLStr:urlPath];
            } else {
                [BJVideoHistoryViewModel updateVideoHistoryForVideoURLStr:urlPath];
            }
        }];
    }];

}

#pragma mark - other


@end
