//
//  BJGirefDetailViewController.m
//  dotaUnity
//
//  Created by admin on 16/5/13.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import "BJGirefDetailViewController.h"
#import "BJGirefDetailViewModel.h"
#import "BJVideoTableViewCell.h"
#import "BJGirefListViewController.h"

@interface BJGirefDetailViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *girefDetailTableView;

@property (nonatomic, strong) NSArray<BJGirefDetailViewModel *> *girefDetailsArray; /** <#注释#> */

@end

@implementation BJGirefDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置tableview分割线样式
    self.girefDetailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.girefDetailTableView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
    
    /** 自定义导航栏 */
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonClick)];;
    self.navigationItem.title = self.navigationItemTitle;
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"store"] style:UIBarButtonItemStylePlain target:self action:@selector(storeButton)];
    
    /** header view */
    self.girefDetailTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 411, 30)];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:self.girefDetailTableView.tableHeaderView.frame];
    headerLabel.font = [UIFont fontWithName:@"Helvetica" size:11];
    headerLabel.text = @"|  视频列表";
    [self.girefDetailTableView.tableHeaderView addSubview:headerLabel];
    
    ws(weakSelf);
    /** 设置刷新 */
    [self.girefDetailTableView addHeaderRefreshWithHandler:^{
        [BJGirefDetailViewModel getGirefDetailWithGirefName:weakSelf.girefName Limit:30 Offset:0 CompletionHandler:^(NSArray<BJGirefDetailViewModel *> *girefDetails, NSError *error) {
            if (error == nil) {
                weakSelf.girefDetailsArray = girefDetails;
                [weakSelf.girefDetailTableView reloadData];
                [weakSelf.girefDetailTableView endHeaderReresh];
            } else {
                DDLogError(@"load girefDetail error[%@]", error.localizedDescription);
            }
        }];
    }];
    
    [self.girefDetailTableView addFooterRefreshWithHandler:^{
        [BJGirefDetailViewModel getGirefDetailWithGirefName:weakSelf.girefName Limit:30 Offset:weakSelf.girefDetailsArray.count CompletionHandler:^(NSArray<BJGirefDetailViewModel *> *girefDetails, NSError *error) {
            if (error == nil) {
                weakSelf.girefDetailsArray = [weakSelf.girefDetailsArray arrayByAddingObjectsFromArray:girefDetails];
                [weakSelf.girefDetailTableView reloadData];
                [weakSelf.girefDetailTableView endFooterRefresh];
            } else {
                DDLogError(@"load girefDetail error[%@]", error.localizedDescription);
            }
        }];
    }];
    
    [self.girefDetailTableView beginHeaderRefresh];
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

- (void)backButtonClick
{
    self.glVC.hidesBottomBarWhenPushed = NO; /** 必须放popViewController的前面 */
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)storeButton
{
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.girefDetailsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BJVideoTableViewCell *cell = nil;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"largegirefvideocell" forIndexPath:indexPath];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"smallgirefvideocell" forIndexPath:indexPath];
    }
    
    cell.videoImageURL = self.girefDetailsArray[indexPath.row].videoImageURL;
    cell.title = self.girefDetailsArray[indexPath.row].videoTitle;
    cell.userImageURL = self.girefDetailsArray[indexPath.row].userImageURL;
    cell.userName = self.girefDetailsArray[indexPath.row].userName;
    cell.playNum = self.girefDetailsArray[indexPath.row].playNumber;
    cell.time = self.girefDetailsArray[indexPath.row].create_time;
    
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
    DDLogError(@"url[%@]", self.girefDetailsArray[indexPath.row].videoURL);
    //    [self.activityIndicatorView startAnimating];
    NSString *urlPath = [self.girefDetailsArray[indexPath.row].videoURL absoluteString];
    
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
                [BJVideoHistoryViewModel insertIntoVideoHistoryWithVideoImageURLStr:[weakSelf.girefDetailsArray[indexPath.row].videoImageURL absoluteString] Title:weakSelf.girefDetailsArray[indexPath.row].videoTitle VideoURLStr:urlPath];
            } else {
                [BJVideoHistoryViewModel updateVideoHistoryForVideoURLStr:urlPath];
            }
        }];
    }];
}



@end
