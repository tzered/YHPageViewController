//
//  YHPageHeaderViewController.h
//  YHPageViewController
//
//  Created by 林宁宁 on 2020/4/28.
//  Copyright © 2020 林宁宁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHPageViewController.h"
#import "YHPageScrollView.h"

@protocol YHPageHeaderViewControllerDelegate <NSObject>

- (UIView * _Nonnull)yh_pageHeaderView;
- (CGFloat)yh_pageHeaderHeight;

@end

NS_ASSUME_NONNULL_BEGIN

@interface YHPageHeaderViewController : UIViewController<YHPageHeaderViewControllerDelegate>

@property (retain, nonatomic, readonly) YHPageViewController * pageViewController;

@property (retain, nonatomic, readonly) YHPageScrollView * scrollView;

/// 顶部滚动
@property (copy, nonatomic) void(^headerScrollBlock)(CGFloat offy);

@end

NS_ASSUME_NONNULL_END
