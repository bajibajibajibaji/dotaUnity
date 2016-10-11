//
//  BJMyInfoViewController.m
//  dotaUnity
//
//  Created by admin on 16/5/13.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import "BJMyInfoViewController.h"
#import <MessageUI/MFMailComposeViewController.h>

@interface BJMyInfoViewController () <UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myInfoTableView;

@property (nonatomic, weak) UILabel *cacheLabel; /** <#注释#> */
@end

@implementation BJMyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.myInfoTableView.contentInset = UIEdgeInsetsMake(-24, 0, 0, 0);
    
    // 去除空白行
    self.myInfoTableView.tableFooterView = [[UIView alloc] init];
}

- (void)viewDidAppear:(BOOL)animated
{
    ws(weakSelf);
    if (self.cacheLabel != nil) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSInteger cacheSize = [[SDImageCache sharedImageCache] getSize];
            NSString *cacheSizeStr = nil;
            if (cacheSize < 1024) {
                cacheSizeStr = [NSString stringWithFormat:@"%ldB", cacheSize];
            } else if (cacheSize >= 1024 && cacheSize < 1024*1024) {
                cacheSizeStr = [NSString stringWithFormat:@"%ldKB", cacheSize/1024];
            } else if (cacheSize >= 1024*1024 && cacheSize < 1024*1024*1024) {
                cacheSizeStr = [NSString stringWithFormat:@"%ldM", cacheSize/1024/1024];
            } else {
                cacheSizeStr = @"Boom Sha Ka La Ka!";
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.cacheLabel.text = cacheSizeStr;
            });
        });

    }
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseID = nil;
    if (indexPath.section == 0) {
        reuseID = @"guankanlishicell";
    } else if (indexPath.section == 1) {
        reuseID = @"qinglitupianhuancuncell";
    } else if (indexPath.section == 2) {
        reuseID = @"lianxizuozhecell";
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID forIndexPath:indexPath];
    
    ws(weakSelf);
    if (indexPath.section == 1) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSInteger cacheSize = [[SDImageCache sharedImageCache] getSize];
            NSString *cacheSizeStr = nil;
            if (cacheSize < 1024) {
                cacheSizeStr = [NSString stringWithFormat:@"%ldB", cacheSize];
            } else if (cacheSize >= 1024 && cacheSize < 1024*1024) {
                cacheSizeStr = [NSString stringWithFormat:@"%ldKB", cacheSize/1024];
            } else if (cacheSize >= 1024*1024 && cacheSize < 1024*1024*1024) {
                cacheSizeStr = [NSString stringWithFormat:@"%ldM", cacheSize/1024/1024];
            } else {
                cacheSizeStr = @"Boom Sha Ka La Ka!";
            }
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(cell.contentView.bounds.size.width-180, 0, 160, cell.contentView.bounds.size.height)];
            label.textAlignment = NSTextAlignmentRight;
            label.font = [UIFont systemFontOfSize:17];
            weakSelf.cacheLabel = label;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [cell.contentView addSubview:label];
                label.text = cacheSizeStr;
            });
        });
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
    
    } else if (indexPath.section == 1) {
        [self clearTmpPics];
    } else if (indexPath.section == 2) {
        [self sendMailInApp];
    }
}

- (void)clearTmpPics
{
    [[SDImageCache sharedImageCache] clearMemory];//可有可无
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self.cacheLabel.text = @"0B";
        });
    }];

}



#pragma mark - 在应用内发送邮件
//激活邮件功能
- (void)sendMailInApp
{
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    if (![mailClass canSendMail]) {
        UIAlertController *alertCtl = [UIAlertController alertControllerWithTitle:@"错误" message:@"用户没有设置邮件账户" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAct = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:nil];
        [alertCtl addAction:alertAct];
        
        [self presentViewController:alertCtl animated:YES completion:nil];
        return;
    }
    
    if (!mailClass) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto://chen329321555@163.com"]];
        return;
    }

    [self displayMailPicker];
}

//调出邮件发送窗口
- (void)displayMailPicker
{
    MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];
    mailPicker.mailComposeDelegate = self;
    
    //设置主题
    [mailPicker setSubject: @"eMail主题"];
    //添加收件人
    NSArray *toRecipients = [NSArray arrayWithObject: @"chen329321555@163.com"];
    [mailPicker setToRecipients: toRecipients];
    
    [self presentViewController:mailPicker animated:YES completion:nil];
}

#pragma mark - 实现 MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    //关闭邮件发送窗口
    [self dismissViewControllerAnimated:YES completion:nil];
    NSString *msg;
    switch (result) {
        case MFMailComposeResultCancelled:
            msg = @"用户取消编辑邮件";
            break;
        case MFMailComposeResultSaved:
            msg = @"用户成功保存邮件";
            break;
        case MFMailComposeResultSent:
            msg = @"用户点击发送，将邮件放到队列中，还没发送";
            break;
        case MFMailComposeResultFailed:
            msg = @"用户试图保存或者发送邮件失败";
            break;
        default:
            msg = @"";
            break;
    }
    DDLogInfo(@"main result[%@]", msg);
}




@end
