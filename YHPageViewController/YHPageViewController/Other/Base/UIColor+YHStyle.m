//
//  UIColor+YHStyle.m
//  MoreCoin
//
//  Created by 林宁宁 on 2019/9/28.
//  Copyright © 2019 MoreCoin. All rights reserved.
//

#import "UIColor+YHStyle.h"

@implementation UIColor (YHStyle)

/// 背景色
+ (UIColor *)yh_bg_view{
    return [UIColor yh_colorWithHexString:@"F6F6F6"];
}
+ (UIColor *)yh_bg_view_light{
    return [UIColor yh_colorWithHexString:@"F4F4F4"];
}
/// 导航条背景色
+ (UIColor *)yh_bg_navc{
    return [UIColor whiteColor];
}



+ (UIColor *)yh_title_navc{
    return [UIColor yh_colorWithHexString:@"333333"];
}

+ (UIColor *)yh_title_h1{
    return [UIColor yh_colorWithHexString:@"333333"];
}
+ (UIColor *)yh_title_h2{
    return [UIColor yh_colorWithHexString:@"666666"];
}
+ (UIColor *)yh_title_h3_note{
    return [UIColor yh_colorWithHexString:@"999999"];
}

+ (UIColor *)yh_text_gray {
    return [UIColor yh_colorWithHexString:@"8C9AA8"];
}

/// 分割线
+ (UIColor *)yh_separator{
    return [UIColor yh_colorWithHexString:@"EEEEEE"];
}
+ (UIColor *)yh_separator_dark{
    return [UIColor yh_colorWithHexString:@"D8D8D8"];
}
+ (UIColor *)yh_disable{
    return [UIColor yh_colorWithHexString:@"DDDDDD"];
}

+ (UIColor *)yh_black {
    return [UIColor yh_colorWithHexString:@"1E2439"];
}

+ (UIColor *)yh_blue_dark {
    return [UIColor yh_colorWithHexString:@"1678FF"];
}
+ (UIColor *)yh_blue_light{
    return [UIColor yh_colorWithHexString:@"EBF3FF"];
}
+ (UIColor *)yh_blue{
    return [UIColor yh_colorWithHexString:@"3C8BFB"];
}

+ (UIColor *)yh_red{
    return [UIColor yh_colorWithHexString:@"F66C5F"];
}
+ (UIColor *)yh_red_dark{
    return [UIColor yh_colorWithHexString:@"FF5444"];
}
+ (UIColor *)yh_gray_dark{
    return [UIColor yh_colorWithHexString:@"BBBBBB"];
}
+ (UIColor *)yh_gray{
    return [UIColor yh_colorWithHexString:@"0xCCCCCC"];
}
+ (UIColor *)yh_green{
    return [UIColor yh_colorWithHexString:@"2CB45C"];
}
+ (UIColor *)yh_orange_light{
    return [UIColor yh_colorWithHexString:@"FF661D"];
}
+ (UIColor *)yh_orange_lighter{
    return [UIColor yh_colorWithHexString:@"FF5A2C"];
}

+ (UIColor *)yh_orange{
    return [UIColor yh_colorWithHexString:@"0xFE4608"];
}

+ (UIColor *)yh_downPaymentColor {
    return [UIColor yh_gradientFroYHolor:[UIColor yh_colorWithHexString:@"1C6FFF"] toColor:[UIColor yh_colorWithHexString:@"4592FF"] withWidth:[UIScreen mainScreen].bounds.size.width];
}

+ (UIColor *)yh_stagesCustomerColor {
    return [UIColor yh_colorWithHexString:@"FFB835"];
}

+ (UIColor *)yh_stagesMerchantColor {
    return [UIColor yh_gradientFroYHolor:[UIColor yh_colorWithHexString:@"4171F9"] toColor:[UIColor yh_colorWithHexString:@"58A4FF"] withWidth:[UIScreen mainScreen].bounds.size.width];
}

/// 阴影色 黑色 0.12 透明
+ (UIColor *)yh_shadow{
    return [[UIColor blackColor] colorWithAlphaComponent:0.12];
}


+ (UIColor *)yh_data_title {
    return  [UIColor yh_colorWithHexString:@"1E2439"];
}

+(UIColor *)yh_data_subtitle {
    return [UIColor yh_colorWithHexString:@"8C9AA8"];
}

+ (UIColor *)yh_data_blue{
    return [UIColor yh_colorWithHexString:@"1678FF"];
}

@end
