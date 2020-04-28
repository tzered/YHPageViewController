//
//  UIFont+YH.h
//  MoreCoin
//
//  Created by 林宁宁 on 2019/9/17.
//  Copyright © 2019 MoreCoin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (YH)

+ (UIFont *)yh_boldSystemFontOfSize:(CGFloat)fontSize;
+ (UIFont *)yh_systemFontOfSize:(CGFloat)fontSize;
+ (UIFont *)yh_systemMediumSize:(CGFloat)fontSize;
+ (UIFont *)yh_systemSemiboldSize:(CGFloat)fontSize;
+ (UIFont *)yh_fontWithName:(NSString *)fontName size:(CGFloat)fontSize;

/** 等宽数字字体 Helvetica Neue*/
+ (UIFont *)yh_hnOfSize:(CGFloat)fontSize;
/** 等宽字体加粗*/
+ (UIFont *)yh_hnbOfSize:(CGFloat)fontSize;
/** PingFangSC-Regular */
+ (UIFont *)yh_pfOfSize:(CGFloat)fontSize;
/** PingFangSC-Medium */
+ (UIFont *)yh_pfmOfSize:(CGFloat)fontSize;
/** PingFangSC-Semibold */
+ (UIFont *)yh_pfsOfSize:(CGFloat)fontSize;
/** PingFangSC-Light */
+ (UIFont *)yh_pflOfSize:(CGFloat)fontSize;

@end

NS_ASSUME_NONNULL_END
