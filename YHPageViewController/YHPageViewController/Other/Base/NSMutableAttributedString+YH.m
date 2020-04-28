//
//  NSMutableAttributedString+YH.m
//  QNote
//
//  Created by 林宁宁 on 2017/3/12.
//  Copyright © 2017年 林宁宁. All rights reserved.
//

#import "NSMutableAttributedString+YH.h"

@implementation NSMutableAttributedString (YH)


+(instancetype)yh_initWithStr:(NSString *)str customBlock:(void (^)(NSMutableAttributedString *))customBlock
{
    if(!str)
    {
        str = @"";
    }
    
    NSMutableAttributedString * att = [[NSMutableAttributedString alloc] initWithString:str];
    
    if(customBlock)
    {
        customBlock(att);
    }
    
    return att;
}

-(void)yh_appendStr:(NSString *)str block:(void (^)(NSMutableAttributedString *, NSString *))appendBlock
{
    if(!str)
    {
        str = @"";
    }
    
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:str];
    if(appendBlock)
    {
        appendBlock(attStr,str);
    }
    
    [self appendAttributedString:attStr];    
}

-(void)yh_insertStr:(NSString *)str atIndex:(NSUInteger)loc block:(void (^)(NSMutableAttributedString *, NSString *))insertBlock
{
    if(!str)
    {
        str = @"";
    }
    
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:str];
    if(insertBlock)
    {
        insertBlock(attStr,str);
    }
    
    [self insertAttributedString:attStr atIndex:loc];
}



- (void)yh_font:(UIFont *)font
{
    NSRange range = NSMakeRange(0, [self length]);
    
    [self addAttribute:NSFontAttributeName value:font range:range];
}

- (void)yh_font:(UIFont *)font range:(NSRange)range
{
    if(NSMaxRange(range) > [self length])
    {
        return;
    }
    
    [self addAttribute:NSFontAttributeName value:font range:range];
}





- (void)yh_color:(UIColor *)color
{
    NSRange range = NSMakeRange(0, [self length]);
    
    [self addAttribute:NSForegroundColorAttributeName value:color range:range];
}

- (void)yh_color:(UIColor *)color range:(NSRange)range
{
    if(NSMaxRange(range) > [self length])
    {
        return;
    }
    
    [self addAttribute:NSForegroundColorAttributeName value:color range:range];
}



/**
 设置区域背景颜色
 */
- (void)yh_bgcolor:(UIColor *)color
{
    [self yh_bgcolor:color range:NSMakeRange(0, [self length])];
}

- (void)yh_bgcolor:(UIColor *)color range:(NSRange)range
{
    if(NSMaxRange(range) > [self length])
    {
        return;
    }
    
    if(color)
    {
        [self addAttribute:NSBackgroundColorAttributeName value:color range:range];
    }
    else
    {
        [self removeAttribute:NSBackgroundColorAttributeName range:range];
    }
}





- (void)yh_baseLineOffset:(float)offset
{
    NSRange range = NSMakeRange(0, [self length]);
    
    [self yh_baseLineOffset:offset range:range];
}

- (void)yh_baseLineOffset:(float)offset range:(NSRange)range
{
    if(NSMaxRange(range) > [self length])
    {
        return;
    }
    
    [self addAttribute:NSBaselineOffsetAttributeName value:@(offset) range:range];
}



/**
 文本字符间隔
 */
- (void)yh_characterSpacing:(NSNumber *)characterSpaceing
{
    NSRange range = NSMakeRange(0, [self length]);
    
    [self yh_characterSpacing:characterSpaceing range:range];
}

- (void)yh_characterSpacing:(NSNumber *)characterSpaceing range:(NSRange)range
{
    if(NSMaxRange(range) > [self length])
    {
        return;
    }
    
    [self addAttribute:NSKernAttributeName value:characterSpaceing range:range];
}





- (void)yh_underlineStyle:(NSUnderlineStyle)style
{
    NSRange range = NSMakeRange(0, [self length]);
    
    [self yh_underlineStyle:style range:range];
}

- (void)yh_underlineStyle:(NSUnderlineStyle)style
                    range:(NSRange)range
{
    if(NSMaxRange(range) > [self length])
    {
        return;
    }
    
    [self addAttribute:NSUnderlineStyleAttributeName value:@(style) range:range];
}


/**
 删除线
 */
- (void)yh_strikethrough:(NSUInteger)value
{
    [self yh_strikethrough:value range:NSMakeRange(0, [self length])];
}

- (void)yh_strikethrough:(NSUInteger)value
                   range:(NSRange)range
{
    if(NSMaxRange(range) > [self length])
    {
        return;
    }
    
    [self addAttribute:NSStrikethroughStyleAttributeName value:@(value) range:range];
    [self addAttribute:NSBaselineOffsetAttributeName value:@(0) range:range];
}


- (void)yh_strikethroughColor:(UIColor *)color
{
    [self yh_strikethroughColor:color range:NSMakeRange(0, [self length])];
}

- (void)yh_strikethroughColor:(UIColor *)color
                        range:(NSRange)range
{
    if(NSMaxRange(range) > [self length])
    {
        return;
    }
    
    [self addAttribute:NSStrikethroughColorAttributeName value:color range:range];
}


/**
 阴影
 */
- (void)yh_shadow:(NSShadow *)shadow
{
    [self yh_shadow:shadow range:NSMakeRange(0, [self length])];
}

- (void)yh_shadow:(NSShadow *)shadow
            range:(NSRange)range
{
    if(NSMaxRange(range) > [self length])
    {
        return;
    }
    
    [self addAttribute:NSShadowAttributeName value:shadow range:range];
}





- (void)yh_Obliqueness:(NSNumber *)value
{
    [self yh_Obliqueness:value range:NSMakeRange(0, [self length])];
}

- (void)yh_Obliqueness:(NSNumber *)value
                 range:(NSRange)range
{
    if(NSMaxRange(range) > [self length])
    {
        return;
    }
    
    [self addAttribute:NSObliquenessAttributeName value:value range:range];
}




- (void)yh_Expansion:(NSNumber *)value
{
    [self yh_Expansion:value range:NSMakeRange(0, [self length])];
}

- (void)yh_Expansion:(NSNumber *)value
               range:(NSRange)range
{
    if(NSMaxRange(range) > [self length])
    {
        return;
    }
    
    [self addAttribute:NSExpansionAttributeName value:value range:range];
}




/**
 下划线的颜色
 */
- (void)yh_underlineColor:(UIColor *)color
{
    NSRange range = NSMakeRange(0, [self length]);
    
    [self yh_underlineColor:color range:range];
}

- (void)yh_underlineColor:(UIColor *)color
                    range:(NSRange)range
{
    if(NSMaxRange(range) > [self length])
    {
        return;
    }
    
    [self addAttribute:NSUnderlineColorAttributeName value:color range:range];
}


- (void)yh_effect
{
    [self yh_effectWithRange:NSMakeRange(0, [self length])];
}

- (void)yh_effectWithRange:(NSRange)range
{
    if(NSMaxRange(range) > [self length])
    {
        return;
    }
    
    [self addAttribute:NSTextEffectAttributeName value:NSTextEffectLetterpressStyle range:range];
}



/**
 添加链接
 */
- (void)yh_linkURL:(NSURL *)url
{
    [self yh_linkURL:url range:NSMakeRange(0, [self length])];
}

- (void)yh_linkURL:(NSURL *)url
             range:(NSRange)range
{
    if(NSMaxRange(range) > [self length])
    {
        return;
    }
    
    [self addAttribute:NSLinkAttributeName value:url range:range];
}



/**
 字体的描边和颜色
 */
- (void)yh_strokeWidth:(NSNumber *)strokeWidth
{
    [self yh_strokeWidth:strokeWidth range:NSMakeRange(0, [self length])];
}

-(void)yh_strokeWidth:(NSNumber *)strokeWidth range:(NSRange)range
{
    if(NSMaxRange(range) > [self length])
    {
        return;
    }
    
    [self addAttribute:NSStrokeWidthAttributeName value:strokeWidth range:range];
}


-(void)yh_strokeColor:(UIColor *)strokeColor
{
    [self yh_strokeColor:strokeColor range:NSMakeRange(0, [self length])];
}

-(void)yh_strokeColor:(UIColor *)strokeColor range:(NSRange)range
{
    if(NSMaxRange(range) > [self length])
    {
        return;
    }
    
    if(strokeColor)
    {
        [self addAttribute:NSStrokeColorAttributeName value:strokeColor range:range];
    }
    else
    {
        [self removeAttribute:NSStrokeColorAttributeName range:range];
    }
}


//图片
- (void)yh_attachImage:(UIImage *)image
{
    [self yh_attachImage:image imageSize:CGSizeMake(image.size.width, image.size.height)];
}

- (void)yh_attachImage:(UIImage *)image imageSize:(CGSize)imgSize
{
    NSTextAttachment * attach = [[NSTextAttachment alloc] init];
    attach.image = image;
    attach.bounds = CGRectMake(0, 0, imgSize.width, imgSize.height);
    
    NSMutableAttributedString * imageStr = [[NSMutableAttributedString alloc] initWithAttributedString:[NSAttributedString attributedStringWithAttachment:attach]];
    
    [imageStr yh_baseLineOffset:-imgSize.height*0.18];
    
    [self appendAttributedString:imageStr];
}


- (void)yh_attachImage:(UIImage *)image imageSize:(CGSize)imgSize atIndex:(NSInteger)index
{
    [self yh_attachImage:image imageSize:imgSize atIndex:index imageOffset:nil];
}

- (void)yh_attachImage:(UIImage *)image imageSize:(CGSize)imgSize atIndex:(NSInteger)index imageOffset:(NSNumber *)offset
{
    if(index > self.string.length)
    {
        return;
    }
    
    CGFloat offY = 0;
//    if(offset){
//        offY = [offset floatValue];
//    }else{
//        offY = -imgSize.height*0.15;
//    }
    
    NSTextAttachment * attach = [[NSTextAttachment alloc] init];
    attach.image = image;
    if(CGSizeEqualToSize(imgSize, CGSizeZero))
    {
        attach.bounds = CGRectMake(0, offY, image.size.width, image.size.height);
    }
    else
    {
        attach.bounds = CGRectMake(0, offY, imgSize.width, imgSize.height);
    }
    
    NSMutableAttributedString * imageStr = [[NSMutableAttributedString alloc] initWithAttributedString:[NSAttributedString attributedStringWithAttachment:attach]];
    
    if(offset){
        [imageStr yh_baseLineOffset:[offset floatValue]];
    }else{
        [imageStr yh_baseLineOffset:-imgSize.height*0.15];
    }

    [self insertAttributedString:imageStr atIndex:index];
}




- (void)yh_paragraphBlock:(void (^)(NSMutableParagraphStyle *))paragraphBlock
{
    NSRange range = NSMakeRange(0, self.string.length);
    
    [self yh_paragraphBlock:paragraphBlock andRange:range];
}

- (void)yh_paragraphBlock:(void (^)(NSMutableParagraphStyle *))paragraphBlock andRange:(NSRange)range
{
    if(NSMaxRange(range) > [self length])
    {
        return;
    }
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    if(paragraphBlock)
    {
        paragraphBlock(paragraphStyle);
    }
    
    [self addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
}



///**
// 附加文字
// */
//- (void)yh_appendText:(NSString *)text config:(void (^)(NSMutableAttributedString *))customBlock{
//    
//    NSMutableAttributedString * attText = [NSMutableAttributedString yh_initWithStr:text customBlock:customBlock];
//    [self appendAttributedString:attText];
//    
//}

@end




@implementation NSAttributedString (YH)


- (CGSize)yh_getSizeConstrainedToSize:(CGSize)size{
    UILabel *tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, size.width, 0)];
    tempLabel.attributedText = self;
    tempLabel.numberOfLines = 0;
    [tempLabel sizeToFit];
    
    CGSize fitSize = tempLabel.frame.size;
    fitSize = CGSizeMake(ceil(fitSize.width), ceil(fitSize.height));
    return fitSize;
}


@end
