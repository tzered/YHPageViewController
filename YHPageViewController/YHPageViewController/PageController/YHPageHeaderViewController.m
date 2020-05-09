//
//  YHPageHeaderViewController.m
//  YHPageViewController
//
//  Created by 林宁宁 on 2020/4/28.
//  Copyright © 2020 林宁宁. All rights reserved.
//

#import "YHPageHeaderViewController.h"
#import "YHKit.h"

#import <UINavigationController+FDFullscreenPopGesture.h>

@interface YHPageHeaderViewController ()<UIGestureRecognizerDelegate>

@property (retain, nonatomic, readwrite) YHPageScrollView * scrollView;

@property (weak, nonatomic) UIView * pageHeaderView;

@property (retain, nonatomic, readwrite) YHPageViewController * pageViewController;

@end

@implementation YHPageHeaderViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    WS(weakSelf);
    
    self.scrollView = [YHPageScrollView new];
    self.scrollView.maxOffsetY = [self yh_pageHeaderHeight];
    [self.scrollView setDidScrollBlock:^(CGFloat offy) {
        /// 放大缩小
        if(offy >= 0){
            weakSelf.pageHeaderView.transform = CGAffineTransformIdentity;
        }else{
            CGFloat multi = ABS(offy*2)/CGRectGetHeight(weakSelf.pageHeaderView.frame);
            CGAffineTransform transform = CGAffineTransformMakeTranslation(0, offy*0.5);
            transform = CGAffineTransformScale(transform, 1+multi, 1+multi);
            weakSelf.pageHeaderView.transform = transform;
        }
        
        if(weakSelf.headerScrollBlock){
            weakSelf.headerScrollBlock(offy);
        }
    }];
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    
    self.pageHeaderView = [self yh_pageHeaderView];
    NSAssert(self.pageHeaderView, @"未设置header view ， yh_pageHeaderView 不能返回空");
    [self.scrollView addSubview:self.pageHeaderView];
    [self.pageHeaderView layoutSubviews];
    [self.pageHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.scrollView);
        make.width.equalTo(self.view);
        make.height.mas_equalTo([self yh_pageHeaderHeight]);
    }];
    
    
    self.pageViewController = [YHPageViewController new];
    self.pageViewController.canPanPopBackWhenAtFirstPage = YES;
    self.pageViewController.relatePanParentViewController = self;
    [self addChildViewController:self.pageViewController];
    [self.scrollView addSubview:self.pageViewController.view];
    [self.pageViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView);
        make.top.equalTo(self.pageHeaderView.mas_bottom);
        make.width.equalTo(self.view);
        make.height.equalTo(self.view);
        make.bottom.equalTo(self.scrollView);
    }];
    
}


- (UIView * _Nonnull)yh_pageHeaderView{
    return [UIView new];
}

- (CGFloat)yh_pageHeaderHeight{
    return 200;
}

@end
