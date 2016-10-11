//
//  BJDota2NewsViewController.m
//  dotaUnity
//
//  Created by admin on 16/4/26.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import "BJDota2NewsViewController.h"
#import "BJDota2NewsViewModel.h"
#import "BJNewsCommentsListViewModel.h"
#import "BJNewsTableViewCell.h"
#import "UITableView+VendorMJRefresh.h"
#import "BJDota2NewsDetailViewController.h"


@interface BJDota2NewsViewController ()

@property (nonatomic, strong) NSArray<BJDota2NewsViewModel *> *newsArray; /** 数据源 */

@end

@implementation BJDota2NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置tableview分割线样式 
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    /** 设置navigationItem */
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"store"] style:UIBarButtonItemStylePlain target:self action:@selector(storeButton)];
    
    /** header view */
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 411, 30)];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:self.tableView.tableHeaderView.frame];
    headerLabel.font = [UIFont fontWithName:@"Helvetica" size:11];
    headerLabel.text = @"|  新闻 - 话题";
    [self.tableView.tableHeaderView addSubview:headerLabel];
    
    ws(weakSelf);
    
    /** 设置刷新 */
    [self.tableView addHeaderRefreshWithHandler:^{
        [BJDota2NewsViewModel getDota2NewsListWithOffset:0 completionHandler:^(NSArray<BJDota2NewsViewModel *> *dota2NewsList, NSError *error) {
            if (error == nil) {
                weakSelf.newsArray = dota2NewsList;
                [weakSelf.tableView reloadData];
                [weakSelf.tableView endHeaderReresh];
            } else {
                DDLogError(@"getDota2NewsList error[%@]", error.localizedDescription);
            }
        }];
    }];
    [self.tableView beginHeaderRefresh];
    
    [self.tableView addFooterRefreshWithHandler:^{
        [BJDota2NewsViewModel getDota2NewsListWithOffset:weakSelf.newsArray.count completionHandler:^(NSArray<BJDota2NewsViewModel *> *dota2NewsList, NSError *error) {
            if (error == nil) {
                weakSelf.newsArray = [weakSelf.newsArray arrayByAddingObjectsFromArray:dota2NewsList];
                [weakSelf.tableView reloadData];
                [weakSelf.tableView endFooterRefresh];
            } else {
                DDLogError(@"getDota2NewsList error[%@]", error.localizedDescription);
            }
        }];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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





- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    self.hidesBottomBarWhenPushed=YES;
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    BJDota2NewsDetailViewController *dndVC = segue.destinationViewController;
    dndVC.newsID = self.newsArray[indexPath.row].newsID;
    [dndVC loadNews];
    
    dndVC.dnVC = self;
}

#pragma mark - custom method

- (void)storeButton
{
    DDLogDebug(@"store");
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.newsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BJNewsTableViewCell *cell = nil;
    if (self.newsArray[indexPath.row].imageType == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"smallnewscell" forIndexPath:indexPath];
        cell.isSmallCell = YES;
        cell.labelFontColor = [UIColor blackColor];
    } else if (self.newsArray[indexPath.row].imageType == 2) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"largenewscell" forIndexPath:indexPath];
        cell.isSmallCell = NO;
        cell.labelFontColor = [UIColor whiteColor];
    }
    cell.imageURL = self.newsArray[indexPath.row].imageURL;
    cell.title = self.newsArray[indexPath.row].title;
    cell.createDate = self.newsArray[indexPath.row].createDate;
    cell.clickNum = self.newsArray[indexPath.row].clickNum;
    
    [cell loadData];
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.newsArray[indexPath.row].imageType == 2) {
        return 215.0;
    } else {
        return 100.0;
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
