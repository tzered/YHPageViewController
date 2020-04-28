//
//  UIColor+YH.h
//  MoreCoin
//
//  Created by 林宁宁 on 2019/9/17.
//  Copyright © 2019 MoreCoin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, YHGradDirection) {
    YHGradDirection_top_down,
    YHGradDirection_down_top,
    YHGradDirection_left_right,
    YHGradDirection_right_left,
    
    YHGradDirection_leftTop_rightDown,//左上角->右下角
    YHGradDirection_rightDown_leftTop,
    YHGradDirection_rightTop_leftDown,
    YHGradDirection_leftDown_rightTop,
};

//#ifndef UIColorHex
//#define UIColorHex(_hex_)   [UIColor colorWithHexString:((__bridge NSString *)CFSTR(#_hex_))]
//#endif


@interface UIColor (YH)


- (UIImage *)yh_drawImageWithColor;
- (UIImage *)yh_drawImageWithColorBySize:(CGSize)imageSize;

+ (UIColor *)yh_colorWithHexString:(NSString *)color;
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)yh_colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

/** 渐变 上到下*/
+ (UIColor*)yh_gradientFroYHolor:(UIColor*)c1 toColor:(UIColor*)c2 withHeight:(NSInteger)height;
/** 渐变 左到右*/
+ (UIColor*)yh_gradientFroYHolor:(UIColor*)c1 toColor:(UIColor*)c2 withWidth:(NSInteger)width;
/**
 渐变
 @param gradCenter 中心点
 @param gradRadius 半径
 @param direction 方向
 @param locations 数值 0 到 1
 */
+ (UIColor*)yh_gradientFroYHolors:(NSArray <UIColor*>*)colors locations:(NSArray <NSNumber *>* _Nullable)locations gradCenter:(CGPoint)gradCenter gradRadius:(CGFloat)gradRadius direction:(YHGradDirection)direction;

/** 颜色平滑过渡*/
+ (UIColor *)yh_transformFroYHolor:(UIColor*)froYHolor toColor:(UIColor *)toColor progress:(CGFloat)progress;


/// 两个颜色是否相同
- (BOOL)yh_isEqualToColor:(UIColor *)toColor;

+ (UIColor *)yh_randomcolor;




@end

NS_ASSUME_NONNULL_END
