//
//  YHPageViewController.m
//  MoreCoin
//
//  Created by 林宁宁 on 2019/11/1.
//  Copyright © 2019 MoreCoin. All rights reserved.
//

#import "YHPageViewController.h"
#import <UINavigationController+FDFullscreenPopGesture.h>
#import "UIView+YHBadge.h"
#import "YHKit.h"


@interface YHPageViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource,UIGestureRecognizerDelegate>{
    UIPanGestureRecognizer * _fakePan;
}

@property (retain, nonatomic) UIPageViewController * pageViewController;

@property (retain, nonatomic) NSMutableArray * pageControllerList;

@property (retain, nonatomic) NSMutableArray * yh_pageViewcontrollers;

@end

@implementation YHPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.pageControllerList = [NSMutableArray new];
    self.yh_pageViewcontrollers = [NSMutableArray new];
    
    if(self.canPanPopBackWhenAtFirstPage){
        self.fd_interactivePopDisabled = NO;
        self.relatePanParentViewController.fd_interactivePopDisabled = NO;
    }else{
        self.fd_interactivePopDisabled = YES;
        self.relatePanParentViewController.fd_interactivePopDisabled = YES;
    }
}

- (void)yh_addChildController:(UIViewController *)controller title:(NSString * _Nullable)title{
    [self yh_addChildController:controller titleConfig:^(YHPageTitleItem * _Nonnull item) {
        if(title){
            item.title = title;
        }else if (IsNonNull(controller.title)){
            item.title = title;
        }else{
            NSParameterAssert(item.title);
        }
    }];
}

- (void)yh_addChildController:(UIViewController *)controller titleConfig:(nonnull void (^)(YHPageTitleItem * _Nonnull))config{
    
    YHPageControllerItem * item = [YHPageControllerItem new];
    if(config){
        config(item.titleInfo);
    }
    item.showViewController = controller;
    if(item.titleInfo.titleShowType == YHPageTitleShowType_Title){
        controller.title = item.titleInfo.title;
    }
    item.index = self.pageControllerList.count;
    [self.pageControllerList addObject:item];
}



- (void)yh_reloadController{
    
    [self.yh_pageViewcontrollers removeAllObjects];
    for(YHPageControllerItem * item in self.pageControllerList){
        [self.yh_pageViewcontrollers addObject:item.showViewController];
    }
    
    self.segmentControl.frame = [self yh_frameForMenuView];
    if ([self yh_segmentMenuShowOnNavigationBar] && self.navigationController.navigationBar) {
        self.navigationItem.titleView = self.segmentControl;
    } else if(!self.segmentControl.superview){
        [self.view addSubview:self.segmentControl];
    }

    [self yh_reloadSegmentMenu];
    [self yh_reloadPageViewController];
    [self yh_reloadBadgeCount];
    
    self.selectIndex = [self yh_defaultSelectedIndex];
    
//    self.segmentControl.backgroundColor = [UIColor redColor];
}

/// 刷新顶部菜单
- (void)yh_reloadSegmentMenu{
    [self.segmentControl resetSegmentTitles:[self yh_getPageTitles]];
}

- (YHSegmentView *)segmentControl {
    if (!_segmentControl) {
        _segmentControl = [YHSegmentView new];
        
        WS(weakSelf)
        [self.segmentControl setSelectBlock:^(NSInteger passIndex) {
           weakSelf.selectIndex = passIndex;
        }];
    }
    return _segmentControl;
}

- (void)yh_reloadBadgeCount{
    for(NSInteger i = 0; i < self.segmentControl.segmentCount; i++){
        NSString * badgeCount = [self yh_badgeCountIndex:i];
        
        UIView * segmentItemView = [self.segmentControl getItemViewAtIndex:i];
        segmentItemView.badgeCountV.badgeCount = badgeCount;
    }
}

- (void)yh_reloadPageViewController{
    
    if (!self.pageViewController) {
        self.pageViewController = [[UIPageViewController alloc]
                                   initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                   navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                   options:nil];
        
        self.pageViewController.dataSource = self;
        self.pageViewController.delegate = self;
        [self addChildViewController:self.pageViewController];
        [self.view addSubview:self.pageViewController.view];
        
        
        if(self.canPanPopBackWhenAtFirstPage){
            //添加手势
            __block UIScrollView *scrollView = nil;
            [self.pageViewController.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj isKindOfClass:[UIScrollView class]]) {
                    scrollView = (UIScrollView *)obj;
                }
            }];
            if(scrollView){
                //新添加的手势，起手势锁的作用
                _fakePan = [UIPanGestureRecognizer new];
                _fakePan.delegate = self;
                [scrollView addGestureRecognizer:_fakePan];

                [scrollView.panGestureRecognizer requireGestureRecognizerToFail:self.navigationController.fd_fullscreenPopGestureRecognizer];
                [scrollView.panGestureRecognizer requireGestureRecognizerToFail:_fakePan];

                [_fakePan requireGestureRecognizerToFail:self.navigationController.fd_fullscreenPopGestureRecognizer];
                
                if(self.relatePanParentViewController){
                    [scrollView.panGestureRecognizer requireGestureRecognizerToFail:self.relatePanParentViewController.navigationController.fd_fullscreenPopGestureRecognizer];
                    [_fakePan requireGestureRecognizerToFail:self.relatePanParentViewController.navigationController.fd_fullscreenPopGestureRecognizer];
                }
            }
        }
    }
    
    self.pageViewController.view.frame = [self yh_frameForContentView];
    
}

- (void)yh_cleanController{
    
    [self.pageControllerList removeAllObjects];
}

#pragma mark - setter getter

-(void)setSelectIndex:(NSInteger)selectIndex{
    
    self.segmentControl.selectIndex = selectIndex;
    
    if(!self.pageViewController.viewControllers ||
       !self.pageViewController.viewControllers.firstObject ||
       ![self.pageViewController.viewControllers.firstObject isEqual:self.yh_pageViewcontrollers[selectIndex]]){
        
        [self.pageViewController setViewControllers:@[self.yh_pageViewcontrollers[selectIndex]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:^(BOOL finished) {
            
        }];
    }

    _selectIndex = selectIndex;
    
    if(self.canPanPopBackWhenAtFirstPage){
        if(selectIndex == 0){
            self.fd_interactivePopDisabled = NO;
            self.relatePanParentViewController.fd_interactivePopDisabled = NO;
        }else{
            self.fd_interactivePopDisabled = YES;
            self.relatePanParentViewController.fd_interactivePopDisabled = YES;
        }
    }
}

- (NSArray <YHPageTitleItem *>*)yh_getPageTitles{
    NSMutableArray * list = [NSMutableArray new];
    for(YHPageControllerItem * item in self.pageControllerList){
        [list addObject:item.titleInfo];
    }
    return list;
}

#pragma mark - UIPageViewControllerDataSource

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    // 计算当前 viewController 数据在数组中的下标
    NSUInteger index = [self.yh_pageViewcontrollers indexOfObject:viewController];
    // index 为 0 表示已经翻到最前页
    if (index == 0 ||index == NSNotFound) {
        return  nil;
    }
    // 下标自减
    index --;
    UIViewController * beforeVC = self.yh_pageViewcontrollers[index];
    return beforeVC;
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    // 计算当前 viewController 数据在数组中的下标
    NSUInteger index = [self.yh_pageViewcontrollers indexOfObject:viewController];
    // index为数组最末表示已经翻至最后页
    if (index == NSNotFound ||
        index == (self.yh_pageViewcontrollers.count - 1)) {
        return nil;
    }
    // 下标自增
    index ++;
    UIViewController * afterVC = self.yh_pageViewcontrollers[index];
    return afterVC;
}

// A page indicator will be visible if both methods are implemented, transition style is 'UIPageViewControllerTransitionStyleScroll', and navigation orientation is 'UIPageViewControllerNavigationOrientationHorizontal'.
// Both methods are called in response to a 'setViewControllers:...' call, but the presentation index is updated automatically in the case of gesture-driven navigation.
//- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController{
//}
//- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController{
//}
/**
 *  转场动画即将开始
 */
- (void)pageViewController:(UIPageViewController *)pageViewController
willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers{

    
}
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    if(!completed){
        return;
    }
    NSUInteger index = [self.yh_pageViewcontrollers indexOfObject:pageViewController.viewControllers.firstObject];

    self.selectIndex = index;
    
//    NSLog(@"滚动到位置 %zd", index);
}


#pragma mark - YHPageViewControllerProtocol


/// 子控制器个数
- (NSInteger)yh_countChildControllers{
    return self.pageControllerList.count;
}
/// 标题
- (YHPageTitleItem *)yh_titleAtIndex:(NSInteger)index{
    YHPageControllerItem * item = self.pageControllerList[index];
    return item.titleInfo;
}
/// 控制器
- (UIViewController *)yh_controllerAtIndex:(NSInteger)index{
    YHPageControllerItem * item = self.pageControllerList[index];
    return item.showViewController;
}
/// 控制器
- (UIViewController *)yh_currentController{
    return self.yh_pageViewcontrollers[self.selectIndex];
}

/// 内容区域大小
- (CGRect)yh_frameForContentView{
    if([self yh_segmentMenuShowOnNavigationBar]){
        return CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    }else{
        CGRect segmentFrame = [self yh_frameForMenuView];
        return CGRectMake(0, CGRectGetMaxY(segmentFrame), CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-CGRectGetMaxY(segmentFrame));
    }
}
/// 标题区域大小
- (CGRect)yh_frameForMenuView{
    double width = 0;
    if ([self yh_segmentMenuShowOnNavigationBar]) {
        width = [UIScreen mainScreen].bounds.size.width - 160;
    } else {
        width = CGRectGetWidth(self.view.frame);
    }

    return CGRectMake(0, 0, width, Adapted(44));
}
/// 初始选中位置
- (NSInteger)yh_defaultSelectedIndex{
    return 0;
}
/// 菜单显示在导航条上
- (BOOL)yh_segmentMenuShowOnNavigationBar{
    return NO;
}

/// 未读消息
- (NSString *)yh_badgeCountIndex:(NSInteger)index{
    return @"";
}


#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer
{
    if(!self.canPanPopBackWhenAtFirstPage){
        return NO;
    }

    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];

    if(self.selectIndex != 0){
        return NO;
    }
    
    if (translation.x >= 0){
        return YES;
    }else{
        return NO;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

