//
//  YHConstant.m
//  YHChart
//
//  Created by 林宁宁 on 2020/4/27.
//  Copyright © 2020 林宁宁. All rights reserved.
//

#import "YHConstant.h"
#import <objc/runtime.h>


void yh_swizzleMethod(Class theClass, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(theClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(theClass, swizzledSelector);
    
    BOOL didAddMethod = class_addMethod(theClass,
                                        originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(theClass, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else{
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}


BOOL MCIsIPad(void){
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
}

static CGFloat yh_tatio = 0;
CGFloat Adapted(CGFloat value){
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    if (yh_tatio==0) {
        if(MCIsIPad()){
            yh_tatio = (width>height?height:width)/768.0;//9.7
        }else{
            yh_tatio = (width>height?height:width)/375.0;//4.7
        }
    }
    return ceilf(yh_tatio*value);
}
static CGFloat yh_tatio_height = 0;
CGFloat AdaptedHeight(CGFloat value){
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    if (yh_tatio_height==0) {
        if(MCIsIPad()){
            yh_tatio_height = (width>height?width:height)/1024.0;//9.7
        }else{
            yh_tatio_height = (width>height?width:height)/667.0;//4.7
        }
    }
    return ceilf(yh_tatio*value);
}



BOOL IsNull(id obj){
    if(!obj){
        return YES;
    }
    if(obj == nil || [obj isEqual:[NSNull class]] || [obj isKindOfClass:[NSNull class]]){
        return YES;
    }
    if([obj isKindOfClass:[NSString class]]){
        NSString * str = (NSString *)obj;
        if([str isEqualToString:@""]){
            return YES;
        }
        if ([[str stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""]){
            return YES;
        }
    }
    return NO;
}
BOOL IsNonNull(id obj){
    return !IsNull(obj);
}


@implementation YHConstant

@end
