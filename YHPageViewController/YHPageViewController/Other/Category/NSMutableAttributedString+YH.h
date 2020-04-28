//
//  NSMutableAttributedString+YH.h
//  QNote
//
//  Created by 林宁宁 on 2017/3/12.
//  Copyright © 2017年 林宁宁. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSMutableAttributedString (YH)


/**
 创建一个AttributeString
 */
+(instancetype)yh_initWithStr:(NSString *)str customBlock:(void(^)(NSMutableAttributedString * att))customBlock;

/**
 追加Attribute字符
 */
- (void)yh_appendStr:(NSString *)str block:(void(^)(NSMutableAttributedString * attStr, NSString * str))appendBlock;


/**
 插入Attribute字符
 */
- (void)yh_insertStr:(NSString *)str atIndex:(NSUInteger)loc block:(void(^)(NSMutableAttributedString * attStr, NSString * str))insertBlock;








/**
 设置字体
 */
- (void)yh_font:(UIFont *)font;

- (void)yh_font:(UIFont *)font range:(NSRange)range;



/**
 设置颜色
 */
- (void)yh_color:(UIColor *)color;

- (void)yh_color:(UIColor *)color range:(NSRange)range;




/**
 设置区域背景颜色
 */
- (void)yh_bgcolor:(UIColor *)color;

- (void)yh_bgcolor:(UIColor *)color range:(NSRange)range;




/**
 baseline偏移
 */
- (void)yh_baseLineOffset:(float)offset;

- (void)yh_baseLineOffset:(float)offset range:(NSRange)range;



/**
 文本字符间隔
 */
- (void)yh_characterSpacing:(NSNumber *)characterSpaceing;

- (void)yh_characterSpacing:(NSNumber *)characterSpaceing range:(NSRange)range;




/**
 添加下划线

 NSUnderlineStyleNone 不设置
 NSUnderlineStyleSingle 下划线 细
 NSUnderlineStyleThick 下划线 粗
 NSUnderlineStyleDouble 下划线 双线
 
 NSUnderlinePatternSolid 连续实线
 NSUnderlinePatternDot 虚线
 NSUnderlinePatternDash 破折线
 NSUnderlinePatternDashDot 破折线和虚线
 NSUnderlinePatternDashDotDot 破折线和虚线虚线
 
 NSUnderlineByWord 有字符的地方设置 空格的地方就空的
 */
- (void)yh_underlineStyle:(NSUnderlineStyle)style;

- (void)yh_underlineStyle:(NSUnderlineStyle)style
                             range:(NSRange)range;



/**
 删除线 线条粗细
 */
- (void)yh_strikethrough:(NSUInteger)value;

- (void)yh_strikethrough:(NSUInteger)value
                   range:(NSRange)range;

/**
 删除线颜色
 */
- (void)yh_strikethroughColor:(UIColor *)color;

- (void)yh_strikethroughColor:(UIColor *)color
                        range:(NSRange)range;



/**
 下划线的颜色
 */
- (void)yh_underlineColor:(UIColor *)color;

- (void)yh_underlineColor:(UIColor *)color
                    range:(NSRange)range;


/**
 阴影
 */
- (void)yh_shadow:(NSShadow *)shadow;

- (void)yh_shadow:(NSShadow *)shadow
            range:(NSRange)range;



/**
 文本的特殊效果 目前只有 NSTextEffectLetterpressStyle 这个一个效果
 */
- (void)yh_effect;

- (void)yh_effectWithRange:(NSRange)range;




/**
 字体倾斜

 @param value 正值右倾斜 负值左倾斜
 */
- (void)yh_Obliqueness:(NSNumber *)value;

- (void)yh_Obliqueness:(NSNumber *)value
                 range:(NSRange)range;




/**
 文本横向拉伸

 @param value 正值横向拉伸 负值横向压缩
 */
- (void)yh_Expansion:(NSNumber *)value;

- (void)yh_Expansion:(NSNumber *)value
               range:(NSRange)range;



/**
 添加链接
 */
- (void)yh_linkURL:(NSURL *)url;

- (void)yh_linkURL:(NSURL *)url
             range:(NSRange)range;



/**
 字体的描边和颜色 负值填充 正值中空
 */
- (void)yh_strokeWidth:(NSNumber *)strokeWidth;
- (void)yh_strokeWidth:(NSNumber *)strokeWidth range:(NSRange)range;

- (void)yh_strokeColor:(UIColor *)strokeColor;
- (void)yh_strokeColor:(UIColor *)strokeColor range:(NSRange)range;





/**
 附加图片
 */
- (void)yh_attachImage:(UIImage *)image;

- (void)yh_attachImage:(UIImage *)image imageSize:(CGSize)imgSize;

- (void)yh_attachImage:(UIImage *)image imageSize:(CGSize)imgSize atIndex:(NSInteger)index;

- (void)yh_attachImage:(UIImage *)image imageSize:(CGSize)imgSize atIndex:(NSInteger)index imageOffset:(NSNumber *)offset;




/**
 *  段落
 *  param lineSpacing               行间距
 *  param paragraphSpacing          段落间距
 *  param alignment                 文字对齐格式
 *  param firstLineHeadIndent       首行缩进
 *  param headIndent                行首缩进
 *  param tailIndent                行尾缩进
 *  param lineBreakMode             段落文字溢出隐藏方式
 *  param minimumLineHeight         最小行高
 *  param maximumLineHeight         最大行高
 *  param baseWritingDirection      段落书写方向
 *  param lineHeightMultiple        多行行高
 *  param paragraphSpacingBefore    段落前间距
 *  param hyphenationFactor         英文断字连字符
 */
- (void)yh_paragraphBlock:(void(^)(NSMutableParagraphStyle * style))paragraphBlock;

- (void)yh_paragraphBlock:(void(^)(NSMutableParagraphStyle * style))paragraphBlock andRange:(NSRange)range;



/**
 附加文字
 */
//- (void)yh_appendText:(NSString *)text config:(void(^)(NSMutableAttributedString * att))customBlock;







@end


@interface NSAttributedString (YH)


/**
 计算高度

 @param size 区域大小限制
 @return 大小
 */
- (CGSize)yh_getSizeConstrainedToSize:(CGSize)size;



@end
