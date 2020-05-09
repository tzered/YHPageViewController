//
//  YHPageScrollView.m
//  YHPageViewController
//
//  Created by 林宁宁 on 2020/4/28.
//  Copyright © 2020 林宁宁. All rights reserved.
//

#import "YHPageScrollView.h"
#import "YHConstant.h"
#import "UIView+YH.h"
#import <objc/runtime.h>


@interface YHPageScrollView()

@property (weak, nonatomic) UIScrollView * currentTouchView;

@property (assign, nonatomic) CGFloat offsetYPreSelf;
@property (assign, nonatomic) CGFloat offsetYPreOther;

/// 点击的scrollview是否可下拉刷新
@property (assign, nonatomic) BOOL canPullRefreshOther;
//@property (assign, nonatomic) BOOL canPullRefreshSelf;

//@property (assign, nonatomic) CGFloat originOffsetYOther;
//@property (assign, nonatomic) CGFloat originOffsetYSelf;

@end


@implementation YHPageScrollView


-(instancetype)init{
    self = [super init];
    if(self){

        [self addObserver:self
               forKeyPath:@"contentOffset"
                  options:NSKeyValueObservingOptionNew
                  context:nil];
        
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return self;
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{

    self.canPullRefreshOther = NO;
    self.offsetYPreSelf = 0;
    self.offsetYPreOther = 0;
    if(self.currentTouchView){
        [self.currentTouchView removeObserver:self forKeyPath:@"contentOffset"];
    }
    self.currentTouchView = nil;
    
    
    UIView * hitView = [super hitTest:point withEvent:event];

    UIView * superview = hitView;

    while (superview) {
        if([superview isKindOfClass:[UIScrollView class]] &&
           ![superview isKindOfClass:[YHPageScrollView class]] &&
           ![[superview yh_currentViewController] isKindOfClass:[UIPageViewController class]] &&
           ![superview.superview isKindOfClass:NSClassFromString(@"YHSegmentView")]){
            
            self.currentTouchView = (UIScrollView *)superview;

            [self.currentTouchView addObserver:self
                                    forKeyPath:@"contentOffset"
                                       options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                                       context:nil];
            break;
        }
        superview = superview.superview;
    }
    
    self.offsetYPreSelf = self.contentOffset.y;
    self.offsetYPreOther = self.currentTouchView.contentOffset.y;
    
    BOOL(^canPullRefesh)(UIScrollView * scrollview) = ^BOOL(UIScrollView * scrollview) {
        //假设使用的下拉刷新控件是MJRefresh
        SEL headSelector = NSSelectorFromString(@"mj_header");
        if([self.currentTouchView respondsToSelector:headSelector]){
            #pragma clang diagnostic push
            #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            UIView * headView = (UIView *)[self.currentTouchView performSelector:headSelector];
            #pragma clang diagnostic pop
            if(headView){
                return YES;
            }
        }
        return NO;
    };
//    self.canPullRefreshSelf = canPullRefesh(self);
    self.canPullRefreshOther = canPullRefesh(self.currentTouchView);
    
//    self.originOffsetYOther = self.currentTouchView.contentOffset.y;
//    self.originOffsetYSelf = self.contentOffset.y;
    
    return hitView;
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(UIScrollView *)scrollView change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    CGPoint offset = [change[NSKeyValueChangeNewKey] CGPointValue];
    [self contentOffsetChange:offset scrollView:scrollView];
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{

    //如果是 pagevc 则当前Pan手势不处理
    UIViewController * otherVC = [otherGestureRecognizer.view yh_currentViewController];

    if([otherVC isKindOfClass:[UIPageViewController class]]){
        return NO;
    }
    return YES;
    
}

- (void)contentOffsetChange:(CGPoint)offset scrollView:(UIScrollView *)scrollView{
    
    if([scrollView isEqual:self]){
        
        //NSLog(@"1111    %f  _ %f  __%f __",self.offsetYPreSelf,scrollView.contentOffset.y,self.currentTouchView.contentOffset.y);

        if(self.offsetYPreSelf == scrollView.contentOffset.y){
            return;
        }
        
        BOOL isPanDown = (self.offsetYPreSelf > scrollView.contentOffset.y);
        self.offsetYPreSelf = scrollView.contentOffset.y;
        
        
        
        if(isPanDown){
            //NSLog(@"1111 往下滚动");
            if(self.canPullRefreshOther &&
               self.currentTouchView.contentOffset.y < 0 &&
               self.contentOffset.y <= 0){
               
               [self setScrollViewContentOffset:CGPointZero scrollView:scrollView];
               self.currentTouchView.showsVerticalScrollIndicator = YES;
               self.showsVerticalScrollIndicator = NO;
               return;
            }
            
            //其他视图有上移 距离的 等他完全拖拽完之后 再开始下移
            if(self.currentTouchView.contentOffset.y > 0){
               
                [self setScrollViewContentOffset:CGPointMake(0, self.maxOffsetY) scrollView:scrollView];
                self.currentTouchView.showsVerticalScrollIndicator = YES;
                self.showsVerticalScrollIndicator = NO;
                return;
            }
        }else{
            //NSLog(@"1111 往上滚动");
            if(self.canPullRefreshOther &&
                self.currentTouchView.contentOffset.y < 0 &&
                self.contentOffset.y >= 0){
                
                [self setScrollViewContentOffset:CGPointZero scrollView:scrollView];
                self.currentTouchView.showsVerticalScrollIndicator = YES;
                self.showsVerticalScrollIndicator = NO;
                return;
             }
            
            //顶部滑动超过这个距离之后 不在往上滚动
            if(scrollView.contentOffset.y >= self.maxOffsetY){
                [self setScrollViewContentOffset:CGPointMake(0, self.maxOffsetY) scrollView:scrollView];
                self.currentTouchView.showsVerticalScrollIndicator = YES;
                self.showsVerticalScrollIndicator = NO;
                return;
            }
        }
        
        if(self.didScrollBlock){
            self.didScrollBlock(offset.y);
        }
        
        return;
    }
    
    /// 其他的scrollview
    
    //NSLog(@"222222     %f  __ %f  __%f __",self.offsetYPreOther,scrollView.contentOffset.y,self.contentOffset.y);
        
        
    if(self.contentOffset.y < 0){
        if(self.canPullRefreshOther){
            //可以下拉刷新 当前scrollview不让他下拉
            [self setScrollViewContentOffset:CGPointZero scrollView:self];
            self.currentTouchView.showsVerticalScrollIndicator = YES;
            self.showsVerticalScrollIndicator = NO;
            self.offsetYPreOther = scrollView.contentOffset.y;
        }else{
            [self setScrollViewContentOffset:CGPointZero scrollView:scrollView];
            self.currentTouchView.showsVerticalScrollIndicator = NO;
            self.showsVerticalScrollIndicator = YES;
            self.offsetYPreOther = scrollView.contentOffset.y;
            return;
        }
    }
    
    if(self.offsetYPreOther == scrollView.contentOffset.y){
        return;
    }
    
    BOOL isPanDown = (self.offsetYPreOther > scrollView.contentOffset.y);
    self.offsetYPreOther = scrollView.contentOffset.y;

    if(isPanDown){
        //NSLog(@"2222 往下滚动");
        if(self.contentOffset.y < self.maxOffsetY){
            //顶部正在拉出来
            if(self.canPullRefreshOther &&
               scrollView.contentOffset.y <= 0 &&
               self.contentOffset.y <= 0){
                //下拉刷新的正在回弹
                self.currentTouchView.showsVerticalScrollIndicator = YES;
                self.showsVerticalScrollIndicator = NO;
            }else{
                [self setScrollViewContentOffset:CGPointZero scrollView:scrollView];
                self.currentTouchView.showsVerticalScrollIndicator = NO;
                self.showsVerticalScrollIndicator = YES;
            }
        }
    }else{
        //NSLog(@"2222 往上滚动");
        if(self.contentOffset.y < self.maxOffsetY){
            //顶部还未收起来
            if(self.canPullRefreshOther &&
               scrollView.contentOffset.y <= 0 &&
               self.contentOffset.y <= 0){
                //下拉刷新的正在回弹
                self.currentTouchView.showsVerticalScrollIndicator = YES;
                self.showsVerticalScrollIndicator = NO;
            }else{
                [self setScrollViewContentOffset:CGPointZero scrollView:scrollView];
                self.currentTouchView.showsVerticalScrollIndicator = NO;
                self.showsVerticalScrollIndicator = YES;
            }
        }
    }
}



- (void)setScrollViewContentOffset:(CGPoint)offset scrollView:(UIScrollView *)scrollView{
    if(CGPointEqualToPoint(scrollView.contentOffset, offset)){
        return;
    }
    [scrollView setContentOffset:offset];
}

-(void)dealloc{
    [self.currentTouchView removeObserver:self forKeyPath:@"contentOffset"];
    [self removeObserver:self forKeyPath:@"contentOffset"];
}

@end
