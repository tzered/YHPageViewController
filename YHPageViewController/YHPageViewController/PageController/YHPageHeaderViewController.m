//
//  YHPageHeaderViewController.m
//  YHPageViewController
//
//  Created by 林宁宁 on 2020/4/28.
//  Copyright © 2020 林宁宁. All rights reserved.
//

#import "YHPageHeaderViewController.h"
#import "YHPageScrollView.h"
#import "YHKit.h"

#import <UINavigationController+FDFullscreenPopGesture.h>

@interface YHPageHeaderViewController ()<UIGestureRecognizerDelegate>

@property (retain, nonatomic) YHPageScrollView * scrollView;

@property (weak, nonatomic) UIView * pageHeaderView;

@property (retain, nonatomic, readwrite) YHPageViewController * pageViewController;

@end

@implementation YHPageHeaderViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    WS(weakSelf);
    
    self.pageHeaderView = [self yh_pageHeaderView];
    
    NSAssert(self.pageHeaderView, @"未设置header view ， yh_pageHeaderView 不能返回空");
    
    self.scrollView = [YHPageScrollView new];
    self.scrollView.maxOffsetY = CGRectGetMaxY(self.pageHeaderView.frame);
    [self.scrollView setDidScrollBlock:^(CGFloat offy) {
        if(weakSelf.headerScrollBlock){
            weakSelf.headerScrollBlock(offy);
        }
    }];
    [self.view addSubview:self.scrollView];
    self.scrollView.frame = self.view.bounds;
    
    
    [self.scrollView addSubview:self.pageHeaderView];
    [self.pageHeaderView layoutSubviews];
    
    
    self.pageViewController = [YHPageViewController new];
    self.pageViewController.canPanPopBackWhenAtFirstPage = YES;
    self.pageViewController.relatePanParentViewController = self;
    [self addChildViewController:self.pageViewController];
    [self.scrollView addSubview:self.pageViewController.view];
    self.pageViewController.view.frame = CGRectMake(0, CGRectGetMaxY(self.pageHeaderView.frame), CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
    
    
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame) + CGRectGetMaxY(self.pageHeaderView.frame));
}


- (UIView * _Nonnull)yh_pageHeaderView{
    return [UIView new];
}

@end
