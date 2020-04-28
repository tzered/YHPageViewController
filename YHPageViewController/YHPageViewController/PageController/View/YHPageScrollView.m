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


@interface YHPageScrollView()

@property (assign, nonatomic) BOOL otherScrollViewIsAtTop;

@property (weak, nonatomic) UIScrollView * currentTouchView;

@property (assign, nonatomic) CGFloat offsetYOther;
@property (assign, nonatomic) CGFloat offsetYSelf;

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

    self.offsetYOther = 0;
    self.offsetYSelf = 0;
    if(self.currentTouchView){
        [self.currentTouchView removeObserver:self forKeyPath:@"contentOffset"];
    }
    self.currentTouchView = nil;

    UIView * hitView = [super hitTest:point withEvent:event];

    UIView * superview = hitView;

    while (superview) {
        if([superview isKindOfClass:[UIScrollView class]] &&
           ![superview isKindOfClass:[YHPageScrollView class]] &&
           ![[superview yh_currentViewController] isKindOfClass:[UIPageViewController class]]){
            
            self.currentTouchView = (UIScrollView *)superview;

            [self.currentTouchView addObserver:self
                                    forKeyPath:@"contentOffset"
                                       options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                                       context:nil];

            return hitView;
        }
        superview = superview.superview;
    }
    
    return hitView;
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(UIScrollView *)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    CGPoint offset = [change[NSKeyValueChangeNewKey] CGPointValue];
    [self contentOffsetChange:offset scrollView:object];
}

- (void)contentOffsetChange:(CGPoint)offset scrollView:(UIScrollView *)scrollView{

    if([scrollView isEqual:self]){

//        NSLog(@"  %f  __ %f  __%f",offset.y,self.contentOffset.y,self.currentTouchView.contentOffset.y);

        if(offset.y >= self.maxOffsetY){
            offset = CGPointMake(0, self.maxOffsetY);
            [self setScrollViewContentOffset:offset scrollView:scrollView];
        }
        else{
            if(self.currentTouchView.contentOffset.y > 0){
                if(self.contentOffset.y != self.maxOffsetY){
                    [self setScrollViewContentOffset:CGPointZero scrollView:self.currentTouchView];

                    self.currentTouchView.showsVerticalScrollIndicator = NO;
                    self.showsVerticalScrollIndicator = YES;
                }
                else{
                    self.offsetYSelf = self.maxOffsetY - offset.y;

                    offset = CGPointMake(0, self.maxOffsetY);
                }
            }else{

                [self setScrollViewContentOffset:CGPointZero scrollView:self.currentTouchView];

                self.currentTouchView.showsVerticalScrollIndicator = NO;
                self.showsVerticalScrollIndicator = YES;
//                offset.y = offset.y + self.offsetYSelf;
            }
        }

        if(self.didScrollBlock){
            self.didScrollBlock(offset.y);
        }
    }
    else{
//        NSLog(@"   %f __ %f  __%f __",offset.y,scrollView.contentOffset.y,self.offsetYSelf);

        if(self.contentOffset.y < 0){
            [self setScrollViewContentOffset:CGPointZero scrollView:scrollView];
            return;
        }

        if(offset.y > 0){
            //还未定住 不跟着一起往上滚
            if(self.contentOffset.y >= self.maxOffsetY){

                if(scrollView.contentOffset.y == 0){
                    if(self.offsetYOther == 0){
                        self.offsetYOther = offset.y;
                    }
                }

                offset.y = offset.y - self.offsetYOther;
            }else{
                if(scrollView.contentOffset.y == 0){
                    offset = CGPointZero;
                }
            }

            self.currentTouchView.showsVerticalScrollIndicator = YES;
            self.showsVerticalScrollIndicator = NO;
        }
        else{
            [self setScrollViewContentOffset:CGPointZero scrollView:scrollView];
        }
    }
}

- (void)setScrollViewContentOffset:(CGPoint)offset scrollView:(UIScrollView *)scrollView{
    if(CGPointEqualToPoint(scrollView.contentOffset, offset)){
        return;
    }
    [scrollView 那个:offset];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{

    //如果是 pagevc 则当前Pan手势不处理
    UIViewController * otherVC = [otherGestureRecognizer.view yh_currentViewController];

    if([otherVC isKindOfClass:[UIPageViewController class]]){
        return NO;
    }
    return YES;
    
}


-(void)dealloc{
    [self.currentTouchView removeObserver:self forKeyPath:@"contentOffset"];
    [self removeObserver:self forKeyPath:@"contentOffset"];
}

@end
