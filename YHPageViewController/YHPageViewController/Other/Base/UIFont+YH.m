//
//  UIFont+YH.m
//  MoreCoin
//
//  Created by 林宁宁 on 2019/9/17.
//  Copyright © 2019 MoreCoin. All rights reserved.
//

#import "UIFont+YH.h"

#ifndef YH_IOS9
#define YH_IOS9 ([[[UIDevice currentDevice]systemVersion]floatValue] >=9.0)
#endif


@implementation UIFont (YH)


+ (UIFont *)yh_boldSystemFontOfSize:(CGFloat)fontSize{
//    fontSize = Adapted(fontSize);
    return [UIFont boldSystemFontOfSize:fontSize];
}

+ (UIFont *)yh_systemFontOfSize:(CGFloat)fontSize{
//    fontSize = Adapted(fontSize);
    return [UIFont systemFontOfSize:fontSize];
}
+ (UIFont *)yh_systemMediumSize:(CGFloat)fontSize{
    return [UIFont systemFontOfSize:fontSize weight:UIFontWeightMedium];
}
+ (UIFont *)yh_systemSemiboldSize:(CGFloat)fontSize{
    return [UIFont systemFontOfSize:fontSize weight:UIFontWeightSemibold];
}

+ (UIFont *)yh_fontWithName:(NSString *)fontName size:(CGFloat)fontSize{
//    fontSize = Adapted(fontSize);
    return [UIFont fontWithName:fontName size:fontSize];
}
+ (UIFont *)yh_hnOfSize:(CGFloat)fontSize{
    return [self yh_fontWithName:YH_IOS9 ? @"Helvetica Neue" : @"Helvetica" size:fontSize];
}
+ (UIFont *)yh_hnbOfSize:(CGFloat)fontSize{
    return [self yh_fontWithName:YH_IOS9 ? @"HelveticaNeue-Bold" : @"Helvetica" size:fontSize];
}

/** PingFangSC-Regular */
+ (UIFont *)yh_pfOfSize:(CGFloat)fontSize{
    return [self yh_fontWithName:YH_IOS9 ? @"PingFangSC-Regular" : @"Helvetica"  size:fontSize];
}
/** PingFangSC-Medium */
+ (UIFont *)yh_pfmOfSize:(CGFloat)fontSize{
    return [self yh_fontWithName:YH_IOS9 ? @"PingFangSC-Medium" : @"Helvetica" size:fontSize];
}
/** PingFangSC-Semibold */
+ (UIFont *)yh_pfsOfSize:(CGFloat)fontSize{
    return [self yh_fontWithName:YH_IOS9 ? @"PingFangSC-Semibold" : @"Helvetica" size:fontSize];
}
/** PingFangSC-Light */
+ (UIFont *)yh_pflOfSize:(CGFloat)fontSize{
    return [self yh_fontWithName:YH_IOS9 ? @"PingFangSC-Light" : @"Helvetica" size:fontSize];
}

@end
