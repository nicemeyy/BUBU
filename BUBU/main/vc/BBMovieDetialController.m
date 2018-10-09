//
//  BBMovieDetialController.m
//  BUBU
//
//  Created by 董志盟 on 2018/10/8.
//  Copyright © 2018年 DZM. All rights reserved.
//
#define KIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO) || ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO) || ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)

#import "BBMovieDetialController.h"

@interface BBMovieDetialController ()

@property (nonatomic ,strong) UILabel *titleLabel;
@property (nonatomic ,strong) UITextView *detailLabel;

@end

@implementation BBMovieDetialController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *headerView = [[UIView alloc] init];
    headerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:headerView];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _titleLabel.font = [UIFont systemFontOfSize:17.0];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = _titleStr;
    [headerView addSubview:_titleLabel];
    
    UIButton *removeBtn = [[UIButton alloc] init];
    removeBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [removeBtn setImage:[UIImage imageNamed:@"icon_remove"] forState:UIControlStateNormal];
    [removeBtn addTarget:self action:@selector(removeClick:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:removeBtn];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.translatesAutoresizingMaskIntoConstraints = NO;
    lineView.backgroundColor = [UIColor lightGrayColor];
    [headerView addSubview:lineView];
    
    [headerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(45)-[_titleLabel]-(5)-[removeBtn(30)]-(10)-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_titleLabel,removeBtn)]];
    [headerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[lineView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(lineView)]];
    
    [headerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[lineView(1)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(lineView)]];
    [headerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_titleLabel(30)]-(7)-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_titleLabel)]];
    [headerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[removeBtn(30)]-(7)-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(removeBtn)]];
    

    _detailLabel = [[UITextView alloc] init];
    _detailLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _detailLabel.font = [UIFont systemFontOfSize:17.0];
    _detailLabel.textAlignment = NSTextAlignmentLeft;
    _detailLabel.editable = NO;
    _detailLabel.text = _detail;
    [self.view addSubview:_detailLabel];

    NSDictionary *dic = @{
                          @"headerViewHeight":@(KIsiPhoneX?88:64),
                          @"width":@(self.view.bounds.size.width)
                          };

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[headerView(headerViewHeight)]-(20)-[_detailLabel]|" options:0 metrics:dic views:NSDictionaryOfVariableBindings(headerView,_detailLabel)]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(15)-[_detailLabel]-(15)-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_detailLabel)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[headerView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(headerView)]];
}

- (void)removeClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
