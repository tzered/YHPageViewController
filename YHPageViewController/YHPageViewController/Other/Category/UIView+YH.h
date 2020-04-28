//
//  UIView+YH.h
//  MoreCoin
//
//  Created by 林宁宁 on 2019/9/23.
//  Copyright © 2019 MoreCoin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (YH)


/** 顶部圆角*/
- (void)cornerTop:(float)corner;
/** 左部圆角*/
- (void)cornerLeft:(float)corner;
/** 底部圆角*/
- (void)cornerBottom:(float)corner;
/** 右部圆角*/
- (void)cornerRight:(float)corner;
/** 四个圆角 */
- (void)cornerAll:(float)corner;
- (void)corner:(float)corner pos:(UIRectCorner)corners;
/** 无圆角*/
- (void)cornerNone;

/** uiview转成图片*/
- (UIImage *)yh_drawToImage;


/** 判断View是否显示在屏幕上*/
- (BOOL)yh_isDisplayedInScreen;


- (UIViewController *)yh_currentViewController;


@end



@interface UIView(YHShadow)

@property (retain, nonatomic) CALayer * _Nullable yh_shadowLayer;
/** 添加阴影*/
- (void)yh_addShadow:(void (^ _Nullable)(CALayer * _Nullable shadowLayer))shadowConfig;
- (void)yh_renderShadow:(void (^_Nullable)(CALayer * _Nullable shadowLayer))shadowConfig;
- (void)yh_renderShadow;
- (void)yh_cleanShadow;

@end



NS_ASSUME_NONNULL_END
