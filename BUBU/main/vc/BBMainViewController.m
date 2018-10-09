//
//  BBMainViewController.m
//  BUBU
//
//  Created by 董志盟 on 2018/10/8.
//  Copyright © 2018年 DZM. All rights reserved.
//
#define KIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO) || ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO) || ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)



#import "BBMainViewController.h"
#import "BBScrollerCell.h"
#import "BBMovieDetialCell.h"
#import "BBMovieList.h"
#import "BBMovieDetialController.h"
#import "UIViewController+Extension.h"

@interface BBMainViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (strong, nonatomic) UITableView *tableView;
@end

@implementation BBMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.title = @"推荐";
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, KIsiPhoneX?88:64, self.view.bounds.size.width, KIsiPhoneX?(self.view.bounds.size.height - 88 - 64):((self.view.bounds.size.height - 64 - 44)))];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"BBMovieDetialCell" bundle:nil] forCellReuseIdentifier:@"BBMovieDetialCell"];
//    [_tableView registerNib:[UINib nibWithNibName:@"SSQTextFieldCell" bundle:nil] forCellReuseIdentifier:@"SSQTextFieldCell"];
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 44.0; // 设置为一个接近“平均”行高的值,用来估算修正tableView滚动条的高度
    //    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    _tableView.tableFooterView = [UIView new];
    //判断是否需要根据内容留有空白 解决问题
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 9.0)
    {
        _tableView.cellLayoutMarginsFollowReadableWidth = NO;
    }
    [self.view addSubview:_tableView];
    
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.row == 0) {
        BBScrollerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BBScrollerCell"];
        if (!cell) {
            cell = [[BBScrollerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BBScrollerCell"];
        }
        cell.cellClickBlock = ^(NSInteger tag) {
            BBMovieDetialController *vc = [[BBMovieDetialController alloc] init];
            vc.titleStr = [[BBMovieList scrollerTitArr] objectAtIndex:tag - 1];
            vc.detail = [[BBMovieList scrollerDetailArr] objectAtIndex:tag - 1];
            [self presentViewController:vc animated:YES completion:nil];
        };
        return cell;
    }else{
        BBMovieDetialCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BBMovieDetialCell"];
        if (!cell) {
            cell = [[BBMovieDetialCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BBMovieDetialCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.titleLabel.text = [[BBMovieList titArr] objectAtIndex:indexPath.row -1];
        cell.detalLabel.text = [[BBMovieList detailArr] objectAtIndex:indexPath.row -1];
        cell.mImageView.image = [UIImage imageNamed:[[BBMovieList imageArr] objectAtIndex:indexPath.row -1]];;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 240;
    }else{
        return 80;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
    }else{
        BBMovieDetialController *vc = [[BBMovieDetialController alloc] init];
        vc.titleStr = [[BBMovieList titArr] objectAtIndex:indexPath.row -1];
        vc.detail = [[BBMovieList detailArr] objectAtIndex:indexPath.row -1];
//        vc.mImage = [UIImage imageNamed:[[BBMovieList imageArr] objectAtIndex:indexPath.row -1]];
        [self presentViewController:vc animated:YES completion:nil];
    }
}

@end
