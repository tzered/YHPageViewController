//
//  UIColor+YH.m
//  MoreCoin
//
//  Created by 林宁宁 on 2019/9/17.
//  Copyright © 2019 MoreCoin. All rights reserved.
//

#import "UIColor+YH.h"


@implementation UIColor (YH)


- (UIImage *)yh_drawImageWithColor
{
    return [self yh_drawImageWithColorBySize:CGSizeMake(10, 10)];
}
- (UIImage *)yh_drawImageWithColorBySize:(CGSize)imageSize
{
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [self set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));

    UIImage * pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return pressedColorImg;
}



+ (UIColor *)yh_colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

//默认alpha值为1
+ (UIColor *)yh_colorWithHexString:(NSString *)color
{
    return [self yh_colorWithHexString:color alpha:1.0f];
}

+ (UIColor*)yh_gradientFroYHolor:(UIColor*)c1 toColor:(UIColor*)c2 withHeight:(NSInteger)height{
    return [UIColor yh_gradientFroYHolors:@[c1,c2] locations:nil gradCenter:CGPointZero gradRadius:height direction:(YHGradDirection_top_down)];
}

+ (UIColor *)yh_gradientFroYHolor:(UIColor *)c1 toColor:(UIColor *)c2 withWidth:(NSInteger)width{
    return [UIColor yh_gradientFroYHolors:@[c1,c2] locations:nil gradCenter:CGPointZero gradRadius:width direction:(YHGradDirection_left_right)];
}

+ (UIColor*)yh_gradientFroYHolors:(NSArray <UIColor*>*)colors locations:(NSArray <NSNumber *>* _Nullable)locations gradCenter:(CGPoint)gradCenter gradRadius:(CGFloat)gradRadius direction:(YHGradDirection)direction
{
    CGPoint startPoint = gradCenter;
    CGFloat end_x = gradCenter.x;
    CGFloat end_y = gradCenter.y;
    switch (direction) {
        case YHGradDirection_top_down:
            end_y = end_y+gradRadius;
            break;
        case YHGradDirection_down_top:
            end_y = end_y-gradRadius;
            break;
        case YHGradDirection_left_right:
            end_x = end_x+gradRadius;
            break;
        case YHGradDirection_right_left:
            end_x = end_x-gradRadius;
            break;
        case YHGradDirection_leftTop_rightDown:
            end_x = end_x+gradRadius;
            end_y = end_y+gradRadius;
            break;
        case YHGradDirection_leftDown_rightTop:
            end_x = end_x+gradRadius;
            end_y = end_y-gradRadius;
            break;
        case YHGradDirection_rightDown_leftTop:
            end_x = end_x-gradRadius;
            end_y = end_y-gradRadius;
            break;
        case YHGradDirection_rightTop_leftDown:
            end_x = end_x-gradRadius;
            end_y = end_y+gradRadius;
            break;
        default:
            break;
    }
    CGPoint endPoint = CGPointMake(end_x, end_y);
    
    CGSize size = CGSizeMake(gradRadius, gradRadius);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    
    NSMutableArray * gradColors = [NSMutableArray new];
    for(UIColor * color in colors){
        [gradColors addObject:(id)color.CGColor];
    }
    
    size_t count = locations.count;
    
    CGFloat *PosList = (CGFloat *)calloc(count,sizeof(CGFloat));
    
    for(NSNumber * num in locations){
        NSInteger index = [locations indexOfObject:num];
        PosList[index] = num.floatValue;
    }
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorspace, (__bridge CFArrayRef)gradColors, locations.count?PosList:NULL);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
    UIGraphicsEndImageContext();
    
    return [UIColor colorWithPatternImage:image];
}


+ (UIColor *)yh_transformFroYHolor:(UIColor*)froYHolor toColor:(UIColor *)toColor progress:(CGFloat)progress {
    
    progress = progress >= 1 ? 1 : progress;
    progress = progress <= 0 ? 0 : progress;
    
    const CGFloat * fromeComponents = CGColorGetComponents(froYHolor.CGColor);
    const CGFloat * toComponents = CGColorGetComponents(toColor.CGColor);
    
    size_t  froYHolorNumber = CGColorGetNumberOfComponents(froYHolor.CGColor);
    size_t  toColorNumber = CGColorGetNumberOfComponents(toColor.CGColor);
    
    if (froYHolorNumber == 2) {
        CGFloat white = fromeComponents[0];
        froYHolor = [UIColor colorWithRed:white green:white blue:white alpha:1];
        fromeComponents = CGColorGetComponents(froYHolor.CGColor);
    }
    
    if (toColorNumber == 2) {
        CGFloat white = toComponents[0];
        toColor = [UIColor colorWithRed:white green:white blue:white alpha:1];
        toComponents = CGColorGetComponents(toColor.CGColor);
    }
    
    CGFloat r = fromeComponents[0]*(1 - progress) + toComponents[0]*progress;
    CGFloat g = fromeComponents[1]*(1 - progress) + toComponents[1]*progress;
    CGFloat b = fromeComponents[2]*(1 - progress) + toComponents[2]*progress;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}


/// 两个颜色是否相同
- (BOOL)yh_isEqualToColor:(UIColor *)toColor{
    if(CGColorEqualToColor(self.CGColor, toColor.CGColor)){
        return YES;
    }
    return NO;
}

+ (UIColor *)yh_randomcolor{
    
    return [UIColor colorWithRed:(arc4random()%255)/255.0 green:(arc4random()%255)/255.0 blue:(arc4random()%255)/255.0 alpha:1];
}


@end
