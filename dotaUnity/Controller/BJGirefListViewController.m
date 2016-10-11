//
//  BJGirefListViewController.m
//  dotaUnity
//
//  Created by admin on 16/5/13.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import "BJGirefListViewController.h"
#import "BJGirefListViewModel.h"
#import "BJGirefTableViewCell.h"
#import "BJGirefDetailViewController.h"

@interface BJGirefListViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *girefTableView;

@property (nonatomic, strong) NSArray<BJGirefListViewModel *> *girefsArray; /** <#注释#> */

@end

@implementation BJGirefListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置tableview分割线样式
//    self.girefTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.girefTableView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
    
    // 去除空白行
    self.girefTableView.tableFooterView = [[UIView alloc] init];
    
    /** 设置navigationItem */
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"store"] style:UIBarButtonItemStylePlain target:self action:@selector(storeButton)];
    
    /** header view */
    self.girefTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 411, 30)];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:self.girefTableView.tableHeaderView.frame];
    headerLabel.font = [UIFont fontWithName:@"Helvetica" size:11];
    headerLabel.text = @"|  解说列表";
    [self.girefTableView.tableHeaderView addSubview:headerLabel];
    
    ws(weakSelf);
    /** 设置刷新 */
    [self.girefTableView addHeaderRefreshWithHandler:^{
        [BJGirefListViewModel getGirefListWithCompletionHandler:^(NSArray<BJGirefListViewModel *> *girefs, NSError *error) {
            if (error == nil) {
                weakSelf.girefsArray = girefs;
                
//                for (BJGirefListViewModel *aaa in girefs) {
//                    DDLogError(@"[%@]", aaa.userImageURL);
//                    DDLogError(@"[%@]", aaa.userName);
//                    DDLogError(@"[%ld]", aaa.videoNum);
//                    DDLogError(@"[%@]", aaa.createTime);
//                }
                
                [weakSelf.girefTableView reloadData];
                [weakSelf.girefTableView endHeaderReresh];
            } else {
                DDLogError(@"getGirefList error[%@]", error.localizedDescription);
            }
        }];
    }];
    
    [self.girefTableView beginHeaderRefresh];
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

- (void)storeButton
{
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    self.hidesBottomBarWhenPushed=YES;

    NSIndexPath *indexPath = [self.girefTableView indexPathForCell:sender];
    BJGirefDetailViewController *gdVC = segue.destinationViewController;
    gdVC.girefName = self.girefsArray[indexPath.row].girefName;
    gdVC.navigationItemTitle = self.girefsArray[indexPath.row].userName;
    gdVC.glVC = self;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.girefsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BJGirefTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"girefcell" forIndexPath:indexPath];
    cell.userImageURL = self.girefsArray[indexPath.row].userImageURL;
    cell.userName = self.girefsArray[indexPath.row].userName;
    cell.videoNum = self.girefsArray[indexPath.row].videoNum;
    cell.createTime = self.girefsArray[indexPath.row].createTime;
    
    [cell loadData];
    
    return cell;
}

@end
