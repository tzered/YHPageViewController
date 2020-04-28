//
//  UIColor+YHStyle.h
//  MoreCoin
//
//  Created by 林宁宁 on 2019/9/28.
//  Copyright © 2019 MoreCoin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+YH.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (YHStyle)


/// 背景色  F6F6F6
+ (UIColor *)yh_bg_view;
/// 背景色 F4F4F4
+ (UIColor *)yh_bg_view_light;
/// 导航条背景色
+ (UIColor *)yh_bg_navc;

/// 导航字体 333333
+ (UIColor *)yh_title_navc;

/// 主标题  333333
+ (UIColor *)yh_title_h1;
/// 副标题  666666
+ (UIColor *)yh_title_h2;
/// 注释字体 999999
+ (UIColor *)yh_title_h3_note;
/** 灰色字体 8C9AA8 */
+ (UIColor *)yh_text_gray;

/// 分割线 EEEEEE
+ (UIColor *)yh_separator;
/// 分割线2 D8D8D8
+ (UIColor *)yh_separator_dark;

/// 失效状态 DDDDDD
+ (UIColor *)yh_disable;

/** 黑色 1E2439 */
+ (UIColor *)yh_black;

/** 深蓝色 1678FF */
+ (UIColor *)yh_blue_dark;
/// 浅蓝色 EBF3FF
+ (UIColor *)yh_blue_light;
/// 蓝色 3C8BFB
+ (UIColor *)yh_blue;
/// 红色 F66C5F
+ (UIColor *)yh_red;
/// 红色深 FF5444
+ (UIColor *)yh_red_dark;
/// 灰色 CCCCCC
+ (UIColor *)yh_gray;
/// 灰色深 BBBBBB
+ (UIColor *)yh_gray_dark;
/// 绿色 2CB45C
+ (UIColor *)yh_green;

/// 橙色 FE4608
+ (UIColor *)yh_orange;
/// 橙色浅 FF661D
+ (UIColor *)yh_orange_light;
/// 橙色浅 FF5A2C
+ (UIColor *)yh_orange_lighter;

/// 阴影色 黑色 0.12 透明
+ (UIColor *)yh_shadow;

/** 分期购收付款渐变色 */
+ (UIColor *)yh_downPaymentColor;

/** 分期购用户颜色 */
+ (UIColor *)yh_stagesCustomerColor;

/** 分期购商家渐变色 */
+ (UIColor *)yh_stagesMerchantColor;

/** 数据分析的标题颜色 */
+ (UIColor *)yh_data_title;
/** 数据分析的副标题颜色 */
+(UIColor *)yh_data_subtitle;
/** 数据分析的蓝色 */
+ (UIColor *)yh_data_blue;



@end

NS_ASSUME_NONNULL_END
