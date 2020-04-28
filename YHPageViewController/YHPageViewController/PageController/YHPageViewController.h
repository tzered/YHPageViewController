//
//  YHPageViewController.h
//  MoreCoin
//
//  Created by 林宁宁 on 2019/11/1.
//  Copyright © 2019 MoreCoin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHSegmentView.h"
#import "YHPageControllerItem.h"

NS_ASSUME_NONNULL_BEGIN

@protocol YHPageViewControllerProtocol <NSObject>


@optional

/// 内容区域大小
- (CGRect)yh_frameForContentView;
/// 标题区域大小
- (CGRect)yh_frameForMenuView;
/// 初始选中位置
- (NSInteger)yh_defaultSelectedIndex;
/// 选中某个位置
//- (void)yh_segmentChangeAtIndex:(NSInteger)index;
/// 菜单显示在导航条上
- (BOOL)yh_segmentMenuShowOnNavigationBar;
/// 未读消息
- (NSString *)yh_badgeCountIndex:(NSInteger)index;

@end

@interface YHPageViewController : UIViewController<YHPageViewControllerProtocol>

/// 菜单视图
@property (retain, nonatomic) YHSegmentView * segmentControl;

/// 选中位置
@property (assign, nonatomic) NSInteger selectIndex;

/// 当在第一个界面的时候 可以左滑返回  default NO
@property (assign, nonatomic) BOOL canPanPopBackWhenAtFirstPage;
/// 关联的滑动返回的手势
@property (weak, nonatomic) UIViewController * relatePanParentViewController;

- (void)yh_addChildController:(UIViewController *)controller title:(NSString * _Nullable)title;
- (void)yh_addChildController:(UIViewController *)controller titleConfig:(void(^_Nonnull)(YHPageTitleItem * item))config;

- (void)yh_reloadController;
- (void)yh_reloadBadgeCount;

- (void)yh_cleanController;



/// 子控制器个数
- (NSInteger)yh_countChildControllers;
/// 标题
- (YHPageTitleItem *)yh_titleAtIndex:(NSInteger)index;
/// 控制器
- (UIViewController *)yh_controllerAtIndex:(NSInteger)index;
/// 控制器
- (UIViewController *)yh_currentController;


@end


NS_ASSUME_NONNULL_END
