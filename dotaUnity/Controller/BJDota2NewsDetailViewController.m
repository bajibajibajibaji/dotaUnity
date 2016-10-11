//
//  BJDota2NewsDetailViewController.m
//  dotaUnity
//
//  Created by admin on 16/4/29.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import "BJDota2NewsDetailViewController.h"
#import "BJCommentTableViewCell.h"
#import "BJDota2NewsViewController.h"
#import "BJNewsCommentsListViewModel.h"
#import "BJCommentTableViewCell.h"

@interface BJDota2NewsDetailViewController () <UIWebViewDelegate, SwipeViewDataSource, SwipeViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) HMSegmentedControl *segment;
@property (nonatomic, strong) SwipeView *swipView;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UITableView *commentTableView;



@property (nonatomic, strong) BJNewsCommentsListViewModel *nclVM; /** commentTableView 数据源 */
@property (nonatomic, strong) UILabel *headerRightLabel; /** 显示评论总数 */
@property (nonatomic, assign) BOOL isGetComment; /** 是否已从网络获取评论数据 */

@property (nonatomic, strong) NSMutableDictionary *commentIsShowDic; /** 存放NSNumber0:NSNumber1   NSNumber0表示cell序号 ，NSNumber1表示评论是否展开(0-没展开，1-展开) */

@end

static CGPoint tmpPos; //记录commentTableView的contentOffSet

@implementation BJDota2NewsDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self segment];
    [self swipView];
    
    /** 自定义导航栏 */
    UIBarButtonItem * backBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonClick)];
    self.navigationItem.leftBarButtonItems = @[backBarButton];
    self.navigationItem.title = @"CC+ 新闻";
    
    self.commentIsShowDic = [NSMutableDictionary dictionaryWithCapacity:20];
    for (int i = 0; i < self.nclVM.commentsArray.count; ++i) {
        [self.commentIsShowDic setObject:@0 forKey:@(i)];
    }
    
    self.isGetComment = NO;
    
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


#pragma mark - lazy load

- (HMSegmentedControl *)segment
{
    ws(weakSelf);
    if (_segment == nil) {
        _segment = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 25)];
        _segment.sectionTitles = @[@"新闻                                             ", @"评论                                             "];
        _segment.indexChangeBlock = ^(NSInteger index){
            [weakSelf.swipView scrollToItemAtIndex:index duration:0.2];
            tmpPos = weakSelf.commentTableView.contentOffset;
        };
        _segment.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12], NSForegroundColorAttributeName:[UIColor whiteColor]};
        _segment.selectedTitleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12], NSForegroundColorAttributeName:[UIColor yellowColor]};
        _segment.backgroundColor = [UIColor blackColor];
        _segment.selectionIndicatorColor = [UIColor yellowColor];
        _segment.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        _segment.selectionIndicatorHeight = 0.8;
        
        [self.view addSubview:_segment];
    }
    return _segment;
}

- (SwipeView *)swipView
{
    if (_swipView == nil) {
        _swipView = [[SwipeView alloc] initWithFrame:CGRectMake(0, 25, self.view.frame.size.width, self.view.frame.size.height)];
        _swipView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
        _swipView.dataSource = self;
        _swipView.delegate = self;
        
        [self.view addSubview:_swipView];
    }
    return _swipView;
}

- (UIWebView *)webView
{
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 25, self.view.frame.size.width, self.view.frame.size.height-25)];
        _webView.backgroundColor = [UIColor whiteColor];
        
        _webView.delegate = self;
        [self.view addSubview:_webView];
    }
    return _webView;
}

- (UITableView *)commentTableView
{
    if (_commentTableView == nil) {
        _commentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 25, self.view.frame.size.width, self.view.frame.size.height-25)];
        
        _commentTableView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
        _commentTableView.autoresizingMask = UIViewAutoresizingNone;
        _commentTableView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
        
        // 设置自动行高
        _commentTableView.rowHeight = UITableViewAutomaticDimension;
        _commentTableView.estimatedRowHeight = 160.0; // 设置为一个接近“平均”行高的值
        
        // 去除空白行
        _commentTableView.tableFooterView = [[UIView alloc] init];
        
        // header view
        _commentTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 411, 25)];
        _commentTableView.tableHeaderView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
        
        CGRect tmpFrame = _commentTableView.tableHeaderView.frame;
        tmpFrame.size.width /= 2;
        
        UILabel *headerLeftLabel = [[UILabel alloc] initWithFrame:tmpFrame];
        headerLeftLabel.font = [UIFont fontWithName:@"Helvetica" size:11];
        headerLeftLabel.text = @"|  全部评论";
        [_commentTableView.tableHeaderView addSubview:headerLeftLabel];
        
        tmpFrame.size.width -= 12;
        tmpFrame.origin.x = _commentTableView.tableHeaderView.frame.size.width / 2;
        self.headerRightLabel = [[UILabel alloc] initWithFrame:tmpFrame];
        self.headerRightLabel.font = [UIFont fontWithName:@"Helvetica" size:11];
        self.headerRightLabel.text = @"000条评论";
        self.headerRightLabel.textAlignment = NSTextAlignmentRight;
        [_commentTableView.tableHeaderView addSubview:self.headerRightLabel];
        
        //设置MJRefresh
        ws(weakSelf);
        [_commentTableView addHeaderRefreshWithHandler:^{
            [BJNewsCommentsListViewModel getCommentsWithNewsID:weakSelf.newsID Limit:30 CompletionHandler:^(BJNewsCommentsListViewModel *responsObject, NSError *error) {
                if (error == nil) {
                    weakSelf.nclVM = responsObject;
                    weakSelf.headerRightLabel.text = [NSString stringWithFormat:@"%ld条评论", (long)responsObject.commentsCount];
                    [weakSelf.commentTableView reloadData];
                    weakSelf.isGetComment = YES;
                    
                    for (int i = 0; i < weakSelf.nclVM.commentsArray.count; ++i) {
                        [weakSelf.commentIsShowDic setObject:@0 forKey:@(i)];
                    }
                    
                    [weakSelf.commentTableView endHeaderReresh];
                } else {
                    DDLogError(@"getComment error[%@]", error.localizedDescription);
                }
            }];
        }];
        
        [_commentTableView addFooterRefreshWithHandler:^{
            [BJNewsCommentsListViewModel getCommentsWithNewsID:weakSelf.newsID Limit:self.nclVM.commentsArray.count+30 CompletionHandler:^(BJNewsCommentsListViewModel *responsObject, NSError *error) {
                if (error == nil) {
                    weakSelf.nclVM = responsObject;
                    weakSelf.headerRightLabel.text = [NSString stringWithFormat:@"%ld条评论", (long)responsObject.commentsCount];
                    [weakSelf.commentTableView reloadData];
                    weakSelf.isGetComment = YES;
                    [weakSelf.commentTableView endFooterRefresh];
                } else {
                    DDLogError(@"getComment error[%@]", error.localizedDescription);
                }
            }];
        }];

        // dataSource and delegate
        _commentTableView.dataSource = self;
        _commentTableView.delegate = self;
        [self.view addSubview:_commentTableView];
        
        /** 注册BJCommentTableViewCell.xib ID:commentcell */
//        UINib *commentNib = [UINib nibWithNibName:@"BJCommentTableViewCell" bundle:nil];
//        [_commentTableView registerNib:commentNib forCellReuseIdentifier:@"commentcell"];
    }
    return _commentTableView;
}


#pragma mark - SwipeViewDataSource


- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    return 2;
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    if (index == 0) {
        return self.webView;
    } else if (index == 1) {
        return self.commentTableView;
    }
    return nil;
}

#pragma mark - SwipeViewDelegate


- (void)swipeViewDidScroll:(SwipeView *)swipeView
{
    if (_commentTableView != nil) {
        self.commentTableView.contentOffset = tmpPos;
    }
}

- (void)swipeViewWillBeginDragging:(SwipeView *)swipeView
{
    if (swipeView.currentItemIndex == 1) {
        tmpPos = self.commentTableView.contentOffset;
    }
}
- (void)swipeViewCurrentItemIndexDidChange:(SwipeView *)swipeView
{
    [self.segment setSelectedSegmentIndex:self.swipView.currentItemIndex animated:YES];
    
    if (self.swipView.currentItemIndex == 1) {
        // 获取评论数据
        if (self.isGetComment == NO) {
            ws(weakSelf);
            [BJNewsCommentsListViewModel getCommentsWithNewsID:self.newsID Limit:30 CompletionHandler:^(BJNewsCommentsListViewModel *responsObject, NSError *error) {
                if (error == nil) {
                    weakSelf.nclVM = responsObject;
                    weakSelf.headerRightLabel.text = [NSString stringWithFormat:@"%ld条评论", (long)responsObject.commentsCount];
                    [weakSelf.commentTableView reloadData];
                    weakSelf.isGetComment = YES;
                    
                    for (int i = 0; i < weakSelf.nclVM.commentsArray.count; ++i) {
                        [weakSelf.commentIsShowDic setObject:@0 forKey:@(i)];
                    }
                    
                    [weakSelf.commentTableView endHeaderReresh];
                } else {
                    DDLogError(@"getComment error[%@]", error.localizedDescription);
                }
            }];
        }
    }
}

#pragma mark - UIWebViewDelegate
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
    DDLogError(@"load news error[%@]", error.localizedDescription);
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.nclVM.commentsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    BJCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentcell" forIndexPath:indexPath];
    BJCommentTableViewCell *cell = nil;
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"BJCommentTableViewCell" owner:nil options:nil][0];
    }

    cell.avartarURL = self.nclVM.commentsArray[indexPath.row].commentsDetailArray[0].avartarURL;
    cell.username = self.nclVM.commentsArray[indexPath.row].commentsDetailArray[0].username;
    cell.level = self.nclVM.commentsArray[indexPath.row].commentsDetailArray[0].level;
    cell.up = self.nclVM.commentsArray[indexPath.row].commentsDetailArray[0].up;
    cell.create_at = self.nclVM.commentsArray[indexPath.row].commentsDetailArray[0].create_at;
    cell.contentText = self.nclVM.commentsArray[indexPath.row].commentsDetailArray[0].text;
    
    NSArray<BJNewsCommentsDetailViewModel *>  *detailVMArr = self.nclVM.commentsArray[indexPath.row].commentsDetailArray;
    NSMutableArray<BJReplyInfo *> *tmpArr = [NSMutableArray arrayWithCapacity:detailVMArr.count];
    for (int i = 1; i <detailVMArr.count; ++i) {
        BJReplyInfo *replyInfo = [[BJReplyInfo alloc] init];
        replyInfo.username         = detailVMArr[i].username;
        replyInfo.replyUserName    = detailVMArr[i].replyUserName;
        replyInfo.replyContentText = detailVMArr[i].text;
        replyInfo.create_at        = detailVMArr[i].create_at;
        
        [tmpArr addObject:replyInfo];
    }
    cell.replysArray = tmpArr;
    
    cell.dndVC = self;
    
    cell.cellIndex = indexPath.row;
    
    if ([self.commentIsShowDic[@(indexPath.row)] intValue] == 0 ) {
        cell.commentIsShow = NO;
    } else if ([self.commentIsShowDic[@(indexPath.row)] intValue] == 1) {
        cell.commentIsShow = YES;
    }
    
    [cell loadData];
    
    return cell;
}



#pragma mark - custom method
- (void)backButtonClick
{
    self.dnVC.hidesBottomBarWhenPushed = NO; /** 必须放popViewController的前面 */
    [self.navigationController popViewControllerAnimated:YES];
    tmpPos.y = 0;
}

- (void)loadNews
{
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:NEWSURLDETAIL(self.newsID)]]];
    [self.swipView reloadData];
}

- (void)addCommentIsShowDic:(BOOL)commentIsShow index:(NSInteger)index
{
    [self.commentIsShowDic setObject:@(commentIsShow) forKey:@(index)];
}

- (void)refreshCommentTableViewAtIndex:(NSInteger)index
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.commentTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}


@end
