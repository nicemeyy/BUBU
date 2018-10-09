//
//  BBScrollerCell.m
//  BUBU
//
//  Created by 董志盟 on 2018/10/8.
//  Copyright © 2018年 DZM. All rights reserved.
//
#define count 3
#define KIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO) || ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)

#import "BBScrollerCell.h"

@interface BBScrollerCell() <UIScrollViewDelegate>

@property (weak, nonatomic)UIScrollView *scrollView;

@property (weak, nonatomic)UIPageControl *pageView;

@property (strong, nonatomic)NSTimer *timer;

@end

@implementation BBScrollerCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self) {
        [self prepareScollView];
        [self preparePageView];
    }
    return self;
}

- (void)prepareScollView {
    CGFloat scrollW = [UIScreen mainScreen].bounds.size.width;
    CGFloat scrollH = 240;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, scrollW, scrollH)];
    scrollView.delegate = self;
    
    for (int i = 0; i < count; i++) {
        UIButton *imageView = [[UIButton alloc] init];
        NSString *name = [NSString stringWithFormat:@"img_0%d",i + 1];
        [imageView setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
        CGFloat imageX = scrollW * (i + 1);
        imageView.tag = i + 1;
        [imageView addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        imageView.frame = CGRectMake(imageX, 0, scrollW, scrollH);
//        imageView.backgroundColor = [UIColor yellowColor];
        [scrollView addSubview:imageView];
    }
    
    UIButton *firstImage = [[UIButton alloc] init];
    [firstImage setImage:[UIImage imageNamed:@"img_03"] forState:UIControlStateNormal];
//    firstImage.image = [UIImage imageNamed:@"img_03"];
    [firstImage addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    firstImage.tag = 3;
    firstImage.frame = CGRectMake(0, 0, scrollW, scrollH);
//    firstImage.backgroundColor = [UIColor blueColor];
    [scrollView addSubview:firstImage];
    scrollView.contentOffset = CGPointMake(scrollW, 0);
    
    UIButton *lastImage = [[UIButton alloc] init];
    lastImage.tag = 1;
    [lastImage addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [lastImage setImage:[UIImage imageNamed:@"img_01"] forState:UIControlStateNormal];
//    lastImage.image = [UIImage imageNamed:@"img_01"];
    lastImage.frame = CGRectMake((count + 1) * scrollW, 0, scrollW, scrollH);
//    lastImage.backgroundColor = [UIColor redColor];
    [scrollView addSubview:lastImage];
    scrollView.contentSize = CGSizeMake((count + 2) * scrollW, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    [self.contentView addSubview:scrollView];
    self.scrollView = scrollView;
    [self addTimer];
    
}

-(void)preparePageView {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    UIPageControl *pageView = [[UIPageControl alloc] initWithFrame:CGRectMake(-25, 200, width, 4)];
    pageView.numberOfPages = count;
    pageView.currentPageIndicatorTintColor = [UIColor redColor];
    pageView.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageView.currentPage = 0;
    [self.contentView addSubview:pageView];
    self.pageView = pageView;
}

- (void)addTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
}

-(void)nextImage {
    CGFloat width = self.scrollView.frame.size.width;
    NSInteger index = self.pageView.currentPage;
    if (index == count + 1) {
        index = 0;
    } else {
        index++;
    }
    [self.scrollView setContentOffset:CGPointMake((index + 1) * width, 0)animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat width = self.scrollView.frame.size.width;
    int index = (self.scrollView.contentOffset.x + width * 0.5) / width;
    if (index == count + 2) {
        index = 1;
    } else if(index == 0) {
        index = count;
    }
    self.pageView.currentPage = index - 1;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.timer invalidate];
    self.timer = nil;
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self addTimer];
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self scrollViewDidEndDecelerating:scrollView];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat width = self.scrollView.frame.size.width;
    int index = (self.scrollView.contentOffset.x + width * 0.5) / width;
    if (index == count + 1) {
        [self.scrollView setContentOffset:CGPointMake(width, 0) animated:NO];
    } else if (index == 0) {
        [self.scrollView setContentOffset:CGPointMake(count * width, 0) animated:NO];
    }
}

- (void)btnClick:(UIButton *)btn
{
    if (_cellClickBlock) {
        _cellClickBlock(btn.tag);
    }
}

@end
