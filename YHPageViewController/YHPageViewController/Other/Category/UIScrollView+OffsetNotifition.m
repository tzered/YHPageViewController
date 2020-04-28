//
//  UIScrollView+OffsetNotifition.m
//  MoreCoin
//
//  Created by 林宁宁 on 2020/4/23.
//  Copyright © 2020 MoreCoin. All rights reserved.
//

#import "UIScrollView+OffsetNotifition.h"
#import "YHConstant.h"
#import <objc/runtime.h>


@implementation UIScrollView (OffsetNotifition)

+ (void)load {

    yh_swizzleMethod(self, @selector(setContentOffset:), @selector(yh_setContentOffset:));
}


-(void (^)(CGPoint,UIScrollView *))contentOffsetBlock{
    return objc_getAssociatedObject(self, @selector(contentOffsetBlock));
}
-(void)setContentOffsetBlock:(void (^)(CGPoint,UIScrollView * ))contentOffsetBlock{
    objc_setAssociatedObject(self, @selector(contentOffsetBlock), contentOffsetBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(CGPoint (^)(CGPoint,UIScrollView *))contentOffsetResetBlock{
    return objc_getAssociatedObject(self, @selector(contentOffsetResetBlock));
}
-(void)setContentOffsetResetBlock:(CGPoint (^)(CGPoint, UIScrollView * _Nonnull))contentOffsetResetBlock{
    objc_setAssociatedObject(self, @selector(contentOffsetResetBlock), contentOffsetResetBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}





- (void)yh_setContentOffset:(CGPoint)offset {
    
    if(self.contentOffsetBlock){
        self.contentOffsetBlock(offset, self);
    }
    if(self.contentOffsetResetBlock){
        offset =  self.contentOffsetResetBlock(offset, self);
    }
    
    [self yh_setContentOffset:offset];
}

@end
