//
//  BJVideoHistoryViewController.m
//  dotaUnity
//
//  Created by admin on 16/5/14.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import "BJVideoHistoryViewController.h"
#import "BJVideoHistoryTableViewCell.h"
#import "BJVideoHistoryViewModel.h"

@interface BJVideoHistoryViewController () <UITableViewDataSource, UITableViewDelegate, UISearchControllerDelegate, UISearchResultsUpdating>
@property (weak, nonatomic) IBOutlet UITableView *videoHistoryTableView;

@property (strong, nonatomic) UISearchController *searchCtl;

@property (nonatomic, strong) NSArray<BJVideoHistoryViewModel *> *videoHisArray;
@property (nonatomic, strong) NSMutableArray<BJVideoHistoryViewModel *> *searchVideoHisArray;
@end

@implementation BJVideoHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.videoHistoryTableView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
    
    self.tabBarController.tabBar.hidden = YES;
    
    /** 自定义导航栏 */
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonClick)];
    self.navigationItem.title = @"观看历史";    
    // 去除空白行
    self.videoHistoryTableView.tableFooterView = [[UIView alloc] init];
    
    ws(weakSelf);
    [self.videoHistoryTableView addHeaderRefreshWithHandler:^{
        [BJVideoHistoryViewModel selectVideoHistoryWithLimit:30 Offset:0 CompletionHandler:^(NSArray<BJVideoHistoryViewModel *> *videoHistorys, NSError *error) {
            weakSelf.videoHisArray = videoHistorys;
            [weakSelf.videoHistoryTableView reloadData];
            [weakSelf.videoHistoryTableView endHeaderReresh];
        }];
    }];
    
    [self.videoHistoryTableView addFooterRefreshWithHandler:^{
        [BJVideoHistoryViewModel selectVideoHistoryWithLimit:30 Offset:weakSelf.videoHisArray.count CompletionHandler:^(NSArray<BJVideoHistoryViewModel *> *videoHistorys, NSError *error) {
            weakSelf.videoHisArray = [weakSelf.videoHisArray arrayByAddingObjectsFromArray:videoHistorys];
            [weakSelf.videoHistoryTableView reloadData];
            [weakSelf.videoHistoryTableView endFooterRefresh];
        }];
    }];
    
    [self.videoHistoryTableView beginHeaderRefresh];
    
    // 搜索
    self.searchCtl = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchCtl.searchResultsUpdater = self;
    self.searchCtl.delegate = self;
    self.searchCtl.dimsBackgroundDuringPresentation = NO;
    self.searchCtl.hidesNavigationBarDuringPresentation = NO;
    self.searchCtl.searchBar.frame = CGRectMake(self.searchCtl.searchBar.frame.origin.x, self.searchCtl.searchBar.frame.origin.y, self.searchCtl.searchBar.frame.size.width, 44.0);
    self.searchCtl.searchBar.placeholder = @"搜索";
    self.videoHistoryTableView.tableHeaderView = self.searchCtl.searchBar;

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
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.searchCtl.active) {
        return self.searchVideoHisArray.count;
    }else{
        return self.videoHisArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BJVideoHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"videohistorycell" forIndexPath:indexPath];
    
    if (self.searchCtl.active) {
        cell.videoImageURL = [NSURL URLWithString:self.searchVideoHisArray[indexPath.row].videoImageURLStr];
        cell.title = self.searchVideoHisArray[indexPath.row].videoTitle;
        cell.createTime = self.searchVideoHisArray[indexPath.row].videoCreateTime;
    } else {
        cell.videoImageURL = [NSURL URLWithString:self.videoHisArray[indexPath.row].videoImageURLStr];
        cell.title = self.videoHisArray[indexPath.row].videoTitle;
        cell.createTime = self.videoHisArray[indexPath.row].videoCreateTime;
    }
    
    [cell loadData];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *urlPath = nil;
    if (self.searchCtl.active) {
        urlPath = self.searchVideoHisArray[indexPath.row].videoURLStr;
    } else {
        urlPath = self.videoHisArray[indexPath.row].videoURLStr;
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
    [self presentViewController:vc animated:YES completion:^{
        [BJVideoHistoryViewModel updateVideoHistoryForVideoURLStr:urlPath];
    }];
}

// 设置searchBar的取消按钮的文字
- (void)willPresentSearchController:(UISearchController *)searchController
{
    searchController.searchBar.showsCancelButton = YES;
    UIButton *cancelButton;
    UIView *topView = searchController.searchBar.subviews[0];
    for (UIView *subView in topView.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UINavigationButton")]) {
            cancelButton = (UIButton*)subView;
        }
    }
    if (cancelButton) {
        //Set the new title of the cancel button
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        cancelButton.tintColor = [UIColor whiteColor];
    }
}

- (void)didPresentSearchController:(UISearchController *)searchController
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage new] style:UIBarButtonItemStylePlain target:self action:@selector(nilMethod)];
}

- (void)nilMethod{}

- (void)didDismissSearchController:(UISearchController *)searchController
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonClick)];
}

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchString = [searchController.searchBar text];
    if (searchString.length != 0) {
        NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF.videoTitle CONTAINS[c] %@", searchString];
        if (self.searchVideoHisArray!= nil) {
            [self.searchVideoHisArray removeAllObjects];
        }
        //过滤数据
        self.searchVideoHisArray= [NSMutableArray arrayWithArray:[self.videoHisArray filteredArrayUsingPredicate:preicate]];
        //刷新表格
        [self.videoHistoryTableView reloadData];
    } else {
        self.searchVideoHisArray = [self.videoHisArray mutableCopy];
        [self.videoHistoryTableView reloadData];
    }
}


@end
