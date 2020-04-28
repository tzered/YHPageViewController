//
//  UIView+YH.m
//  MoreCoin
//
//  Created by 林宁宁 on 2019/9/23.
//  Copyright © 2019 MoreCoin. All rights reserved.
//

#import "UIView+YH.h"
#import <objc/runtime.h>
#import "YHKit.h"


@implementation UIView (YH)





/** 顶部圆角*/
- (void)cornerTop:(float)corner{
    [self corner:corner pos:UIRectCornerTopLeft | UIRectCornerTopRight];
}
/** 左部圆角*/
- (void)cornerLeft:(float)corner
{
    [self corner:corner pos:UIRectCornerTopLeft | UIRectCornerBottomLeft];
}
/** 底部圆角*/
- (void)cornerBottom:(float)corner{
    [self corner:corner pos:UIRectCornerBottomLeft | UIRectCornerBottomRight];
}
/** 右部圆角*/
- (void)cornerRight:(float)corner
{
    [self corner:corner pos:UIRectCornerTopRight | UIRectCornerBottomRight];
}

- (void)cornerAll:(float)corner{
    [self corner:corner pos:UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight];
}

- (void)corner:(float)corner pos:(UIRectCorner)corners{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if(CGRectIsNull(self.bounds)){
            return;
        }
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(corner, corner)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.bounds;
        maskLayer.path = maskPath.CGPath;
        self.layer.mask = maskLayer;
    });
}

- (void)cornerNone{
    if(!self.layer.mask){
        return;
    }
    self.layer.mask = nil;
}




/** uiview转成图片*/
- (UIImage *)yh_drawToImage{

    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。
    //如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;

}

/** 判断View是否显示在屏幕上*/
- (BOOL)yh_isDisplayedInScreen{
    
    if(!self.window){
        return NO;
    }
    
    if (self == nil) {
        return FALSE;
    }
    CGRect screenRect = [UIScreen mainScreen].bounds;
    
    // 转换view对应window的Rect
    CGRect rect = [self convertRect:self.bounds toView:nil];
    if (CGRectIsEmpty(rect) || CGRectIsNull(rect)) {
        return FALSE;
    }
    // 若view 隐藏
    if (self.hidden) {
        return FALSE;
    }
    // 若没有superview
    if (self.superview == nil) {
        return FALSE;
    }
    // 若size为CGrectZero
    if (CGSizeEqualToSize(rect.size, CGSizeZero)) {
        return  FALSE;
    }
    // 获取 该view与window 交叉的 Rect
    CGRect intersectionRect = CGRectIntersection(rect, screenRect);
    if (CGRectIsEmpty(intersectionRect) || CGRectIsNull(intersectionRect)) {
        return FALSE;
    }
    return TRUE;
}

- (UIViewController *)yh_currentViewController{
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next !=nil);
    return nil;
}


@end




@implementation UIView(YHShadow)

-(CALayer *)yh_shadowLayer{
    return objc_getAssociatedObject(self, @selector(yh_shadowLayer));
}
-(void)setyh_shadowLayer:(CALayer *)yh_shadowLayer{
    objc_setAssociatedObject(self, @selector(yh_shadowLayer), yh_shadowLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


/** 添加阴影*/
- (void)yh_addShadow:(void (^_Nullable)(CALayer *))shadowConfig{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self yh_cleanShadow];
        
        CALayer *subLayer = [CALayer layer];
        self.yh_shadowLayer = subLayer;
        CGRect fixframe = self.frame;
        subLayer.frame = fixframe;
        subLayer.cornerRadius = self.layer.cornerRadius;
        subLayer.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3].CGColor;
        subLayer.masksToBounds = NO;
        subLayer.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.3].CGColor;
        subLayer.shadowOffset = CGSizeMake(3,3);
        subLayer.shadowOpacity = 1;
        subLayer.shadowRadius = 5;//阴影半径，默认3
        if(shadowConfig){
            shadowConfig(subLayer);
        }
        [self.superview.layer insertSublayer:subLayer below:self.layer];
    });
}

- (void)yh_renderShadow{
    [self yh_renderShadow:^(CALayer * _Nullable shadowLayer) {
        shadowLayer.shadowColor = [UIColor yh_shadow].CGColor;
        shadowLayer.shadowOffset = CGSizeZero;
        shadowLayer.shadowRadius = 10;
        shadowLayer.shadowOpacity = 0.4;
        shadowLayer.cornerRadius = 4;
    }];
}

- (void)yh_renderShadow:(void (^_Nullable)(CALayer *))shadowConfig{
    self.clipsToBounds = NO;
    if(shadowConfig){
        shadowConfig(self.layer);
    }
}

-(void)yh_cleanShadow{
    if(self.yh_shadowLayer != nil){
        [self.yh_shadowLayer removeFromSuperlayer];
        self.yh_shadowLayer = nil;
    }
}

@end
