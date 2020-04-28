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

@interface YHPageViewController : UIViewController

/// 菜单视图
@property (retain, nonatomic, readonly) YHSegmentView * segmentControl;

/// 选中位置
@property (assign, nonatomic) NSInteger selectIndex;

/// 当在第一个界面的时候 可以左滑返回  default NO
@property (assign, nonatomic) BOOL canPanPopBackWhenAtFirstPage;
/// 关联的滑动返回的手势
@property (weak, nonatomic) UIViewController * relatePanParentViewController;


/// 菜单显示在导航条上
@property (assign, nonatomic) BOOL segmentMenuShowOnNavigationBar;

/// 标题区域大小
@property (assign, nonatomic) CGRect frameForMenuView;
/// 内容区域大小
@property (assign, nonatomic) CGRect frameForContentView;
/// 未读消息
@property (copy, nonatomic) void(^badgeCountIndexBlock)(NSInteger index, UIButton * badgeView);


- (void)yh_addChildController:(UIViewController *)controller title:(NSString * _Nullable)title;
- (void)yh_addChildController:(UIViewController *)controller titleConfig:(void(^_Nonnull)(YHPageTitleItem * item))config;

- (void)yh_reloadController;
- (void)yh_reloadSegmentMenu;
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
